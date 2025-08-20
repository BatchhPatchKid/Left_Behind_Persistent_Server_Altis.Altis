/*
  radSystem.sqf  — Option A (additive writes)
  -------------------------------------------------
  - Tick runs on each client (hasInterface).
  - Every write to "Rad" is ADDITIVE to the current networked value,
    so external setVariable writes aren’t overwritten (“last write wins” avoided).
  - No CfgFunctions required. All helpers are defined here.
  - Minimal remoteExec: only for server-side damage/unconscious and local say3D on owner.
*/


// ======================= CONFIG / CONSTANTS =======================

params ["_player"];

// Lists from your FN_arrayReturn helper
private _CBRN = ["cbrnSuits"] call (missionNamespace getVariable "FN_arrayReturn");
private _MASK = ["gasMasks"]  call (missionNamespace getVariable "FN_arrayReturn");

// Idol classes (keep concise; prefer tagging in editor if possible)
private _IDOL_CLASSES = [
  "Land_AncientStatue_02_F","Land_AncientStatue_01_F",
  "Land_PalmTotem_01_F","Land_PalmTotem_02_F",
  "DSA_Idol2","DSA_Idol"
];

private _IDOL_R     = 1500;
private _MUT_R      = 25;
private _E10        = exp 10;
private _IDOL_SCALE = 499 / (_E10 - 1);
private _MUT_SCALE  = 29  / (_E10 - 1);

// Scan cadence / movement thresholds
private _SCAN_INTERVAL = 10;   // seconds between far scans
private _MIN_MOVE      = 15;   // meters to trigger rescan

// ========================= HELPERS ===============================

LB_fnc_underRoof = {
  params ["_unit"];
  private _p0 = eyePos _unit;
  private _hits = lineIntersectsSurfaces [
    _p0, _p0 vectorAdd [0,0,50],
    _unit, objNull, true, 1, "GEOM", "FIRE"
  ];
  (count _hits) > 0
};

LB_fnc_rainRad = {
  private _r = rain;
  if (_r <= 0.10) exitWith {0};
  if (_r <= 0.15) exitWith {0.05};
  if (_r <= 0.30) exitWith {0.10};
  if (_r <= 0.50) exitWith {0.15};
  if (_r <= 0.70) exitWith {0.20};
  if (_r <= 0.90) exitWith {0.25};
  0.30
};

LB_fnc_collectIdols = {
  params ["_unit", "_classes", "_radius"];
  nearestObjects [_unit, _classes, _radius]
};

// REQUIREMENT: Tag mutants on spawn:
//   _unit setVariable ["isRadMutant", true, true];
LB_fnc_collectMutants = {
  params ["_unit", "_radius"];
  private _near = _unit nearEntities ["CAManBase", _radius];
  _near select { _x getVariable ["isRadMutant", false] }
};

LB_fnc_gearFactors = {
  // returns [cbrnFactor, maskFactor, newUniform, newGoggles]
  params ["_unit", "_cbrnList", "_maskList", "_lastUniformGoggles"]; // ["",""]
  _lastUniformGoggles params ["_lu","_lg"];

  private _u = uniform _unit;
  private _g = goggles _unit;

  private _cbrn = 1;
  private _mask = 1;

  if ((_u != _lu) || (_g != _lg)) then {
    _cbrn = if (_u in _cbrnList) then {0.30} else {1};
    _mask = if (_g in _maskList)  then {0.75} else {1};
    if (_cbrn < 1 && _mask < 1) then { _cbrn = 0.05; _mask = 0.20; };
  } else {
    // unchanged gear: keep defaults (1,1); caller maintains cached factors
  };

  [_cbrn, _mask, _u, _g]
};

LB_fnc_geiger = {
  params ["_unit", "_radsTaken"];
  if (!("rvg_Geiger" in (itemsWithMagazines _unit))) exitWith {};
  private _owner = owner _unit;
  if (_radsTaken > 1)     exitWith { [_unit, ["rvg_geiger_3", 100, 1]] remoteExecCall ["say3D", _owner]; };
  if (_radsTaken > 0.5)   exitWith { [_unit, ["rvg_geiger_0", 100, 1]] remoteExecCall ["say3D", _owner]; };
  if (_radsTaken > 0.1)   exitWith { [_unit, ["rvg_geiger_2", 100, 1]] remoteExecCall ["say3D", _owner]; };
  if (_radsTaken > 0.05)  exitWith { [_unit, ["rvg_geiger_1", 100, 1]] remoteExecCall ["say3D", _owner]; };
};

LB_fnc_highExposureEffects = {
  params ["_unit", "_radValue"];
  if (_radValue <= 90) exitWith {};
  // Local camera shake on owner (tick runs client-side; just do it)
  addCamShake [0.5, 1, 10];

  if (_radValue > 100) then {
    // Fatal damage on server
    [_unit, 1] remoteExecCall ["setDamage", 2];
  };

  // Rare blackout via ACE on server
  if ((random 10) < 1) then {
    [_unit, true, 15] remoteExecCall ["ace_medical_fnc_setUnconscious", 2];
  };
};


// ===================== MAIN TICK FUNCTION ========================

/*
  LB_fnc_radiationTick (Option A: additive writes)
  - Runs on owning client for responsiveness.
  - Writes to "Rad" are always based on the CURRENT networked value:
      curr = unit getVariable ["Rad", 0];
      unit setVariable ["Rad", curr + delta, true];
  - This prevents external setVariable writes from being overwritten.
*/
LB_fnc_radiationTick = {
  params ["_unit","_CBRN","_MASK","_IDOL_CLASSES","_IDOL_R","_MUT_R","_IDOL_SCALE","_MUT_SCALE","_SCAN_INTERVAL","_MIN_MOVE"];
  if (isNull _unit) exitWith {};

  // caches
  private _lastPos = getPosWorld _unit;
  private _lastIdolScan = -1;
  private _idols = [];
  private _mutants = [];
  private _lastU = "";
  private _lastG = "";
  private _cbrnF = 1;
  private _maskF = 1;

  // Ensure Rad exists (so first additive works predictably)
  if (isNil { _unit getVariable "Rad" }) then {
    _unit setVariable ["Rad", 0, true];
  };

  private _tick = 5;

  while { true } do {
    waitUntil { sleep 0.2; alive _unit };

    private _now = time;
    private _pos = getPosWorld _unit;
    private _movedFar = (_pos distance _lastPos) > _MIN_MOVE;

    // Refresh caches sparsely
    if (_movedFar || (_now - _lastIdolScan > _SCAN_INTERVAL)) then {
      _idols = [_unit, _IDOL_CLASSES, _IDOL_R] call LB_fnc_collectIdols;
      _lastIdolScan = _now;
      _lastPos = _pos;
    };
    _mutants = [_unit, _MUT_R] call LB_fnc_collectMutants;

    // Curves
    private _idolMul = 0;
    {
      private _d = _unit distance _x;
      if (_d < _IDOL_R) then {
        _idolMul = _idolMul + 1 + (exp((_IDOL_R - _d) / 200) - 1) * _IDOL_SCALE;
      };
    } forEach _idols;

    private _mutMul = 0;
    {
      private _d = _unit distance _x;
      if (_d < _MUT_R) then {
        _mutMul = _mutMul + 1 + (exp((_MUT_R - _d) / 2.5) - 1) * _MUT_SCALE;
      };
    } forEach _mutants;

    private _idx = 0;
    if ((count _idols)   > 0) then { _idx = _idx + 1 };
    if ((count _mutants) > 0) then { _idx = _idx + 1 };

    private _underRoof = [_unit] call LB_fnc_underRoof;
    private _rainRad   = if (!_underRoof) then { call LB_fnc_rainRad } else { 0 };
    if (_rainRad > 0) then { _idx = _idx + 1 };

    private _waterRad =
      if (surfaceIsWater (getPos _unit) && isNull (objectParent _unit)) then { _idx = _idx + 1; 3 } else { 0 };

    // Gear factors (recompute only on change)
    private _gear = [_unit, _CBRN, _MASK, [_lastU, _lastG]] call LB_fnc_gearFactors;
    _gear params ["_newC","_newM","_newU","_newG"];
    if ((_newU != _lastU) || (_newG != _lastG)) then {
      _cbrnF = _newC; _maskF = _newM;
      _lastU = _newU; _lastG = _newG;
    };

    if (_idx > 0) then {
      private _f = _cbrnF * _maskF;
      private _radsTaken = ((0.03 * _idolMul) + (0.01 * _mutMul) + _rainRad + _waterRad) * _f;

      // Local geiger
      [_unit, _radsTaken] call LB_fnc_geiger;

      // ADDITIVE WRITE — read current networked value, then add
      private _curr = _unit getVariable ["Rad", 0];
      _unit setVariable ["Rad", (_curr + _radsTaken) max 0, true];

      // Effects based on the updated value
      private _radNow = _unit getVariable ["Rad", 0];
      [_unit, _radNow] call LB_fnc_highExposureEffects;
    } else {
      // Cooldown: subtract 0.5 rads (additive write, not absolute)
      private _curr = _unit getVariable ["Rad", 0];
      _unit setVariable ["Rad", (_curr - 0.5) max 0, true];
      // optional: back off when quiet
      // _tick = 10;  // keep or remove up to you; fixed 5s is fine too
    };

    sleep _tick;
  };
};


// ======================= BOOTSTRAP (CLIENT) ======================
// Start the tick on each client for their local player.
if (hasInterface) then {
	_player setVariable ["Rad", 0, true];
	[_player, _CBRN, _MASK, _IDOL_CLASSES, _IDOL_R, _MUT_R, _IDOL_SCALE, _MUT_SCALE, _SCAN_INTERVAL, _MIN_MOVE] spawn LB_fnc_radiationTick;
};