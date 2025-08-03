if (!isServer) exitWith {};

missionNamespace setVariable ["garbagePilePositions", []];

// your two distance thresholds
private _minPileDist  = 30;  // min meters from any existing pile
private _garbageTypes = ["Land_GarbageBarrel_02_F"];

while { true } do {
    private _piles = missionNamespace getVariable ["garbagePilePositions", []];

    {
        // _x is each player here
        private _houses = nearestObjects [_x, ["house"], 300];
        private _player = _x;
        {
            // _x is each house here
            private _positions = _x buildingPos -1;
            if (_positions isEqualTo []) then { continue };

            private _pos = selectRandom _positions;
            private _housePos = getPosATL _x;

            if (((_pos distance (getPos _player)) >= 200 && (_pos distance (getPos _player)) <= 300) && (({ _pos distance _x < _minPileDist } count _piles) == 0) && (random 1 > 0.75)) then {
                private _pile = createVehicle [(selectRandom _garbageTypes), _pos, [], 0, "CAN_COLLIDE"];
                _piles pushBack _pos;
                [_pile, _pos] remoteExec ["FN_createGarbagePile", 0, _pile];
            };
        } forEach _houses;
    } forEach allPlayers;

    missionNamespace setVariable ["garbagePilePositions", _piles];
    sleep 120;
};