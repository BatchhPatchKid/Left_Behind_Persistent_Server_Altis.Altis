params ["_pos", "_minDist", "_maxDist", "_playerDist"];

private _safePos = [];
private _attempts = 0;

while {_attempts < 30} do {
    _attempts = _attempts + 1;
    private _dir = random 360;
    private _dist = _minDist + random (_maxDist - _minDist);
    private _candidate = _pos getPos [_dist, _dir];

    if (surfaceIsWater _candidate) then { continue; };
    if (_candidate isFlatEmpty [1, -1, 0.3, 2, 0, false] isEqualTo []) then { continue; };

    private _tooClose = false;
    {
        if (_candidate distance (getPos _x) < _playerDist) exitWith {
            _tooClose = true;
        };
    } forEach allPlayers;
    if (_tooClose) then { continue; };

    _safePos = _candidate;
    break;
};

if (_safePos isEqualTo []) then { _safePos = _pos; };
_safePos