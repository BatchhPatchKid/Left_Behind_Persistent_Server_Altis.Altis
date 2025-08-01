//ensuring only the server runs this script
// This script is responsible for garbage collection, cleaning up dead units, vehicles, and world objects
// It runs periodically to maintain server performance and prevent lag due to excessive objects in the world
// It also allows for manual execution via a Zeus action if needed
// The script checks for headless clients and ensures garbage collection is only performed when players are present
// It uses a set of functions to check proximity to players and desired objects before deleting them
// The script is designed to be efficient, running in a loop with a sleep interval to avoid overwhelming the server
// It also handles specific classes of objects that need to be cleaned up, such as corpses, vehicles, and static objects
// The script is initiated by the server and runs continuously until all players are dead or the server is stopped

// Defining functions
private _fn_checkProximityToDesiredObject = {
    params ["_object", "_objectsCache", "_proximity"];
    private _withinRange = false;

    {
        if (_object distance2D _x <= _proximity) exitWith { _withinRange = true };
    } forEach _objectsCache;

    _withinRange
};

private _fn_checkProximityToPlayer = {
    params ["_object", "_players", "_distanceThreshold"];
    private _withinRange = false;

    {
        if (_object distance2D _x <= _distanceThreshold) exitWith { _withinRange = true };
    } forEach _players;

    _withinRange
};

private _FN_garbageCollector = {
    // Cache headless clients and static object lists
    private _headlessClients = entities "HeadlessClient_F";
    private _players = allPlayers - _headlessClients;
    private _objectsCacheFlag = allMissionObjects "Flag_Red_F";
    private _objectsCacheStone = allMissionObjects "Land_Cliff_stone_small_F";
    private _objectsCacheMissionStone = allMissionObjects "Land_BluntStone_01";
    private _airVehicles = vehicles select { _x isKindOf "Air" };

    // Distance thresholds in meters
    private _distanceThresholdFlag = 150;
    private _distanceThresholdStone = 500;
    private _distanceThreshold = 1000;

    //deleting location markers (Land_Cliff_stone_small_F) if there are no players near them
    {
        if ([_x, _players, _distanceThreshold] call _fn_checkProximityToPlayer) then {
            continue;
        } else {
            deleteVehicle _x;
        }
    } forEach _objectsCacheStone;
    
    private _objectsCacheStone = allMissionObjects "Land_Cliff_stone_small_F";

    // Delete units (AI) outside player range
    {
        private _withinRange = false;

        _withinRange = [_x, _objectsCacheStone, _distanceThresholdStone] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _objectsCacheMissionStone, _distanceThresholdStone] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _objectsCacheFlag, _distanceThresholdFlag] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _players, _distanceThreshold] call _fn_checkProximityToPlayer;
        if (_withinRange) then { continue };

        // If the unit is near an air vehicle, skip deletion.
        if (_airVehicles findIf { _x distance2D _x < 5 } != -1) then { continue };

        deleteVehicle _x;
    } forEach allUnits;

    // Delete dead bodies (allDead) outside player range
    {
        private _withinRange = false;

        _withinRange = [_x, _objectsCacheStone, _distanceThresholdStone] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _objectsCacheMissionStone, _distanceThresholdStone] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _objectsCacheFlag, _distanceThresholdFlag] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _players, _distanceThreshold] call _fn_checkProximityToPlayer;
        if (_withinRange) then { continue };

        deleteVehicle _x;
    } forEach allDead;

    // Delete specific objects outside player range
    private _gcClasses = ["_gcClasses"] call (missionNamespace getVariable "FN_arrayReturn");
    private _objects = [];

    {
        _objects append (entities _x);
    } forEach _gcClasses;

    {
        private _withinRange = false;

        _withinRange = [_x, _objectsCacheStone, _distanceThresholdStone] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _objectsCacheMissionStone, _distanceThresholdStone] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _objectsCacheFlag, _distanceThresholdFlag] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _players, _distanceThreshold] call _fn_checkProximityToPlayer;
        if (_withinRange) then { continue };

        deleteVehicle _x;
    } forEach _objects;

    // Delete vehicles outside player range (excluding aircraft)
    private _objectsVehicle = vehicles select { _x isKindOf "LandVehicle" || _x isKindOf "Ship" };
    {
        private _withinRange = false;

        _withinRange = [_x, _objectsCacheStone, _distanceThresholdStone] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _objectsCacheMissionStone, _distanceThresholdStone] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _objectsCacheFlag, _distanceThresholdFlag] call _fn_checkProximityToDesiredObject;
        if (_withinRange) then { continue };

        _withinRange = [_x, _players, _distanceThreshold] call _fn_checkProximityToPlayer;
        if (_withinRange) then { continue };

        deleteVehicle _x;
    } forEach _objectsVehicle;
};


params ["_zeusAction"];

if (_zeusAction) exitWith {
    call _FN_garbageCollector;
    hintSilent "Garbage collection executed.";
};

while {true} do {
    sleep 120;

    // Check if all players are dead
    _isEveryoneDead = true;
    {
        if (alive _x) exitWith { _isEveryoneDead = false };
    } forEach allPlayers;

    // If everyone is dead, stop the garbage collection
    if (_isEveryoneDead) then {
        waitUntil { count (allPlayers select { alive _x }) > 0 };
    };
    
    // Run the garbage collection process
    call _FN_garbageCollector;
};