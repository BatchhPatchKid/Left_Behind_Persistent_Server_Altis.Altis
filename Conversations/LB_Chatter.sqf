/*
  LB_Chatter.sqf — Ambient conversations + simple combat shouts (registry-based)
  ---------------------------------------------------------------------------
  - Server-only. No EHs.
  - Faction is read from the central registry (LB_FacReg_Get).
  - Conversations are authored via LB_Conversations() (data-only).
  - Delivery: remoteExec ["globalChat", players within _RADIUS of SPEAKER].

  Start in initServer.sqf AFTER the registry:
    if (isServer) then {
      [] execVM "LB_FactionRegistry.sqf";
      [] execVM "LB_Chatter.sqf";
    };


if (!isServer) exitWith {};

// ---------------------------
// Config
// ---------------------------
private _RADIUS= 50;     // hearing radius
private _TICK = 0.25;    // scheduler cadence (single loop)
private _AMBIENT_START_PROB = 0.25;   // chance to start a convo when eligible
private _AMBIENT_COOLDOWN_SEC  = 120;    // cooldown after a conversation ends/aborts
private _COMBAT_SPEAK_COOLDOWN = 0;      // min seconds between combat shouts (per group)
private _DEBUG = false;  // set true to spam RPT

// Ambient/combat audience locking
private _LOCK_SEC_PER_LINE = 0;   // estimate to size an ambient convo lock
private _LOCK_GRACE_SEC = 1;
private _AMBIENT_LOCK_MIN = 1;   // ambient must occupy audience at least this long (sec)
private _COMBAT_LOCK_MIN = 0;   // combat lines do not lock audience (sec)

// ---------------------------
// Data sources
// ---------------------------
// Conversations DB provider
private _dbGetter = missionNamespace getVariable [
  "LB_Conversations",
  { createHashMapFromArray [["ambient",createHashMap],["combat",createHashMap]] }
];
private _db = [] call _dbGetter;
private _ambientDB = _db get "ambient";
private _combatDB  = _db get "combat";

// Faction registry accessors
private _RegGet = missionNamespace getVariable [
  "LB_FacReg_Get",
  { params ['_g','_d']; _d }
];

private _RegHas = missionNamespace getVariable [
  "LB_FacReg_Has",
  { false }
];

private _dlog = {
  if (_DEBUG) then { diag_log text format ["[LB_Chatter] %1", _this]; };
};

// ---------------------------
// Helpers
// ---------------------------
private _inCombat = {
  params ["_grp"];
  private _ldr = leader _grp;
  if (isNull _ldr) exitWith { true };
  (behaviour _ldr) isEqualTo "COMBAT" || { (combatMode _grp) isEqualTo "RED" }
};

private _pickAmbientConv = {
  params ["_fac"];
  private _pool = _ambientDB getOrDefault [_fac, _ambientDB get "*"];
  if (isNil "_pool" || {count _pool == 0}) exitWith { [] };
  selectRandom _pool
};

private _pickCombatLine = {
  params ["_fac"];
  private _pool = _combatDB getOrDefault [_fac, _combatDB get "*"];
  if (isNil "_pool" || {count _pool == 0}) exitWith { "Contact!" };
  selectRandom _pool
};

// --- Dual audience locks: separate channels for ambient/combat
private _audLocks = missionNamespace getVariable [
  "LB_AudLocks",
  createHashMapFromArray [
    ["ambient", createHashMap],
    ["combat",  createHashMap]
  ]
];
missionNamespace setVariable ["LB_AudLocks", _audLocks];

private _isLocked = {
  // (_uid, _kind) -> bool
  params ["_uid","_kind"];
  private _m = _audLocks get _kind;
  (_m getOrDefault [_uid, 0]) > time
};

private _lockUIDs = {
  // (_uids[], _kind, _seconds)
  params ["_uids","_kind","_seconds"];
  private _m = _audLocks get _kind;
  private _until = time + (_seconds max 0);
  { _m set [_x, _until]; } forEach _uids;
};

// _say: optionally restrict delivery to a fixed audience (UID list)
private _say = {
  // params: [speaker, text, optional uids[]]
  params ["_speaker", "_text", ["_uids", []]];
  if (isNull _speaker || { _text isEqualTo "" }) exitWith {};

  private _aud = allPlayers select {
    alive _x
    && { _x distance _speaker <= _RADIUS }
    && { _uids isEqualTo [] || { (getPlayerUID _x) in _uids } }
  };
  if (_aud isEqualTo []) exitWith {};

  [_speaker, _text] remoteExec ["globalChat", _aud, false];
};

// ---------------------------
// Script-local state (no object vars)
// Keys here are stringified group handles for convenience
// ---------------------------
private _convos     = createHashMap; // gid -> [grpRef, plan[], idx, nextSpeakTime, audienceUIDs[]]
private _cooldown   = createHashMap; // gid -> ambient ready time
private _nextCombat = createHashMap; // gid -> earliest combat bark time

// ---------------------------
// Single scheduler loop
// ---------------------------
while { true } do {
  private _now = time;

  // 1) Step active conversations that are due
  {
    private _gid = _x;
    private _rec = _convos get _gid;
    if (isNil "_rec") then { continue };
    _rec params ["_grpRef", "_plan", "_idx", "_tNext", "_uids"];

    // Abort if group invalid or flipped to combat
    if (isNull _grpRef) then { _convos deleteAt _gid; continue };
    if ([_grpRef] call _inCombat) then {
      _convos deleteAt _gid;
      _cooldown set [_gid, _now + _AMBIENT_COOLDOWN_SEC];
      continue
    };

    if (_now >= _tNext) then {
      private _ldr = leader _grpRef;
      if (isNull _ldr || {!alive _ldr}) then { _convos deleteAt _gid; continue };

      private _step = _plan select _idx;
      _step params ["_role", "_text", "_min", "_max"];

      // Resolve speaker now
      private _spk = if (_role isEqualTo "LEADER") then {
        _ldr
      } else {
        private _cands = (units _grpRef) select { alive _x && { _x != _ldr } && { !isPlayer _x } };
        if (_cands isEqualTo []) then { _ldr } else { selectRandom _cands }
      };

      // Speak to the conversation's fixed audience (if any of them are still in range)
      [_spk, _text, _uids] call _say;

      // Advance or finish
      private _nextIdx = _idx + 1;
      if (_nextIdx >= count _plan) then {
        _convos deleteAt _gid;
        _cooldown set [_gid, _now + _AMBIENT_COOLDOWN_SEC];
      } else {
        private _delay = _min + random (_max - _min max 0);
        _convos set [_gid, [_grpRef, _plan, _nextIdx, _now + _delay, _uids]];
      };
    };
    sleep 0.1;
  } forEach (keys _convos);

  // 2) Collect eligible leaders near any player (≤ _RADIUS)
  private _leaders = [];
  {
    private _plr = _x; if (!isPlayer _plr || {!alive _plr}) then { continue };
    {
      private _u = _x;
      if (isNull _u || { !alive _u } || { isPlayer _u }) then { continue };
      private _g = group _u; if (isNull _g) then { continue };
      private _ldr = leader _g;
      if (!isNull _ldr && { alive _ldr } && { !isPlayer _ldr } && { _plr distance _ldr <= _RADIUS }) then {
        _leaders pushBackUnique _ldr;
      };
      sleep 0.1;
    } forEach ((getPosATL _plr) nearEntities ["Man", _RADIUS]);
    sleep 0.1;
  } forEach allPlayers;

  // 3) For each leader: branch (combat vs ambient)
  {
    private _ldr = _x;
    private _grp = group _ldr;
    private _gid = str _grp;

    // If a conversation is running, it was already stepped — skip starting/barking here
    if (!isNil { _convos get _gid }) then { continue };

    private _engineCombat = ([_grp] call _inCombat);

    if (_engineCombat) then {
      // Simple combat bark, rate-limited per group (ignores ambient locks)
      private _nextOk = _nextCombat getOrDefault [_gid, 0];
      if (_now >= _nextOk && { [_grp] call _RegHas }) then {
        private _fac  = [_grp, "*"] call _RegGet;
        private _line = [_fac] call _pickCombatLine;

        // Audience: players in range that are not blocked by *combat* lock (ambient lock is ignored)
        private _aud0 = allPlayers select { alive _x && { _x distance _ldr <= _RADIUS } };
        private _aud  = _aud0 select { !([getPlayerUID _x, "combat"] call _isLocked) };

        if !(_aud isEqualTo []) then {
          private _cuids = _aud apply { getPlayerUID _x };
          [_ldr, _line, _cuids] call _say;
          [_cuids, "combat", _COMBAT_LOCK_MIN] call _lockUIDs;
        };

        _nextCombat set [_gid, _now + _COMBAT_SPEAK_COOLDOWN];
      };
    } else {
      // Ambient: respect cooldown + chance gate, then start a conversation
      private _readyAt = _cooldown getOrDefault [_gid, 0];
      if (_now >= _readyAt && { random 1 < _AMBIENT_START_PROB } && { [_grp] call _RegHas }) then {
        // Players in range, not already locked by AMBIENT
        private _aud0 = allPlayers select { alive _x && { _x distance _ldr <= _RADIUS } };
        private _aud  = _aud0 select { !([getPlayerUID _x, "ambient"] call _isLocked) };
        if (_aud isEqualTo []) then { continue };

        private _fac  = [_grp, "*"] call _RegGet;       // resolve once for convo selection
        private _plan = [_fac] call _pickAmbientConv;
        if (_plan isEqualTo []) then { continue };

        // Lock these players for the whole conversation (min 2s)
        private _convSecs = ((count _plan) * _LOCK_SEC_PER_LINE + _LOCK_GRACE_SEC) max _AMBIENT_LOCK_MIN;
        private _uids = _aud apply { getPlayerUID _x };
        [_uids, "ambient", _convSecs] call _lockUIDs;

        // Start convo and carry audience UIDs through steps
        _convos set [_gid, [_grp, _plan, 0, _now, _uids]];
      };
    };
    sleep 0.1;
  } forEach _leaders;

  // 4) Snooze
  sleep _TICK;
};