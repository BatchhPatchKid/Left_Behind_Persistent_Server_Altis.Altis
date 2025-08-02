// ensuring only the server runs this script
// This script is responsible for garbage collection, cleaning up dead units, vehicles, and world objects
// It runs periodically to maintain server performance and prevent lag due to excessive objects in the world
// It also allows for manual execution via a Zeus action if needed
// The script checks for headless clients and ensures garbage collection is only performed when players are present
// It uses a set of functions to check proximity to players and desired objects before deleting them
// The script is designed to be efficient, running in a loop with a sleep interval to avoid overwhelming the server
// It also handles specific classes of objects that need to be cleaned up, such as corpses, vehicles, and static objects

private _fn_checkProximityToDesiredObject={
    params["_object","_objectsCache","_proximity"];
    private _withinRange=false;
    {
        if(_object distance2D _x<=_proximity)exitWith{_withinRange=true};
    }forEach _objectsCache;
    _withinRange
};

private _fn_checkProximityToPlayer={
    params["_object","_players","_distanceThreshold"];
    private _withinRange=false;
    {
        if(_object distance2D _x<=_distanceThreshold)exitWith{_withinRange=true};
    }forEach _players;
    _withinRange
};

private _FN_garbageCollector={
    private _headlessClients=entities"HeadlessClient_F";
    private _players=allPlayers-_headlessClients;
    private _flags=allMissionObjects"Flag_Red_F";
    private _missionStones=allMissionObjects"Land_BluntStone_01";
    private _airVehicles=vehicles select{_x isKindOf"Air"};
    private _distStone=500;
    private _distFlag=150;
    private _distPlayer=3000;

    {
        if([_x,_missionStones,_distStone] call _fn_checkProximityToDesiredObject) then { continue; };
        if([_x,_flags,_distFlag] call _fn_checkProximityToDesiredObject) then { continue; };
        if([_x,_players,_distPlayer] call _fn_checkProximityToPlayer) then { continue; };
        if(_airVehicles findIf{_x distance2D _x<5}!=-1) then { continue; };
        deleteVehicle _x;
    } forEach allUnits;

    {
        if([_x,_missionStones,_distStone]call _fn_checkProximityToDesiredObject) then { continue; };
        if([_x,_flags,_distFlag]call _fn_checkProximityToDesiredObject) then { continue; };
        if([_x,_players,_distPlayer]call _fn_checkProximityToPlayer) then { continue; };
        deleteVehicle _x;
    } forEach allDead;

    private _gcClasses=["_gcClasses"]call(missionNamespace getVariable"FN_arrayReturn");

    private _gcObjects = [];
    {
        _gcObjects append allMissionObjects _x;
    } forEach _gcClasses;

    {
        if([_x,_missionStones,_distStone] call _fn_checkProximityToDesiredObject) then { continue; };
        if([_x,_flags,_distFlag] call _fn_checkProximityToDesiredObject) then { continue; };
        if([_x,_players,_distPlayer] call _fn_checkProximityToPlayer) then { continue; };
        deleteVehicle _x;
    } forEach _gcObjects;

    private _vehicles=vehicles select{_x isKindOf"LandVehicle"||_x isKindOf"Ship"};
    {
        if([_x,_missionStones,_distStone] call _fn_checkProximityToDesiredObject) then { continue; };
        if([_x,_flags,_distFlag] call _fn_checkProximityToDesiredObject) then { continue; };
        if([_x,_players,_distPlayer] call _fn_checkProximityToPlayer) then { continue; };
        deleteVehicle _x;
    } forEach _vehicles;
};

params["_zeusAction"];
if(_zeusAction) then {
    call _FN_garbageCollector;
    hintSilent"Garbage collection executed.";
} else {
    while{true} do {
        sleep 360;

        // waiting until there are players connected and alive
        waitUntil { count ( allPlayers select { alive _x } ) > 0 };

        call _FN_garbageCollector;
    };
};