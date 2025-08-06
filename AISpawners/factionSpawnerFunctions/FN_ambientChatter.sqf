/*
    Handles radio chatter for AI units.
    Params: [ _unit, _faction ]
*/

params ["_unit", "_faction"];

// ensure we run only where the unit is local
if (!local _unit) exitWith {};

private _spawnLines = missionNamespace getVariable ["LB_spawnLines", createHashMapFromArray []];
private _chatterLines = missionNamespace getVariable ["LB_chatterLines", createHashMapFromArray []];
private _combatLines = missionNamespace getVariable ["LB_combatLines", createHashMapFromArray []];
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

        {
			private _player = _x;
			// check distance
			if ((_player distance _unit) <= 25) then {
				_unit customChat _msg;
			};
		} forEach allPlayers;
    };
};

private _chatter = _chatterLines getOrDefault [_faction, []];
private _combat = _combatLines getOrDefault [_faction, []];

[_unit, _faction, _lines, _combat, _chatter] spawn {
    params ["_unit", "_faction", "_lines", "_combat", "_chatter"];
    // Periodic chatter loop

    publicVariable "_channelID_BB";

    while {alive _unit} do {
        sleep (6.0 + random 1.20);
        private _lines = if (behaviour _unit == "COMBAT") then { _combat } else { _chatter };
        if (count _lines > 0) then {
            private _msg = selectRandom _lines;
            private _nearPlayers = allPlayers select { _x distance _unit < 25 };
            
            {
                _unit customChat [_channelID_BB, _msg];
            } forEach _nearPlayers
        };
    };
};