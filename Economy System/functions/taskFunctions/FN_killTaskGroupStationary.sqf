params ["_container", "_caller", "_actionId"];
if (isNull (currentTask _caller)) then {
	hintSilent format ["The following group has had a bounty put on their leader. Eliminate them for a reward, %1", (name _caller)];
	private _factionArray = ["taskFactionWeights"] call (missionNamespace getVariable "FN_arrayReturn");
        private _faction = _factionArray call BIS_fnc_selectRandomWeighted;
	private _numUnits = ceil(random 7)+6;
	private _minDist = 700;
	private _maxDist = 2500;
	private _pos = [getPos _caller, _minDist, _maxDist, 10, 0, 20, 0] call BIS_fnc_findSafePos;
	private _posMarker = [_pos, 0, 300, 0, 0, 20, 0] call BIS_fnc_findSafePos;
	
	private _flag = "Flag_Red_F" createVehicle _pos;
	
	[_faction, _numUnits, _pos, "Camp", RESISTANCE] call (missionNamespace getVariable "FN_spawnAI");
	
	
	private _unitSkillsArray = [_faction, _pos] call FN_getFactionSkills;
	private _side = RESISTANCE; // Must be hostile to the players no matter what
	private _unit = _unitSkillsArray select 1;
	
	_sfOverride = false;
	if (random _sfGroup < 1) then { _sfOverride = true; };

	private _groupBandit = createGroup [_side, true];

	private ["_newAI"]; // instantiated so I don't get an error from it only being defined in 'if' statements

	_newAI = _groupBandit createUnit [_unit, _pos, [], 15, "NONE"];
	[_faction, _newAI, false, true, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
	[_newAI, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call FN_setUnitSkills;
	
	_rndTaskID = str (random 100);

	[_caller, _rndTaskID, [format ["Eliminate the target to earn $120. The group is held up within 300 meters of the marker. It does not matter if you or someone else kills him, just make sure the job gets done. The faction the target is apart of is %1", _faction], "Eliminate the Stationary Target"], _posMarker, "ASSIGNED", 0, true, "kill", false] call BIS_fnc_taskCreate;
	sleep 5;
	while {true} do { // Checking to see if the task has been complete
		if ((isNull (currentTask _caller))) exitWith {
			deleteVehicle _flag;
		};
		if (not alive _newAI) exitWith {
			if (isNull _newAI) then {
				[_rndTaskID,"CANCELED"] call BIS_fnc_taskSetState; 
				[_rndTaskID, true] call BIS_fnc_deleteTask;
				hintSilent "We have lost the postion of the target. Thus, the contract has been canceled.";
				sleep 5;
				hintSilent "";
			} else {
				[_rndTaskID,"SUCCEEDED"] call BIS_fnc_taskSetState; 
				[_rndTaskID, true] call BIS_fnc_deleteTask;
				hintSilent "Task has been completed, receive your reward at the contractor's office";
				for "_i" from 1 to 120 do {
					if (_caller canAddItemToBackpack "rvg_money") then {
						_caller addItemToBackpack "rvg_money"; 
						hintSilent format ["All of the amount owed to you ($%2) has been put in your backpack, %1. Good work out there.", (name _caller), 120];
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
		sleep 5;
	};
	deleteVehicle _flag;
} else {
	hintSilent "Sorry, but it seems you already have a task assigned. Finish that one before accepting another.";
};