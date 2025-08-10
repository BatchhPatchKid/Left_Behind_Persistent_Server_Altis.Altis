/* LB_FactionRegistry.sqf — server-only
if (!isServer) exitWith {};

if (isNil "LB_FactionRegistry") then {
  missionNamespace setVariable ["LB_FactionRegistry",createHashMap];
};

// SET: (Group, Key) -> void
missionNamespace setVariable [
  "LB_FacReg_Set",
  compileFinal "
    params ['_grp','_key'];
    if (isNull _grp) exitWith {};
    private _reg = missionNamespace getVariable ['LB_FactionRegistry', createHashMap];
    _reg set [netId _grp, _key];
    missionNamespace setVariable ['LB_FactionRegistry', _reg];
  "
];

// HAS
missionNamespace setVariable [
  "LB_FacReg_Has",
  compileFinal "
    params ['_grp'];
    if (isNull _grp) exitWith {false};
    private _reg = missionNamespace getVariable ['LB_FactionRegistry', createHashMap];
    !isNil { _reg get (netId _grp) }
  "
];

// GET
missionNamespace setVariable [
  "LB_FacReg_Get",
  compileFinal "
    params ['_grp','_default'];
    private _reg = missionNamespace getVariable ['LB_FactionRegistry', createHashMap];
    _reg getOrDefault [netId _grp, _default]
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