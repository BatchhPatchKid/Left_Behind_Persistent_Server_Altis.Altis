params ["_container", "_caller", "_actionId"];
if (isNull (currentTask _caller)) then {
	hintSilent "You didn't have an tasks assigned...";
} else {
	[_caller call BIS_fnc_taskCurrent,"CANCELED"] call BIS_fnc_taskSetState; 
	[_caller call BIS_fnc_taskCurrent, true] call BIS_fnc_deleteTask;
	hintSilent "Task has been successfully canceled - Warning, the targets could still at large, so do if you encounter them and eliminate them, you will not receive a reward as you canceled the task";
};