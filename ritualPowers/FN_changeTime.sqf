params ["_player", "_sub", "_time"];

if ((_player getVariable ["ritualStatus",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

[_player, "flamethrower_burning_3"] remoteExec ["switchMove", _player];

sleep 2.5;

private _newDate = [date#0, date#1, date#2, _time, 0];
[_newDate] remoteExecCall ["setDate", 2];

sleep 0.5;

[_player, ""] remoteExec ["switchMove", _player];

_player setVariable ["ritualStatus", (_player getVariable ["ritualStatus",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;