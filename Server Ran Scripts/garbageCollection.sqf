/*
    Garbage collection script
    Deletes units, dead bodies and objects of gcClasses more than 500m from any player,
    except for objects within 100m of Flag_Red_F or Land_BluntStone_01.
    Land_BluntStone_01 objects themselves are removed if farther than 1000m from all players.
    The script is intended to be run server side every 30 minutes of in‑game time.
*/

if ( !isServer ) exitWith {};

FN_runGarbageCollection = {
    private _gcClasses = ["gcClasses"] call (missionNamespace getVariable "FN_arrayReturn");

    private _players = allPlayers - entities "HeadlessClient_F";
    if (_players isEqualTo []) exitWith {sleep 1800};

    private _flags = allMissionObjects "Flag_Red_F";
    private _stones = allMissionObjects "Land_BluntStone_01";

    // handle stones deletion when far from players
    {
        private _stone = _x;
        private _nearest = [_players, _stone] call BIS_fnc_nearestPosition;
        if (_stone distance2D _nearest > 1000) then { deleteVehicle _stone; };
    } forEach _stones;

    private _protected = _flags + _stones; // objects providing protection radius

    // collect objects of gcClasses
    private _gcObjects = nearestObjects [middleOfMap, _gcClasses, 50000];

    // add ai units and dead bodies
    private _units = allUnits - _players;
    private _corpses = allDead;

    {
        private _obj = _x;
        if (_obj isKindOf "Flag_Red_F") exitWith {};
        if (_obj isKindOf "Land_BluntStone_01") exitWith {};

        private _skip = false;
        {
            if (_obj distance2D _x <= 100) exitWith {_skip = true};
        } forEach _protected;
        if (_skip) exitWith {};

        private _close = false;
        {
            if (_obj distance2D _x <= 500) exitWith {_close = true};
        } forEach _players;
        if (_close) exitWith {};

        deleteVehicle _obj;
        sleep 0.01;
    } forEach (_gcObjects + _units + _corpses);
};

params ["_zeusAction"];

if (_zeusAction) exitWith {
    // If the script is run from Zeus, the garbage collection is ran once
    call FN_runGarbageCollection;
    hintSilent "Garbage collection completed.";
};

[] spawn {
    while { true } do {
        call FN_runGarbageCollection;
        sleep 1800;  // 30 min simulation time
    };
};