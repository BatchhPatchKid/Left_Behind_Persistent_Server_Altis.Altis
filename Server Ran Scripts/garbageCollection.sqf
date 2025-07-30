//ensuring only the server runs this script
// This script is responsible for garbage collection, cleaning up dead units, vehicles, and world objects
// It runs periodically to maintain server performance and prevent lag due to excessive objects in the world
// It also allows for manual execution via a Zeus action if needed
// The script checks for headless clients and ensures garbage collection is only performed when players are present
// It uses a set of functions to check proximity to players and desired objects before deleting them
// The script is designed to be efficient, running in a loop with a sleep interval to avoid overwhelming the server
// It also handles specific classes of objects that need to be cleaned up, such as corpses, vehicles, and static objects
// The script is initiated by the server and runs continuously until all players are dead or the server is stopped
if (!isServer) exitWith {};

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

FN_garbageCollector = {
    // Cache headless clients and static object lists
    private _headlessClients     = entities "HeadlessClient_F";
    private _players = allPlayers - _headlessClients;
    private _objectsCacheFlag    = nearestObjects [middleOfMap, ["Flag_Red_F"], 17500];
    private _objectsCacheStone   = nearestObjects [middleOfMap, ["Land_BluntStone_01"], 17500];

    // Distance thresholds in meters
    private _distanceThresholdPerson   = 1000;
    private _distanceThresholdObjects  = 1000;
    private _corpseThreshold           = 1000;
    private _distanceThresholdVehicle  = 1000;

    // 1) Delete AI units outside player range
    {
        private _unit = _x;
        private _withinRange = false;

        _withinRange = [_unit, _objectsCacheStone, 500] call _fn_checkProximityToDesiredObject;
        if (_withinRange) exitWith {};

        _withinRange = [_unit, _objectsCacheFlag, 150] call _fn_checkProximityToDesiredObject;
        if (_withinRange) exitWith {};

        _withinRange = [_unit, _players, _distanceThresholdPerson] call _fn_checkProximityToPlayer;
        if (_withinRange) exitWith {};

        // Skip if near any air vehicle
        if ((count nearestObjects [_unit, ["air"], 5]) != 0) exitWith {};

        deleteVehicle _unit;
        sleep 0.01;
    } forEach allUnits;

    // 2) Delete dead bodies outside player range
    {
        private _object = _x;
        private _withinRange = false;

        _withinRange = [_object, _objectsCacheStone, 500] call _fn_checkProximityToDesiredObject;
        if (_withinRange) exitWith {};

        _withinRange = [_object, _objectsCacheFlag, 150] call _fn_checkProximityToDesiredObject;
        if (_withinRange) exitWith {};

        _withinRange = [_object, _players, _corpseThreshold] call _fn_checkProximityToPlayer;
        if (_withinRange) exitWith {};

        deleteVehicle _object;
        sleep 0.01;
    } forEach allDead;

    // 3) Delete specific world objects outside player range
    private _gcClasses = ["_gcClasses"] call (missionNamespace getVariable "FN_arrayReturn");
    private _objects = nearestObjects [middleOfMap, _gcClasses, 17500];

    {
        private _object = _x;
        private _withinRange = false;

        _withinRange = [_object, _objectsCacheStone, 500] call _fn_checkProximityToDesiredObject;
        if (_withinRange) exitWith {};

        _withinRange = [_object, _objectsCacheFlag, 150] call _fn_checkProximityToDesiredObject;
        if (_withinRange) exitWith {};

        _withinRange = [_object, _players, _distanceThresholdObjects] call _fn_checkProximityToPlayer;
        if (_withinRange) exitWith {};

        deleteVehicle _object;
        sleep 0.01;
    } forEach _objects;

    // 4) Delete vehicles (except aircraft) outside player range
    private _objectsVehicle = nearestObjects [middleOfMap, ["LandVehicle","air","ship"], 17500];
    {
        private _vehicle = _x;
        if (_vehicle isKindOf "Air") exitWith {};

        private _withinRange = false;
        _withinRange = [_vehicle, _objectsCacheStone, 500] call _fn_checkProximityToDesiredObject;
        if (_withinRange) exitWith {};

        _withinRange = [_vehicle, _objectsCacheFlag, 150] call _fn_checkProximityToDesiredObject;
        if (_withinRange) exitWith {};

        _withinRange = [_vehicle, _players, _distanceThresholdVehicle] call _fn_checkProximityToPlayer;
        if (_withinRange) exitWith {};

        deleteVehicle _vehicle;
        sleep 0.01;
    } forEach _objectsVehicle;
};

params ["_zeusAction"];

if (_zeusAction) exitWith {
    call FN_garbageCollector;
    hintSilent "Garbage collection executed.";
};

while { true } do {
    // Wait for 5 minutes before next garbage collection
    sleep 300;

    // Check if all players are dead
    _isEveryoneDead = true;
    {
        if (alive _x) exitWith { _isEveryoneDead = false };
    } forEach allPlayers;

    // If everyone is dead, stop the garbage collection
    if (_isEveryoneDead) exitWith {};
    
    // Run the garbage collection process
    call FN_garbageCollector;
};