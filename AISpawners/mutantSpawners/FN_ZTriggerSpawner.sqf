params ["_pos", "_numUnits", "_minDist", "_maxDist", "_faction", "_zombieDefault", "_triggerRadius"];

_ZedArray = [];

FN_setNumUnits = { // sets the random number of units
	params ["_numUnitsMin","_numUnitsMid","_numUnitsMax"];
	_numUnits = round (random [_numUnitsMin, _numUnitsMid, _numUnitsMax]);

	{
		if (_x distance _pos < _triggerRadius + 50) then {
			_numUnits = _numUnits + 2;
		};
	} forEach allPlayers;
	_numUnits;
};

FN_spawnSpecialInfected = {
	params ["_ZedArray", "_minDist", "_maxDist", "_pos", "_lvl_loot", "_minUnits", "_midUnits", "_maxUnits", "_numUnits"];
	
	if (_numUnits == 0) then {
		_numUnits = [_minUnits, _midUnits, _maxUnits] call FN_setNumUnits;
	};
	
	[_pos, _lvl_loot] call (missionNamespace getVariable "FN_lootSpawner");
	
	private _horde = createGroup east;	
			
	for "_i" from 1 to _numUnits do {
		_ZedType = selectRandomWeighted _ZedArray;
		private _hordeUnit = _horde createUnit [_ZedType, [_pos, _minDist, _maxDist, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos, [], 1, "NONE"];
	};
	
	[_pos, 0, 20, (_triggerRadius/5), "sparseZombies", _zombieRvg, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
};

FN_getZombieArray = {
	params ["_type"];
	
	_ZedArray = [];
	switch (_type) do {
		case 1: { // faster zombie array
			_ZedArray = ["fastZombie"] call (missionNamespace getVariable "FN_arrayReturn");
		};
		case 2: { // mutant array
			_ZedArray = ["mutantZombie"] call (missionNamespace getVariable "FN_arrayReturn");
		};
		case 3: { //Zombies that own a location (the faction that spawns at a location)
			_ZedArray = ["locationZombie"] call (missionNamespace getVariable "FN_arrayReturn");
		};
		default { // default is normal slow zombie array
			_ZedArray = ["slowZombie"] call (missionNamespace getVariable "FN_arrayReturn");
		};
	};
	_ZedArray;
};

switch (_faction) do { //Going throuigh each zombie faction to spawn the appropriate one
	case "Bloater": {
		_minUnits = 2;
		_midUnits = 4;
		_maxUnits = 8;
		_ZedArray = ["Zombie_Special_OPFOR_Boomer", 1];
		_lvl_loot = 1;
			
		[_ZedArray, _minDist, _maxDist, _pos, _lvl_loot, _minUnits, _midUnits, _maxUnits, _numUnits] call FN_spawnSpecialInfected;
	};
	case "Leaper": {
		_minUnits = 2;
		_midUnits = 3;
		_maxUnits = 6;
		_ZedArray = ["Zombie_Special_OPFOR_Leaper_1", 1,"Zombie_Special_OPFOR_Leaper_2", 1];
		_lvl_loot = 1;
			
		[_ZedArray, _minDist, _maxDist, _pos, _lvl_loot, _minUnits, _midUnits, _maxUnits, _numUnits] call FN_spawnSpecialInfected;
	};
	case "Screamer": {
		_minUnits = 2;
		_midUnits = 4;
		_maxUnits = 5;
		_ZedArray = ["Zombie_Special_OPFOR_Screamer", 1];
		_lvl_loot = 1;
			
		[_ZedArray, _minDist, _maxDist, _pos, _lvl_loot, _minUnits, _midUnits, _maxUnits, _numUnits] call FN_spawnSpecialInfected;
	};
	case "mutants": {
		_minUnits = 1;
		_midUnits = 2;
		_maxUnits = 4;
		_ZedArray = [2] call FN_getZombieArray;
		_lvl_loot = 2;
			
		[_ZedArray, _minDist, _maxDist, _pos, _lvl_loot, _minUnits, _midUnits, _maxUnits, _numUnits] call FN_spawnSpecialInfected;
	};
	case "demon": {
		_minUnits = 1;
		_midUnits = 3;
		_maxUnits = 5;
		_ZedArray = ["RyanZombieboss1Opfor", 1,"RyanZombieboss2Opfor", 1,"RyanZombieboss3Opfor", 1,"RyanZombieboss4Opfor", 1,"RyanZombieboss5Opfor", 1,"RyanZombieboss6Opfor", 1,"RyanZombieboss7Opfor", 1,"RyanZombieboss8Opfor", 1,"RyanZombieboss9Opfor", 1,"RyanZombieboss10Opfor", 1,"RyanZombieboss11Opfor", 1,"RyanZombieboss12Opfor", 1,"RyanZombieboss13Opfor", 1,"RyanZombieboss14Opfor", 1,"RyanZombieboss15Opfor", 1,"RyanZombieboss16Opfor", 1,"RyanZombieboss17Opfor", 1,"RyanZombieboss18Opfor", 1,"RyanZombieboss19Opfor", 1,"RyanZombieboss20Opfor", 1,"RyanZombieboss21Opfor", 1,"RyanZombieboss22Opfor", 1,"RyanZombieboss23Opfor", 1,"RyanZombieboss24Opfor", 1,"RyanZombieboss25Opfor", 1,"RyanZombieboss26Opfor", 1,"RyanZombieboss27Opfor", 1,"RyanZombieboss28Opfor", 1,"RyanZombieboss29Opfor", 1,"RyanZombieboss30Opfor", 1,"RyanZombieboss31Opfor", 1,"RyanZombieboss32Opfor", 1];
		_lvl_loot = 2;
			
		[_ZedArray, _minDist, _maxDist, _pos, _lvl_loot, _minUnits, _midUnits, _maxUnits, _numUnits] call FN_spawnSpecialInfected;
	};
	case "sparseZombies": { // ambient zombies around a location
		if (_numUnits == 0) then {
			_numUnits = if (_zombieDefault) then { [6, 7, 8] } else { [4, 5, 6] } call FN_setNumUnits;
		};

		// 0 = slower zombies | 1 = faster Webknight zombies
		_ZedArray = if (_zombieDefault) then { [0] } else { [1] } call FN_getZombieArray;
		
		private _horde = createGroup east;
		if (_zombieDefault) then {
			[_horde, _ZedArray, _numUnits, _pos, _maxDist] call (missionNamespace getVariable "FN_spawnZom");
		} else {
			[_horde, _ZedArray, _numUnits, _pos, _maxDist] call (missionNamespace getVariable "FN_spawnZom");
		};
		[_horde, _pos, 100] call FN_createWaypoints;
	};
	default { // Default is zombies

		if (_numUnits > 21) then {
			[_pos, 1] call (missionNamespace getVariable "FN_lootSpawner");
		} else { [_pos, 0] call (missionNamespace getVariable "FN_lootSpawner"); };
		
		
		if (_numUnits == 0) then {
			_numUnits = if (_zombieDefault) then { [8, 10, 12] } else { [5, 6, 10] } call FN_setNumUnits;
		};

		_ZedArray = if (_zombieDefault) then { [3] } else { [1] } call FN_getZombieArray;
		
		private _horde = createGroup east;
		if (_zombieDefault) then {
			[_horde, _ZedArray, (_numUnits/2), _pos, 50] call (missionNamespace getVariable "FN_spawnZom");
			[_horde, _ZedArray, (_numUnits/2), _pos, _maxDist] call (missionNamespace getVariable "FN_spawnZom");
			[_horde, _pos, 100] call FN_createWaypoints;
		} else {
			[_horde, _ZedArray, (_numUnits/2), _pos, 15] call (missionNamespace getVariable "FN_spawnZom");
			[_horde, _ZedArray, (_numUnits/2), _pos, _maxDist] call (missionNamespace getVariable "FN_spawnZom");
		};
	};
};