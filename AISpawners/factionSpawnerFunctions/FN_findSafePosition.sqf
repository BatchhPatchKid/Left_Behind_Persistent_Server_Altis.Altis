params ["_pos", "_minDist", "_maxDist", "_playerDist"];
private _safePos = [];
private _safePosFound = false;
while {!_safePosFound} do {
    _safePos = [_pos, _minDist, _maxDist, 10, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
    _safePosFound = true;
    {
        if (_safePos distance (getPos _x) < _playerDist) exitWith {
            _safePosFound = false;
        };
    } forEach allPlayers;
};
_safePos