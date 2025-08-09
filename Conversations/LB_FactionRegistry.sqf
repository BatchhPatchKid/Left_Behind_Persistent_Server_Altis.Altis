// LB_FactionRegistry.sqf — server-only
if (!isServer) exitWith {};

missionNamespace setVariable ["LB_FactionRegistry", createHashMap];

// SET: (Group, Key) -> void
missionNamespace setVariable [
  "LB_FacReg_Set",
  compileFinal "
    params ['_grp','_key'];
    if (isNull _grp) exitWith {};
    private _reg = missionNamespace getVariable 'LB_FactionRegistry';
    private _h = hashValue _grp;
    _reg set [_h, [_grp, _key]];
  "
];

// GET: (Group, Default) -> Key
missionNamespace setVariable [
  "LB_FacReg_Get",
  compileFinal "
    params ['_grp','_def'];
    if (isNull _grp) exitWith { _def };
    private _reg = missionNamespace getVariable 'LB_FactionRegistry';
    private _rec = _reg getOrDefault [hashValue _grp, [objNull, _def]];
    _rec select 1
  "
];

// HAS: (Group) -> bool  | true if the group exists in the registry
missionNamespace setVariable [
  "LB_FacReg_Has",
  compileFinal "
    params ['_grp'];
    if (isNull _grp) exitWith {false};
    private _reg = missionNamespace getVariable 'LB_FactionRegistry';
    !isNil { _reg get (hashValue _grp) }
  "
];

// PRUNE: remove dead/empty groups
missionNamespace setVariable [
  "LB_FacReg_Prune",
  compileFinal "
    private _reg = missionNamespace getVariable 'LB_FactionRegistry';
    {
      private _k = _x;
      private _rec = _reg get _k;
      private _g = _rec select 0;
      if (isNull _g || {count units _g == 0}) then {
        _reg deleteAt _k;
      };
    } forEach (keys _reg);
  "
];