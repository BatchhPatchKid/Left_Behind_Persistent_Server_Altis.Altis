params ["_pos", "_triggerRadius", "_maxUnits"];

private _factionArray = ["TRB", .25, "US", .10, "RU", .10, "PMC", .20, "ROA", .20];
private _factionSelected = selectRandomWeighted _factionArray;
[_factionSelected, (round random (20)+10), _pos, "Squad", independent, "I_Survivor_F"] call (missionNamespace getVariable "FN_spawnAI");

[_pos, _triggerRadius, _maxUnits] spawn {
	_safePos1 = [_pos, 100, 500, 10, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
	_safePos2 = [_pos, 100, 500, 10, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
	_safePos3 = [_pos, 100, 500, 10, 0, 20, 0, [], []] call BIS_fnc_findSafePos;

	playSound3D [getMissionPath "sounds\blowout_siren_2.ogg", player, false, _safePos1, 5, 1, 0];
	sleep 5;

	playSound3D [getMissionPath "sounds\blowout_siren_2.ogg", player, false, _safePos2, 5, 1, 0];
	sleep 5;

	playSound3D [getMissionPath "sounds\blowout_siren_2.ogg", player, false, _safePos3, 5, 1, 0];

	[4] spawn BIS_fnc_earthquake;


	params ["_pos", "_triggerRadius", "_maxUnits"];
	
	[_pos, 2] execVM "AISpawners\lootSpawner.sqf";
	[_pos, 2] execVM "AISpawners\lootSpawner.sqf";
	[_pos, 2] execVM "AISpawners\lootSpawner.sqf";
	[_pos, 2] execVM "AISpawners\lootSpawner.sqf";
	[_pos, 2] execVM "AISpawners\lootSpawner.sqf";
	
	private _horde = createGroup east;
	
	for "_i" from 1 to _maxUnits do {
		private _hordeUnit = _horde createUnit ["WBK_Goliaph_3", [_pos, 10, 50, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos, [], 1, "NONE"];
		_hordeUnit addRating -10001;
	};
	[_horde, [], []] call (missionNamespace getVariable 'FN_enableDynamicSim');
};