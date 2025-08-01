/*
    FN_factionSpawnerMain.sqf
    Master script handling AI faction spawns when triggers activate.
    ----------------------------------------------------------------------------
    Flow:
      1. Gather parameters and defaults
      2. Early exit if players are too close or rock already exists
      3. Ensure a rock marker is present
      4. Spawn ambient vehicles and renegade groups
      5. Decide day/night “Rvg” mode for zombies
      6. Spawn either random or predetermined factions
*/

// -----------------------------------------------------------------------------
// 1. PARAMETERS & INITIALIZATION
// -----------------------------------------------------------------------------
params ["_faction", "_numUnits", "_trigger", "_typeOfLocationArea"];

// Mutant effects must come first as they are executed on client side/cannot be executed on server side
private _mutantArray = ["mutantArray"] call (missionNamespace getVariable "FN_arrayReturn");
if (_faction in _mutantArray) then {

	{
		if (((getPos _x) distance _pos <= (_triggerRadius + 100)) && hasInterface) then { [_faction,_x] call mutantEffects; };
	}  forEach allPlayers;
};


// Entire spawner runs only on the server. Clients exit immediately to avoid
// unnecessary calculations. Mutant visual effects are executed on clients via
// remote calls within FN_factionSelector.
if (!isServer) exitWith {};

// Trigger position and radius
private _pos = getPos _trigger;
private _triggerRadius = (triggerArea _trigger) select 0;

// Default location‐type tag if none passed
if (isNil "_typeOfLocationArea") then {
    _typeOfLocationArea = "Rnd";
};

// -----------------------------------------------------------------------------
// 2. HELPER LAMBDAS
// -----------------------------------------------------------------------------

// Check if any player is within (radius - 100) meters of the trigger
private _playersTooClose = {
    params ["_trg", "_rad"];
    private _tooClose = false;
    {
        // If any player is closer, mark and bail out
        if ((getPos _x) distance (getPos _trg) < (_rad - 100)) exitWith {
            _tooClose = true;
        };
    } forEach allPlayers;
    _tooClose
};

// Check whether a rock marker already exists within 10m of the trigger
private _triggerUsed = {
    params ["_trg"];
    (count nearestObjects [_trg, ["Land_Cliff_stone_small_F"], 10] != 0)
};

// If on server and no rock exists, create one at the trigger
private _spawnMarker = {
    params ["_trg"];
    "Land_Cliff_stone_small_F" createVehicle (getPos _trg);
};

// Spawn ambient civilian/military vehicles around the trigger
private _spawnAmbientVeh = {
    params ["_p", "_r"];
    [_p, _r] call (missionNamespace getVariable "FN_ambientVeh");
};

// Occasionally spawn small renegade groups near the trigger
private _spawnRenegades = {
    params ["_p", "_r"];
    // Decide 0–2 groups
    for "_i" from 1 to (floor (random 3)) do {
        // Find a safe position in the inner quarter of the radius
        private _renegadePos = [_p, (_r / 4), (_r / 3), 3] call (missionNamespace getVariable "FN_findSafePosition");
        // Spawn renegade units there
        [_renegadePos, 50, _r] call (missionNamespace getVariable "FN_renegadeSpawner");
    };
};

// Spawn a standard wandering zombie group and then call selector
private _spawnZombieGroup = {
    params ["_num", "_rad", "_pos", "_rvg", "_area"];
    // Pick a safe spot a short distance out
    private _zombiePos = [_pos, 20, 45, 3] call (missionNamespace getVariable "FN_findSafePosition");
    
    // Finalize zombie group spawn
    ["Zombie", _num, _rad, _zombiePos, _rvg, _area] call (missionNamespace getVariable "FN_factionSelector");
};

// Spawn a survivor group, with optional first-group hunting/wandering extras
private _spawnSurvivorGroup = {
    params ["_num", "_rad", "_pos", "_rvg", "_area"];
    private _survivorPos = _pos;

    // Weighted list of survivor sub-factions and their spawn chances
    private _survivorFactions = ["_survivorFactions"] call (missionNamespace getVariable "FN_arrayReturn");

    // Pick a specific survivor sub-faction
    private _factionSelected = [_survivorFactions, ""] call (missionNamespace getVariable "FN_selectFaction");

    // On the very first human group, optionally spawn hunting & wandering extras
    if (random 1 > 0.75) then {
        [_survivorPos, _factionSelected] call (missionNamespace getVariable "FN_spawnHuntingFaction");
    };

    if (random 1 > 0.75) then {
        [_survivorPos, _factionSelected] call (missionNamespace getVariable "FN_spawnWanderingFaction");
    };

    // Finalize survivor group spawn
    [_factionSelected, _num, _rad, _survivorPos, _rvg, _area] call (missionNamespace getVariable "FN_factionSelector");
};

// Spawn a mutant group, with optional wandering extras
private _spawnMutantGroup = {
    params ["_num", "_rad", "_pos", "_rvg", "_area"];

    // Weighted list of mutant types
    private _mutantWeights = ["_mutantWeights"] call (missionNamespace getVariable "FN_arrayReturn");

    // Choose a random mutant type
    private _factionSelected = selectRandomWeighted _mutantWeights;

    // Find a valid mutant‐spawn position
    private _mutantPos = [_pos, 25, 75, 3] call (missionNamespace getVariable "FN_findSafePosition");

    // Finalize mutant group spawn
    [_factionSelected, _num, _rad, _mutantPos, _rvg, _area] call (missionNamespace getVariable "FN_factionSelector");
};

// Spawn logic when a specific faction (not "Rnd") is requested
private _spawnPredetermined = {
    params ["_fac", "_num", "_rad", "_pos", "_rvg", "_area"];
    // Check if this faction is a mutant type
    private _mutantArray = ["mutantArray"] call (missionNamespace getVariable "FN_arrayReturn");
    // 25% chance to do a hunting spawn (if not mutant), else 25% chance wandering
    if (random 1 > 0.75 && !(_fac in _mutantArray)) then {
        [_pos, _fac] call (missionNamespace getVariable "FN_spawnHuntingFaction");
    } else {
        if (random 1 > 0.75) then {
            [_pos, _fac] call (missionNamespace getVariable "FN_spawnWanderingFaction");
        };
    };
    // Always call selector to spawn the requested faction units
    [_fac, _num, _rad, _pos, _rvg, _area] call (missionNamespace getVariable "FN_factionSelector");
};

// Spawn 1–3 random factions based on weighted dice rolls
private _spawnRandomFactions = {
    params ["_numUnits", "_radius", "_pos", "_rvg", "_area"];

    private _dice = random 1;

    if (_dice < 0.3) then {
        [_numUnits, _radius, _pos, _rvg, _area] call _spawnSurvivorGroup;
    };
    if (_dice > 0.3) then {
        [_numUnits, _radius, _pos, _rvg, _area] call _spawnZombieGroup;
    };
    if (_dice < 0.05 || _dice > 0.95) then {
        [_numUnits, _radius, _pos, _rvg, _area] call _spawnMutantGroup;
    };
};

// -----------------------------------------------------------------------------
// 3. EARLY EXIT CHECKS
// -----------------------------------------------------------------------------

// Exit if any player is too close or rock marker already present
if ([ _trigger, _triggerRadius ] call _playersTooClose) exitWith {};
if ([ _trigger ] call _triggerUsed) exitWith {};

// Ensure the rock marker is created
[ _trigger ] call _spawnMarker;

// -----------------------------------------------------------------------------
// 4. DETERMINE ZOMBIE “RVG” MODE
// -----------------------------------------------------------------------------

// false overnight or 15% random; true daytime majority
private _zombieRvg = if (daytime < 4 || daytime > 20 || random 1 > 0.85) then {
    false
} else {
    true
};

// -----------------------------------------------------------------------------
// 5. AMBIENT & RENEGADES
// -----------------------------------------------------------------------------

    [ _pos, _triggerRadius ] call _spawnAmbientVeh;   // civilian/military traffic

if (random 1 > 0.375) then {
    [ _pos, _triggerRadius ] call _spawnRenegades;    // occasional small groups
};

// -----------------------------------------------------------------------------
// 6. MAIN FACTION SPAWN ROUTINE
// -----------------------------------------------------------------------------

if (_faction == "Rnd") then {
    // Random mixture of zombie, survivor, and mutant factions
    [ _numUnits, _triggerRadius, _pos, _zombieRvg, _typeOfLocationArea ] call _spawnRandomFactions;
} else {
    // Spawn exactly the requested faction
    [ _faction, _numUnits, _triggerRadius, _pos, _zombieRvg, _typeOfLocationArea ] call _spawnPredetermined;
};