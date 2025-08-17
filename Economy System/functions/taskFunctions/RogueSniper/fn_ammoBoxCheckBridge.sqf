params ["_container","_caller","_actionId","_cls","_min","_max"];
if (!isServer) exitWith {};
[_container, _caller, _actionId, _cls, _min, _max] execVM "Economy System\functions\FN_ammoBoxCheck.sqf";