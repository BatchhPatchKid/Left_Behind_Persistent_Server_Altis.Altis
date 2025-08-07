while { true } do {

    // Preload once
    private _players = allPlayers;
    private _combatLines  = missionNamespace getVariable ["LB_combatLines",  createHashMapFromArray []];
    private _chatterLines = missionNamespace getVariable ["LB_chatterLines", createHashMapFromArray []];

    // Find all AI leaders
    private _leaders = allUnits select {
        (!isPlayer _x) && ((leader group _x) == _x)
    };

    {
        private _leader  = _x;
        private _grp = group _leader;
        private _faction = _grp getVariable ["LB_faction", ""];

        // Choose appropriate lines
        private _lines = _chatterLines getOrDefault [_faction, []];
        if (behaviour _leader == "COMBAT") then {
            _lines = _combatLines getOrDefault [_faction, []];
        };

        if (!(_lines isEqualTo [])) then {
            // Pick a random line
            private _msg = _faction +": " + selectRandom _lines;

            // Find nearby players
            private _nearPlayers = _players select {
                _x distance _leader <= 50
            };

            if (_nearPlayers isNotEqualTo []) then {
                // Broadcast the formatted text
                [_leader, _msg] remoteExec ["globalChat", _nearPlayers];
            };
        };
    } forEach _leaders;

    sleep (60 + random 120);
};