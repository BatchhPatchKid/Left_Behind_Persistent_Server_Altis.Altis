// ========================================================
// Main Script Logic For AI Spawn Locations
// ========================================================

params ["_faction", "_numUnits", "_trigger", "_typeOfLocationArea"];
private _activate = true;
private _triggerRadius = (triggerArea _trigger) select 0;

// Check if players are too close to the trigger
{
    if ((getPos _x) distance (getPos _trigger) < (_triggerRadius - 100)) exitWith {
        _activate = false;
    };
} forEach allPlayers;

// Check for the rock condition
if ((count nearestObjects [_trigger, ["Land_Cliff_stone_small_F"], 10] != 0) && isServer) then {
    _activate = false;
} else {
    if (isServer) then {
        "Land_Cliff_stone_small_F" createVehicle (getPos _trigger);
    };
};

// Main activation logic
if (_activate) then {
    private _pos = getPos _trigger;
    
    if (isNil "_typeOfLocationArea") then { _typeOfLocationArea="Rnd"; };

    // Spawn ambient vehicles
    if (isServer) then {
        [_pos, _triggerRadius] call (missionNamespace getVariable "FN_ambientVeh");
    };

    // Zombie spawn logic
    private _zombieRvg = if (daytime < 4 || daytime > 20 || random 1 > 0.85) then { false } else { true };

    if (isServer) then {
        if (random 1 > 0.375) then {
            // Ambient Renegades
            for "_i" from 1 to (floor (random 3)) do {
                private _renegadePos = [_pos, (_triggerRadius / 4), (_triggerRadius / 3), 3] call (missionNamespace getVariable "FN_findSafePosition");
                [_renegadePos, 50, _triggerRadius] call (missionNamespace getVariable "FN_renegadeSpawner");
            };
        };
    };

    // Faction spawn logic
    if (_faction == "Rnd") then {
        // Random faction logic
        private _numFactions = 1;
        private _howManyFactions = random 1;
        if (_howManyFactions > 0.8 && _howManyFactions < 0.95) then { _numFactions = 2; };
        if (_howManyFactions >= 0.95) then { _numFactions = 3; };

        private _firstHumans = true;
        for "_i" from 1 to _numFactions do {
            private _factionTypes = random 1;
            if (_factionTypes < 0.6) then {
                // Zombie faction
                if (isServer) then {
                    private _zombiePos = [_pos, 20, 45, 3] call (missionNamespace getVariable "FN_findSafePosition");
                    if (random 1 > 0.75) then {
                        [_zombiePos, "Zombie"] call (missionNamespace getVariable "FN_spawnWanderingFaction");
                    };
                    ["Zombie", _numUnits, _triggerRadius, _zombiePos, _zombieRvg, _typeOfLocationArea] call (missionNamespace getVariable "FN_factionSelector");
                };
            };
            if (_factionTypes >= 0.6 && _factionTypes <= 0.9) then {
                // Survivor faction
                
                _survivorPos = _pos;
                if (isServer) then {
                    if (!_firstHumans) then {
                        private _survivorPos = [_pos, 30, 100, 300] call (missionNamespace getVariable "FN_findSafePosition");
                    } else {
                        _firstHumans = false;
                    };
                    
                    private _factionArray = ["Bandit", .75, "BB", .25, "SU", .25, "DT", .50, "NH", .50, "PF", .35, "ALF", .10, "WO", .10, "RC", .15, "TRB", .10, "US", .03, "RU", .03, "PMC", .10, "ROA", .10];
                    private _factionSelected = [_factionArray, _faction] call (missionNamespace getVariable "FN_selectFaction");
                    
                    if (isServer && _firstHumans) then {
                        if (random 1 > 0.75) then {
                            [_survivorPos, _factionSelected] call (missionNamespace getVariable "FN_spawnHuntingFaction");
                        };
                        if (random 1 > 0.75) then {
                            [_survivorPos, _factionSelected] call (missionNamespace getVariable "FN_spawnWanderingFaction");
                        };
                    };
                    
                    [_factionSelected, _numUnits, _triggerRadius, _survivorPos, _zombieRvg, _typeOfLocationArea] call (missionNamespace getVariable "FN_factionSelector");
                };
            };
            if (_factionTypes > 0.9) then {
                // Mutant faction
                private _mutantArray = ["Statue", .00125, "mutants", .35, "Skull", .25, "411", .15, "Abom", .05, "Mind", .15, "Rake", .10, "Shadow", .15, "Snatch", .20, "Tank", .005, "Hellspawn", .0025, "Goliath", .00125, "Vamp", .15, "Various", .005, "Wend", .25, "Bloater", .30, "Leaper", .60, "Screamer", .35];
                private _factionSelected = selectRandomWeighted  _mutantArray;
                private _mutantPos = [_pos, 25, 75, 3] call (missionNamespace getVariable "FN_findSafePosition");
                if (random 1 > 0.75) then {
                    [_mutantPos, "mutant"] call (missionNamespace getVariable "FN_spawnWanderingFaction");
                };
                [_factionSelected, _numUnits, _triggerRadius, _mutantPos, _zombieRvg, _typeOfLocationArea] call (missionNamespace getVariable "FN_factionSelector");
            };
        };
    } else {
        // Predetermined faction logic
        if (isServer) then {
            private _mutantArray = ["mutantArray"] call (missionNamespace getVariable "FN_arrayReturn");    
            if (random 1 > 0.75 && !(_faction in _mutantArray)) then {
                [_pos, _faction] call (missionNamespace getVariable "FN_spawnHuntingFaction");
            } else {
                if (random 1 > 0.75) then {
                    [_pos, _faction] call (missionNamespace getVariable "FN_spawnWanderingFaction");
                };
            };
        };
        [_faction, _numUnits, _triggerRadius, _pos, _zombieRvg,_typeOfLocationArea] call (missionNamespace getVariable "FN_factionSelector");
    };
};