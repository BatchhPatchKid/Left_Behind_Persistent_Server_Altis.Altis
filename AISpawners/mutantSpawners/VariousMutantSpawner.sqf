params ["_pos", "_triggerRadius", "_maxUnits"];
		
[_pos, 2] call (missionNamespace getVariable "FN_lootSpawner");
[_pos, 2] call (missionNamespace getVariable "FN_lootSpawner");

private _horde = createGroup east;
private _Type = ["DSA_411", .01, "DSA_Mindflayer", .01, "DSA_Rake", .05, "DSA_Shadowman", .05, "DSA_Snatcher", .15, "DSA_Wendigo", .1, "Zombie_Special_OPFOR_Boomer", .05,"Zombie_Special_OPFOR_Leaper_1", .5,"Zombie_Special_OPFOR_Leaper_2", .5, "Zombie_Special_OPFOR_Screamer", .05];

for "_i" from 1 to _maxUnits do {
	private _hordeUnit = _horde createUnit [(selectRandomWeighted _Type), [_pos, 20, (_triggerRadius / 4), 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos, [], 1, "NONE"];
};
[_horde, [], []] call (missionNamespace getVariable 'FN_enableDynamicSim');