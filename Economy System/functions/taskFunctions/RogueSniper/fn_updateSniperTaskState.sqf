params ["_taskId","_state"];
[_taskId, _state] call BIS_fnc_taskSetState;
if (_state in ["SUCCEEDED","CANCELED"]) then { [_taskId, true] call BIS_fnc_deleteTask; };