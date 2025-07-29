params ["_pos", "_minDist", "_maxDist"];
		
_aim = 0.3;
_aimSpeed = 0.5;
_spot = 0.4;
_courage = 1;
_aimShake = 0.4;
_command = .9;
_spotDist = 0.5;
_reload = 0.6;
		
private _grp1 = createGroup east;

private _newAI = _grp1 createUnit ["O_G_Soldier_F", _pos, [], 1, "NONE"];
["Renegade", _newAI, false, false, false] call (missionNamespace getVariable "FN_equipAI");

_newAI setCombatMode "RED";
_newAI setBehaviour "COMBAT";
_newAI enableAI "TARGET";
_newAI enableAI "AUTOTARGET";
_newAI enableAI "MOVE";   
_newAI enableAI "ANIM";    
_newAI enableAI "FSM";

_newAI setSkill ["aimingAccuracy", _aim];
_newAI setSkill ["aimingSpeed", _aimSpeed];
_newAI setSkill ["spotTime", _spot];
_newAI setSkill ["courage", _courage];
_newAI setSkill ["aimingShake", _aimShake];
_newAI setSkill ["commanding", _command];
_newAI setSkill ["spotDistance", _spotDist];
_newAI setSkill ["reloadSpeed", _reload];

_grp1 enableGunLights "ForceOn";

_posWP = [_pos, _minDist, _maxDist, 3, 0, 20, 0] call BIS_fnc_findSafePos;
// Create waypoints for the patrol
_waypoint1 = _grp1 addWaypoint [_posWP, 2];
_waypoint1 setWaypointType "MOVE";
_waypoint1 setWaypointSpeed "FULL";
_waypoint1 setWaypointBehaviour "AWARE";
_posWP = [_pos, _minDist, _maxDist, 3, 0, 20, 0] call BIS_fnc_findSafePos;
_waypoint2 = _grp1 addWaypoint [_posWP, 2];
_waypoint2 setWaypointType "MOVE";
_waypoint2 setWaypointSpeed "FULL";
_waypoint2 setWaypointBehaviour "AWARE";
_posWP = [_pos, _minDist, _maxDist, 3, 0, 20, 0] call BIS_fnc_findSafePos;
_waypoint3 = _grp1 addWaypoint [_posWP, 2];
_waypoint3 setWaypointType "CYCLE";
_waypoint3 setWaypointSpeed "FULL";
_waypoint3 setWaypointBehaviour "AWARE";

waitUntil {!isNull _newAI};

_newAI addRating -900000;