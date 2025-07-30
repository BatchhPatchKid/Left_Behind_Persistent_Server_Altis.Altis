params ["_pos", "_triggerRadius", "_maxUnits"];
        
[_pos, 0] call (missionNamespace getVariable "FN_lootSpawner");

private _horde = createGroup east;
for "_i" from 1 to _maxUnits do {
	private _hordeUnit = _horde createUnit ["WBK_SpecialZombie_Corrupted_3", [_pos, 10, (_triggerRadius / 4), 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos, [], 1, "NONE"];
};

private _factionArray = ["Bandit", .75, "DT", .50, "NH", .50, "PF", .35, "ALF", .10, "WO", .10, "RC", .15, "TRB", .10, "US", .03, "RU", .03, "PMC", .10, "ROA", .10];
private _factionSelected = selectRandomWeighted _factionArray;
[_factionSelected, (round random (3)+3), _pos, "Squad", independent, "I_Survivor_F"] call (missionNamespace getVariable "FN_spawnAI");