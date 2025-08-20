params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusWanderer",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _ai = (_player nearEntities ["Man", 50]) select {(side _x getFriend side _player) < 0.6};
if (_ai isEqualTo []) exitWith {
	["No was found for the ritual to commence upon"] remoteExec ["hint", _player];
};

[_player, "STAR_WARS_FIGHT_POWERS_PUSH"] remoteExec ["switchMove", 0, true];

sleep 0.25;

private _victim = selectRandom _ai;
_victim remoteExec ["WBK_Goliath_SpecialAttackGroundShard", _victim];

sleep 1.25;

[_player, ""] remoteExec ["switchMove", 0, true];

_player setVariable ["ritualStatusWanderer", (_player getVariable ["ritualStatusWanderer",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;