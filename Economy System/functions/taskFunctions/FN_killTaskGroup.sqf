params ["_container", "_caller", "_actionId"];
if (isNull (currentTask _caller)) then {
	hintSilent format ["The following group has had a bounty put on their leader. Eliminate them for a reward, %1", (name _caller)];
	
	_factionArray = ["taskFactionWeights"] call (missionNamespace getVariable "FN_arrayReturn");
	_faction = _factionArray call BIS_fnc_selectRandomWeighted;
	_minDist = 750;
	_maxDist = 1500;
	_pos = [getPos _caller, _minDist, _maxDist, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	
	_stoneSaver = "Land_BluntStone_01" createVehicle _pos;
	
	private _unitSkillsArray = [_faction, _pos] call FN_getFactionSkills;
	_side = RESISTANCE; // Must be hostile to the players no matter what
	_unit = "I_G_Survivor_F";
	
	_sfOverride = false;
	if (random _sfGroup < 1) then { _sfOverride = true; };

	_meleeChance = [_faction] call compile preprocessFileLineNumbers "AISpawners\aiSubScripts\meleeChance.sqf";

	_groupBandit = createGroup [_side, true];
	
	private ["_newAI"]; // instantiated so I don't get an error from it only being defined in 'if' statements

	_newAI = _groupBandit createUnit [_unit, _pos, [], 15, "NONE"];
	[_faction, _newAI, false, true, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
	[_newAI, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call FN_setUnitSkills;

	_maxBandits = ceil(random 5)+4;
	for "_i" from 0 to _maxBandits do {
		if (random 1 > _meleeChance) then {
			_banditUnit = _groupBandit createUnit [_unit, _pos, [], 15, "NONE"];
			[_faction, _banditUnit, false, true, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
			[_banditUnit, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call FN_setUnitSkills;
		} else {
			_grpTemp = createGroup east;
			_banditUnit = _grpTemp createUnit ["O_soldier_Melee_RUSH",([_pos, 0, 10, 3, 0, 20, 0,[],[]] call BIS_fnc_findSafePos),[],1,"NONE"];
			[_faction, _banditUnit, true, false, false] call (missionNamespace getVariable "FN_equipAI");
			[_banditUnit, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call FN_setUnitSkills;
		};
		sleep .01;
	};

	_waypointPos = [_pos, 150, 300, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	_wp1 = _groupBandit addWaypoint [_waypointPos, 0];
	_wp1 setWaypointType "MOVE";

	_waypointPos = [_pos, 100, 300, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	_wp2 = _groupBandit addWaypoint [_waypointPos, 1];
	_wp2 setWaypointType "MOVE";

	_waypointPos = [_pos, 50, 300, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	_wp3 = _groupBandit addWaypoint [_waypointPos, 2];
	_wp3 setWaypointType "MOVE";

	_waypointPos = [_pos, 100, 300, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	_wp4 = _groupBandit addWaypoint [_waypointPos, 3];
	_wp4 setWaypointType "CYCLE";

	sleep 3;
	hintSilent "";
	
	_rndDouble = random 100;
	_rndTaskID = str (_rndDouble);

	[_caller, _rndTaskID, [format ["Eliminate the target to earn $80. The target will be within 300 meters of the mark on your map. It does not matter if you or someone else kills him, just make sure the job gets done. The faction the target is apart of is %1", _faction], "Eliminate the Wandering Target"], _pos, "ASSIGNED", 0, true, "kill", false] call BIS_fnc_taskCreate;
	sleep 5;
	while {true} do { // Checking to see if the task has been complete
		if (isNull (currentTask _caller)) exitWith {
			deleteVehicle _stoneSaver;
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
				_moneyPayedBack = 0;
				for "_i" from 1 to 80 do {
					if (_caller canAddItemToBackpack "rvg_money") then {
						_caller addItemToBackpack "rvg_money";
						hintSilent format ["All of the amount owed to you ($%2) has been put in your backpack, %1. Good work out there.", (name _caller), 80];
					} else {
						[_container, _caller, _actionId, "rvg_money", 1, 1] execVM "Economy System\functions\FN_ammoBoxCheck.sqf";
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
	deleteVehicle _stoneSaver;
} else {
	hintSilent "Sorry, but it seems you already have a task assigned. Finish that one before accepting another.";
};