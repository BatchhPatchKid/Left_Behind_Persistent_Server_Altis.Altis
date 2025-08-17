/*
  LB_fnc_spawnRogueSniper
  Runs on: SERVER
*/

params ["_caller","_container","_actionId","_taskId"];
if (!isServer) exitWith {};

createCenter independent;

private _pos = [getPos _caller, 1000, 2500, 5, 0, 20, 0] call BIS_fnc_findSafePos;
private _stoneSaver = "Land_BluntStone_01" createVehicle _pos;

private _grp = createGroup [independent, true];
private _ai  = _grp createUnit ["I_G_Survivor_F", _pos, [], 15, "NONE"];

// equipment
private _rifle = selectRandom [
  "rhs_weap_svds_npz","rhs_weap_svdp_wd_npz","srifle_DMR_07_ghex_F",
  "arifle_MXM_Black_F","rhs_weap_mk17_LB","rhs_weap_sr25_ec_wd"
];
private _scope = selectRandom ["optic_DMS","optic_SOS","optic_AMS"];

[_ai, _rifle, 5] call BIS_fnc_addWeapon;
_ai addPrimaryWeaponItem _scope;

removeUniform _ai;
private _uniformPool = [
  "U_I_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard",
  "U_O_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard",
  "U_B_FullGhillie_ard","U_B_FullGhillie_lsh","U_B_FullGhillie_sard",
  "U_O_T_FullGhillie_tna_F","U_B_T_FullGhillie_tna_F"
];
private _pick = selectRandom _uniformPool;
_ai forceAddUniform _pick;

_ai setUnitPos "MIDDLE";

// initial waypoint
private _wp0 = _grp addWaypoint [[_pos, 200, 400, 5, 0, 20, 0] call BIS_fnc_findSafePos, 0];
_wp0 setWaypointType "MOVE";
_wp0 setWaypointBehaviour "COMBAT";

// task title/desc
private _title = "Eliminate the Rogue Sniper";
private _desc  = "Eliminate the target to earn $100. The sniper will be within 500 meters of the objective marker. It does not matter if you or someone else kills him, just make sure the job gets done.";

// send task creation down to the caller’s client
[_taskId, _pos, _caller, _title, _desc] remoteExec ["LB_fnc_createSniperTask", _caller];

// monitor loop
[_caller, _container, _actionId, _taskId, _ai, _grp, _pos, _stoneSaver] spawn {
  params ["_caller","_container","_actionId","_taskId","_ai","_grp","_pos","_stoneSaver"];

  waitUntil { sleep 0.5; !isNull _ai };

  while {true} do {
    if (!alive _caller) exitWith {
      [_taskId,"CANCELED"] remoteExec ["LB_fnc_updateSniperTaskState", _caller];
    };
    if (!alive _ai) exitWith {
      [_taskId,"SUCCEEDED"] remoteExec ["LB_fnc_updateSniperTaskState", _caller];
      [_container, _actionId] remoteExec ["LB_fnc_paySniperReward", _caller];
    };

    private _closest = objNull;
    private _minD = 1e9;
    {
      private _d = _ai distance _x;
      if (_d < _minD) then { _minD = _d; _closest = _x; };
    } forEach allPlayers;

    for "_i" from 0 to (count waypoints _grp - 1) do { deleteWaypoint [_grp, 0]; };

    if (!isNull _closest && { _minD < 300 }) then {
      private _w1 = _grp addWaypoint [getPos _closest, 0];
      _w1 setWaypointType "MOVE";
      _w1 setWaypointBehaviour "COMBAT";
    } else {
      private _w2 = _grp addWaypoint [[_pos, 200, 400, 5, 0, 20, 0] call BIS_fnc_findSafePos, 0];
      _w2 setWaypointType "MOVE";
      _w2 setWaypointBehaviour "COMBAT";
    };

    sleep 10;
  };

  deleteVehicle _stoneSaver;
};