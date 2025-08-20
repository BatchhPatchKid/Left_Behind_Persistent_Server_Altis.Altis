params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusZeus",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _ai = (_player nearEntities ["Man", 25]) select {alive _x && {(side _x getFriend side _player) >= 0.6}};

[_player, "STAR_WARS_FIGHT_POWERS_OTHER_HEAL"] remoteExec ["switchMove", 0, true];

sleep 3;

{
	_x setDamage 0;
	[objNull, _x] call ace_medical_treatment_fnc_fullHeal;
} forEach _ai;

[_player, ""] remoteExec ["switchMove", 0, true];

_player setVariable ["ritualStatusZeus", (_player getVariable ["ritualStatusZeus",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;