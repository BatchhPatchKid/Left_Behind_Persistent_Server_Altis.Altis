params ["_player", "_sub"];

if ((_player getVariable ["ritualStatus",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _ai = (_player nearEntities ["Man", 50]) select {(side _x getFriend side _player) < 0.6};
if (_ai isEqualTo []) exitWith {
	["No was found for the ritual to commence upon"] remoteExec ["hint", _player];
};

[_player, "STAR_WARS_FIGHT_POWERS_PUSH"] remoteExec ["switchMove", _player];

sleep 0.25;

private _victim = selectRandom _ai;
_victim remoteExec ["WBK_Goliath_SpecialAttackGroundShard", _victim];

sleep 1.25;

[_player, ""] remoteExec ["switchMove", _player];

_player setVariable ["ritualStatus", (_player getVariable ["ritualStatus",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;