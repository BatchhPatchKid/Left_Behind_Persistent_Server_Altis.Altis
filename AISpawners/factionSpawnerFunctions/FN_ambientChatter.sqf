/*
    Registers an AI group's radio chatter data.
    Called when a unit is created.
    Params: [ _grp, _faction ]
*/

params ["_unit", "_faction"];

// Only run where the unit is local
if (!local _unit) exitWith {};

// Initialise group data once
if (isNil { _grp getVariable "LB_chatterInit" }) then {
    _grp setVariable ["LB_chatterInit", true];
    _grp setVariable ["LB_faction", _faction, true];

    private _callsigns = missionNamespace getVariable ["LB_callsigns", createHashMapFromArray []];
    private _available = _callsigns getOrDefault [_faction, ["Unit"]];
    private _cs = selectRandom _available;
    _grp setVariable ["LB_callsign", _cs, true];
    _grp setGroupIdGlobal [_cs];

    // Send spawn line once per group if a player is nearby
    private _spawnLines = missionNamespace getVariable ["LB_spawnLines", createHashMapFromArray []];
    private _lines = _spawnLines getOrDefault [_faction, []];
    if (count _lines > 0) then {
        private _msg = selectRandom _lines;
        private _speaker = leader _grp;
        private _nearPlayers = allPlayers select { _x distance _speaker <= 500 };
        if (count _nearPlayers > 0) then {
            [_speaker, _msg] remoteExec ["globalChat", _nearPlayers];
        };
    };
};