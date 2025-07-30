params ["_container", "_caller", "_actionId", "_arguments"];

if (isNull (currentTask _caller)) then {
	private _eligiblePlayers = []; // Array to store eligible players
	private _minDistance = 1000; // Minimum distance in meters

	{
		if ((_caller distance _x) > _minDistance && _x != _caller) then {
			_eligiblePlayers pushBack _x;
		};
	} forEach playableUnits;
	
	if (count _eligiblePlayers <= 0) then {
		hintSilent "Sorry, but we couldn't find any eligible players for the task. Make sure one or more players are at least 1km away";
	} else {
		_rndDouble = random 100;
		_rndTaskID = str (_rndDouble);
		_playerSelected = selectRandom _eligiblePlayers;
		[_caller, _rndTaskID, [format ["Eliminate %1 to earn $200. It does not matter if you or someone else kills him, just make sure the job gets done. You have 1 hour to complete this task.", (name _playerSelected)], "Eliminate the Player"], objNull, "ASSIGNED", 0, true, "kill", false] call BIS_fnc_taskCreate;
		sleep 5;
		_sleepCounter = 0;
		while {true} do { // Checking to see if the task has been complete
			if (isNull (currentTask _caller)) exitWith {
				//the task was canceled
			};
			if (not alive _playerSelected) exitWith {
				if (isNull _playerSelected) then {
					[_rndTaskID,"CANCELED"] call BIS_fnc_taskSetState; 
					[_rndTaskID, true] call BIS_fnc_deleteTask;
					hintSilent "We have lost the postion of the target. Thus, the contract has been canceled.";
					sleep 5;
					hintSilent "";
				} else {
					[_rndTaskID,"SUCCEEDED"] call BIS_fnc_taskSetState; 
					[_rndTaskID, true] call BIS_fnc_deleteTask;
					hintSilent "Task has been completed, receive your reward at the contractor's office";
					for "_i" from 1 to 200 do {
						if (_caller canAddItemToBackpack "rvg_money") then {
							_caller addItemToBackpack "rvg_money"; 
							hintSilent format ["All of the amount owed to you ($%2) has been put in your backpack, %1. Good work out there.", (name _caller), 200];
						} else {
							[_container, _caller, _actionId, "rvg_money", 1, 1] call (missionNamespace getVariable "FN_ammoBoxCheck");
							hintSilent format ["It seems your backpack was full or missing %1. The remaining or full amount has been put into a ammo box at the original assigning contractors location", (name _caller)];
						};
					};
					sleep 5;
					hintSilent "";
				};
			};
			if (not alive _caller) exitWith {
				[_rndTaskID,"CANCELED"] call BIS_fnc_taskSetState; 
				[_rndTaskID, true] call BIS_fnc_deleteTask;
				hintSilent "We have lost the postion of the target. Thus, the contract has been canceled.";
				sleep 5;
				hintSilent "";
			};
			_sleepCounter = _sleepCounter + 5;
			sleep 5;
			if (_sleepCounter >= 3600) exitWith {
				[_rndTaskID,"FAILED"] call BIS_fnc_taskSetState; 
				[_rndTaskID, true] call BIS_fnc_deleteTask;
				hintSilent "You have exhausted the 60 minutes time limit; thus, the task has been deemed a failure";
				sleep 5;
				hintSilent "";
			};
		};
	};
} else {
	hintSilent "Sorry, but it seems you already have a task assigned. Finish that one before accepting another.";
};