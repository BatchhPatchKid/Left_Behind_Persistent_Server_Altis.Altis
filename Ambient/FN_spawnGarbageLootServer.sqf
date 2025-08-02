if (!isServer) exitWith {};

missionNamespace setVariable ["garbagePilePositions", []];

while {true} do {
    private _piles = missionNamespace getVariable ["garbagePilePositions", []];
    hint "made it";
    {
        private _houses = nearestObjects [_x, ["house"], 300];
        {
            private _positions = _x buildingPos -1;
            if (_positions isEqualTo []) then {continue};
            private _pos = selectRandom _positions;
            if (({ _pos distance _y < 10 } count _piles) == 0 && {random 1 < 0.25}) then {
                private _pile = createVehicle ["Land_GarbageHeap_01_F", _pos, [], 0, "CAN_COLLIDE"];
                _piles pushBack _pos;
                [_pile, _pos] remoteExec ["FN_createGarbagePile", 0, _pile];
            };
        } forEach _houses;
    } forEach allPlayers;
    missionNamespace setVariable ["garbagePilePositions", _piles];
    sleep 5;
};