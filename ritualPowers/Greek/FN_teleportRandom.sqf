params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusZeus",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _pos = [_player, 100, 1000, 5, 0, 0.6, 0] call BIS_fnc_findSafePos;

[_player, "STAR_WARS_FORCE_CHOKE_victim"] remoteExec ["switchMove", 0, true];

sleep 1.5;

_player setPos _pos;

[_player, ""] remoteExec ["switchMove", 0, true];

_player setVariable ["ritualStatusZeus", (_player getVariable ["ritualStatusZeus",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;