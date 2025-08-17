// Economy System\functions\taskFunctions\RogueSniper\fn_createSniperTask.sqf
params ["_taskId","_pos","_caller","_title","_desc"];

if (!hasInterface) exitWith {};

// Optional: if you really want to sanity-check, verify we're on the same machine as _caller.
// This is less brittle than direct object comparison:
if (!isNull _caller && {!local _caller}) exitWith {};

// Create the task for this client
[player, _taskId, [_desc, _title, ""], _pos, "ASSIGNED", 0, true, "kill", false] call BIS_fnc_taskCreate;

// Tiny confirmation so you know this fired on the client
systemChat format ["Task assigned: %1", _title];