/*
    Registers an AI group’s radio-chatter data.
    Called once per group (e.g. when the group is created).

    Params: [ _grp, _faction ]
*/
params ["_grp", "_faction"];

private _leader = leader _grp;

// Only run on the machine where the leader is local
if (!local _leader) exitWith {};

// Initialise group data once
if (isNil { _grp getVariable "LB_chatterInit" }) then {
    _grp setVariable ["LB_chatterInit", true];
    _grp setVariable ["LB_faction", _faction, true];

    // play a single spawn-line if a player is nearby
    private _spawnLines = missionNamespace getVariable ["LB_spawnLines", createHashMapFromArray []];
    private _lines = _spawnLines getOrDefault [_faction, []];
    private _msg = _faction +": ";
    if (count _lines > 0) then {
        private _msg = _faction + ": " + selectRandom _lines;
        private _nearPlayers = allPlayers select { _x distance _leader <= 50 };
        if (count _nearPlayers > 0) then {
            [_leader, _msg] remoteExec ["globalChat", _nearPlayers];
        };
    };

    // Register "Fired" event-handler on the leader
    _leader addEventHandler ["Fired", {
        params ["_unit"];
        private _grp  = group _unit;
        private _faction = _grp getVariable ["LB_faction", ""];
        private _map  = missionNamespace getVariable ["LB_firedLines", createHashMapFromArray []];
        private _lines = _map getOrDefault [_faction, []];
        if (_lines isNotEqualTo []) then {
            private _msg = _faction + ": " + selectRandom _lines;
            private _nearPlayers = allPlayers select { _x distance _unit <= 50 };
            if (_nearPlayers isNotEqualTo []) then {
                [_unit, _msg] remoteExec ["globalChat", _nearPlayers];
            };
        };
    }];

    // Register "Hit" event-handler on the leader
    _leader addEventHandler ["Hit", {
        params ["_unit"];
        private _grp = group _unit;
        private _faction = _grp getVariable ["LB_faction", ""];
        private _map = missionNamespace getVariable ["LB_hitLines", createHashMapFromArray []];
        private _lines = _map getOrDefault [_faction, []];
        if (_lines isNotEqualTo []) then {
            private _msg = _faction + ": " + selectRandom _lines;
            private _nearPlayers = allPlayers select { _x distance _unit <= 50 };
            if (_nearPlayers isNotEqualTo []) then {
                [_unit, _msg] remoteExec ["globalChat", _nearPlayers];
            };
        };
    }];

    // Register "Killed" event-handler on the leader
    _leader addEventHandler ["Killed", {
        params ["_unit"];
        private _grp = group _unit;
        private _faction = _grp getVariable ["LB_faction", ""];
        private _map = missionNamespace getVariable ["LB_deathLines", createHashMapFromArray []];
        private _lines = _map getOrDefault [_faction, []];
        if (_lines isNotEqualTo []) then {
            private _msg = _faction + ": " + selectRandom _lines;
            private _nearPlayers = allPlayers select { _x distance _unit <= 50 };
            if (_nearPlayers isNotEqualTo []) then {
                [_unit, _msg] remoteExec ["globalChat", _nearPlayers];
            };
        };
    }];
};