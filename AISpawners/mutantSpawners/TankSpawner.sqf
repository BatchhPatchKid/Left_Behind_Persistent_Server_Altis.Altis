params ["_pos", "_triggerRadius", "_maxUnits"];

[4] spawn BIS_fnc_earthquake;	
	
[_pos, _triggerRadius, _maxUnits] spawn {
	params ["_pos", "_triggerRadius", "_maxUnits"];
	
	[_pos, 2] call (missionNamespace getVariable "FN_lootSpawner");
	[_pos, 2] call (missionNamespace getVariable "FN_lootSpawner");
	
	private _horde = createGroup east;
	
	for "_i" from 1 to _maxUnits do {
		private _hordeUnit = _horde createUnit ["WBK_SpecialZombie_Smasher_3", [_pos, 10, (_triggerRadius / 4), 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos, [], 1, "NONE"];
		_hordeUnit addRating -10001;
	};
	
	private _factionArray = ["Bandit", .05, "BB", .35, "SU", .05, "DT", .05, "NH", .05, "PF", .20, "ALF", .25, "WO", .35, "RC", .15, "TRB", .25, "US", .10, "RU", .10, "PMC", .20, "ROA", .20];
	private _factionSelected = selectRandomWeighted _factionArray;
	[_factionSelected, (round random (10)+6), _pos, "Squad", independent, "I_Survivor_F"] call (missionNamespace getVariable "FN_spawnAI");
};