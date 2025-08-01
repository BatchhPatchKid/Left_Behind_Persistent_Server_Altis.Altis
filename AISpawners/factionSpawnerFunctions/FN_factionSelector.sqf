params ["_faction","_numUnits","_triggerRadius","_pos","_zombieRvg","_typeOfLocationArea"];

switch (_faction) do { //Going throuigh each mutant factions as well as zombie faction
	case "411": {
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "411Spawner");
	};
	case "Abom": {
		if (_numUnits == 0) then {_numUnits = floor(random 2)+1;};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "AbominationSpawner");
	};
	case "Mind": {
		if (_numUnits == 0) then {_numUnits = round(random [1, 3, 4]);};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "MindflayerSpawner");
	};
	case "Rake": {
		if (_numUnits == 0) then {_numUnits = round(random [2, 4, 6]);};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "RakeSpawner");
	};
	case "Shadow": {
		if (_numUnits == 0) then {_numUnits = round(random [1, 2, 3]);};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "ShadowmenSpawner");
	};
	case "Skull": {
		if (_numUnits == 0) then {_numUnits = round(random [4, 8, 15]);};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "SkullsSpawner");
	};
	case "Snatch": {
		if (_numUnits == 0) then {_numUnits = round(random [1, 2, 3]);};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "SnatcherSpawner");
	};
	case "Tank": {
		if (_numUnits == 0) then {_numUnits = selectRandom [1, 1, 1, 1, 1, 1, 1, 2];};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "TankSpawner");
	};
	case "Hellspawn": {
		if (_numUnits == 0) then {_numUnits = 1;};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "HellspawnSpawner");
	};
	case "Goliath": {
		if (_numUnits == 0) then {_numUnits = 1;};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "GoliathSpawner");
	};
	case "Vamp": {
		if (_numUnits == 0) then {_numUnits = round(random [2, 3, 5]);};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "VampireSpawner");
	};
	case "Various": {
		if (_numUnits == 0) then {_numUnits = round(random [4, 8, 12]);};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "VariousMutantSpawner");
	};
	case "Wend": {
		if (_numUnits == 0) then {_numUnits = round(random [2, 4, 5]);};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "WendigoSpawner");
	};
	case "Statue": {
		if (_numUnits == 0) then {_numUnits = 1;};
		[_pos, _triggerRadius, _numUnits] spawn (missionNamespace getVariable "StatueSpawner");
	};
	case "Bloater": {
		[_pos, _numUnits, 5, (_triggerRadius / 3), _faction, false, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
	};
	case "Leaper": {
		[_pos, _numUnits, 5, (_triggerRadius / 3), _faction, false, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
	};
	case "Screamer": {
		[_pos, _numUnits, 5, (_triggerRadius / 3), _faction, false, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
	};
	case "demon": {
		[_pos, _numUnits, 5, (_triggerRadius / 3), _faction, false, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
	};
	case "mutants": {
		[_pos, _numUnits, 5, (_triggerRadius / 3), _faction, false, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
	};
	case "Zombie": {
		[([_pos, 10, 30, 250] call FN_findSafePosition), _numUnits, 5, (_triggerRadius / 2), _faction, _zombieRvg, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");																																			  
	};
	default { // Default is survivors
		if (random 1 > 0.15) then {
			// Ambient Zombie Horde
			if (isServer) then {
				[_pos, 0, 50, (_triggerRadius/2), "sparseZombies", _zombieRvg, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
			};
		};
	
		if (isServer) then {
			[_faction, _numUnits, _pos, _typeOfLocationArea] call (missionNamespace getVariable "FN_spawnAI");
		};
	};
};