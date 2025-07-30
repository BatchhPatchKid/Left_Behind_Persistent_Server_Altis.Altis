params ["_container", "_caller", "_actionId"];
if (isNull (currentTask _caller)) then {
	_numUnits = round (random 8)+5;
	hintSilent format ["The mutant horde has a bounty put on them. Eliminate all %2 for a reward, %1", (name _caller), _numUnits];
	_minDist = 1000;
	_maxDist = 2500;
	_pos = [getPos _caller, _minDist, _maxDist, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	
	//keeps everything within 500 meters from despawning
	_stoneSaver = "Land_BluntStone_01" createVehicle _pos;
	_totemSaver = "Land_PalmTotem_01_F" createVehicle _pos;
	
	private _aiGroup = [];
	private _horde = createGroup east;
	private _ZedType = selectRandom ["Zombie_Special_OPFOR_Leaper_1", "Zombie_Special_OPFOR_Leaper_2"];
	for "_i" from 1 to _numUnits do { 
		private _hordeUnit = _horde createUnit [_ZedType, [_pos, 5, 50, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos, [], 20, "NONE"];
		_aiGroup pushBack _hordeUnit;
	};
	
	_waypoint1 = _horde addWaypoint [([_pos, 200, 400, 5, 0, 20, 0] call BIS_fnc_findSafePos), 0];
	_waypoint1 setWaypointType "MOVE";
	_waypoint1 setWaypointBehaviour "COMBAT";
	
	_rndDouble = random 100;
	_rndTaskID = str (_rndDouble);

	[_caller, _rndTaskID, [format ["Eliminate all %1 mutants to earn $200. The mutants will be within 500 meters of the objective marker. It does not matter if you or someone else kills him, just make sure the job gets done.", _numUnits], "Eliminate the Leaper Mutants", ""], _pos, "ASSIGNED", 0, true, "kill", false] call BIS_fnc_taskCreate;
	sleep 5;
	private _allDead = false;
	while {!_allDead} do { // Checking to see if the task has been complete
		if ((isNull (currentTask _caller))) exitWith {
			//simply leaving the loop if the player has canceled the task
			deleteVehicle _stoneSaver;
			deleteVehicle _totemSaver;
		};
		_allDead = true; // Assume all are dead until proven otherwise
        {
            if (!isNull _x && alive _x) exitWith {
                _allDead = false;
            };
        } forEach _aiGroup;
		_allNull = true;
		{
            if (!isNull _x) exitWith {
                _allNull = false;
            };
        } forEach _aiGroup;
		if (_allDead) exitWith {
			if (_allNull) then {
				[_rndTaskID,"CANCELED"] call BIS_fnc_taskSetState; 
				[_rndTaskID, true] call BIS_fnc_deleteTask;
				hintSilent "We have lost the postion of the targets. Thus, the contract has been canceled.";
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
			hintSilent "We have lost the postion of the targets. Thus, the contract has been canceled.";
			sleep 5;
			hintSilent "";
		};
		sleep 10;
		
		private _closestPlayer = objNull;
		private _minDistance = 99999; // Set a high initial value

		// Loop through all players to find the closest one
		{
			private _distance = (_aiGroup select 0) distance _x;
			if (_distance < _minDistance) then {
				_minDistance = _distance;
				_closestPlayer = _x;
			};
		} forEach allPlayers;
		
		for "_i" from 0 to (count waypoints _horde - 1) do
		{
			deleteWaypoint [_horde, 0];
		};
		
		if (_closestPlayer distance (_aiGroup select 0) < 300) then {
			_waypoint4 = _horde addWaypoint [(getPos _closestPlayer), 0];
			_waypoint4 setWaypointType "MOVE";
			_waypoint4 setWaypointBehaviour "COMBAT";
		} else {
			_waypoint1 = _horde addWaypoint [([_pos, 200, 400, 5, 0, 20, 0] call BIS_fnc_findSafePos), 0];
			_waypoint1 setWaypointType "MOVE";
			_waypoint1 setWaypointBehaviour "COMBAT";
		};
	};
	deleteVehicle _stoneSaver;
	deleteVehicle _totemSaver;
} else {
	hintSilent "Sorry, but it seems you already have a task assigned. Finish that one before accepting another.";
};