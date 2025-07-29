params ["_faction","_numUnits","_triggerRadius","_pos","_zombieRvg","_typeOfLocationArea"];

_mutantSpawner = "";
FN_mutantEffectsCaller = {
	params[ "_faction", "_player"];
	[_faction, _player] execVM "AISpawners\mutantSpawners\mutantEffects.sqf";
};

FN_mutantEffects = {
	params ["_triggerRadius", "_pos", "_faction"];
	if (_numUnits == 0) then { _numUnits = round(random [1, 2, 4]); };
	{
		if (((getPos _x) distance _pos <= (_triggerRadius + 100)) && hasInterface) then { [_faction,_x] remoteExec ["FN_mutantEffectsCaller", _x]; };
	}  forEach allPlayers;
};

switch (_faction) do { //Going throuigh each mutant factions as well as zombie faction
	case "411": {
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\411Spawner.sqf";
		};
	};
	case "Abom": {
		if (_numUnits == 0) then {_numUnits = floor(random 2)+1;};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\AbominationSpawner.sqf";
		};
	};
	case "Mind": {
		if (_numUnits == 0) then {_numUnits = round(random [1, 3, 4]);};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\MindflayerSpawner.sqf";
		};
	};
	case "Rake": {
		if (_numUnits == 0) then {_numUnits = round(random [2, 4, 6]);};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\RakeSpawner.sqf";
		};
	};
	case "Shadow": {
		if (_numUnits == 0) then {_numUnits = round(random [1, 2, 3]);};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\ShadowmenSpawner.sqf";
		};
	};
	case "Skull": {
		if (_numUnits == 0) then {_numUnits = round(random [4, 8, 15]);};
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\SkullsSpawner.sqf";
		};
	};
	case "Snatch": {
		if (_numUnits == 0) then {_numUnits = round(random [1, 2, 3]);};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\SnatcherSpawner.sqf";
		};
	};
	case "Tank": {
		if (_numUnits == 0) then {_numUnits = selectRandom [1, 1, 1, 1, 1, 1, 1, 2];};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\TankSpawner.sqf";
		};
	};
	case "Hellspawn": {
		if (_numUnits == 0) then {_numUnits = 1;};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\HellspawnSpawner.sqf";
		};
	};
	case "Goliath": {
		if (_numUnits == 0) then {_numUnits = 1;};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\GoliathSpawner.sqf";
		};
	};
	case "Vamp": {
		if (_numUnits == 0) then {_numUnits = round(random [2, 3, 5]);};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\VampireSpawner.sqf";
		};
	};
	case "Various": {
		if (_numUnits == 0) then {_numUnits = round(random [4, 8, 12]);};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\VariousMutantSpawner.sqf";
		};
	};
	case "Wend": {
		if (_numUnits == 0) then {_numUnits = round(random [2, 4, 5]);};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\WendigoSpawner.sqf";
		};
	};
	case "Statue": {
		if (_numUnits == 0) then {_numUnits = 1;};
		[_triggerRadius, _pos, _faction] call FN_mutantEffects;
		if (isServer) then {
			[_pos, _triggerRadius, _numUnits] execVM "AISpawners\mutantSpawners\StatueSpawner.sqf";
		};
	};
	case "Bloater": {
		if (isServer) then {
			[_pos, _numUnits, 5, (_triggerRadius / 3), _faction, false, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
		};
	};
	case "Leaper": {
		if (isServer) then {
			[_pos, _numUnits, 5, (_triggerRadius / 3), _faction, false, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
		};
	};
	case "Screamer": {
		if (isServer) then {
			[_pos, _numUnits, 5, (_triggerRadius / 3), _faction, false, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
		};
	};
	case "demon": {
		if (isServer) then {
			[_pos, _numUnits, 5, (_triggerRadius / 3), _faction, false, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
		};
	};
	case "mutants": {
		if (isServer) then {
			[_pos, _numUnits, 5, (_triggerRadius / 3), _faction, false, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
		};
	};
	case "Zombie": {
		if (isServer) then {
			[([_pos, 10, 30, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos), _numUnits, 5, (_triggerRadius / 2), _faction, _zombieRvg, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");																																			  
		};
	};
	default { // Default is survivors
		if (random 1 > 0.15) then {
			// Ambient Zombie Horde
			if (isServer) then {
				[_pos, 0, 20, (_triggerRadius/5), "sparseZombies", _zombieRvg, _triggerRadius] call (missionNamespace getVariable "FN_ZTriggerSpawner");
			};
		};
	
		if (isServer) then {
			[_faction, _numUnits, _pos, _typeOfLocationArea] call (missionNamespace getVariable "FN_spawnAI");
		};
	};
};