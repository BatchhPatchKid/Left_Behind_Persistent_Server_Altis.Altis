/*
    Handles radio chatter for AI units.
    Params: [ _unit, _faction ]
*/

params ["_unit", "_faction"];

// ensure we run only where the unit is local
if (!local _unit) exitWith {};

private _spawnLines = missionNamespace getVariable ["LB_spawnLines", createHashMapFromArray []];
private _chatterLines = missionNamespace getVariable ["LB_chatterLines", createHashMapFromArray []];
private _callsigns = missionNamespace getVariable ["LB_callsigns", createHashMapFromArray []];

private _grp = group _unit;

// Assign group callsign once
if (isNil {_grp getVariable "LB_callsign"}) then {
    private _available = _callsigns getOrDefault [_faction, ["Unit"]];
    private _cs = selectRandom _available;
    _grp setVariable ["LB_callsign", _cs, true];
    _grp setGroupIdGlobal [_cs];
};

// Send spawn line once per group
if (isNil {_grp getVariable "LB_spawnLineSent"}) then {
    _grp setVariable ["LB_spawnLineSent", true, true];
    private _lines = _spawnLines getOrDefault [_faction, []];
    if (count _lines > 0) then {
        private _msg = selectRandom _lines;
        [_unit, _msg] remoteExec ["globalChat", 0];
    };
};

private _chatter = _chatterLines getOrDefault [_faction, []];

// Periodic chatter loop
while {alive _unit} do {
    sleep (60 + random 120);
    if (count _chatter > 0) then {
        private _msg = selectRandom _chatter;
        [_unit, _msg] remoteExec ["globalChat", 0];
    };
};