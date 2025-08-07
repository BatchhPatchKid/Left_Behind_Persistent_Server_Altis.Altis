private _lastSpoken = createHashMap;

while {true} do {
    private _players = allPlayers;

    private _globalFactionsSpoken = [];

	{
		private _player = _x;
		private _nearAI = (_player nearEntities ["Man", 25]) select { !isPlayer _x };

		{
			private _grp = group _x;
			private _faction = _grp getVariable ["LB_faction", ""];
			if (_faction == "" || {_faction in _globalFactionsSpoken}) exitWith {};

			_globalFactionsSpoken pushBack _faction;

			private _leader = leader _grp;
			private _lines = if (behaviour _leader == "COMBAT") then {
				_combatLines getOrDefault [_faction, []]
			} else {
				_chatterLines getOrDefault [_faction, []]
			};

			if (_lines isEqualTo []) exitWith {};

			private _last = _lastSpoken getOrDefault [_faction, 0];
			if (time - _last <= 15) exitWith {};

			private _msg = selectRandom _lines;
			private _nearPlayers = _players select { _x distance _leader <= 500 };
			if (_nearPlayers isNotEqualTo []) then {
				[_leader, _msg] remoteExec ["globalChat", _nearPlayers];
				_lastSpoken set [_faction, time];
			};
		} forEach _nearAI;
	} forEach _players;

    sleep (6 + random 1.2);
};