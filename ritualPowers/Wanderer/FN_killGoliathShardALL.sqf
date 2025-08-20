params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusWanderer",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _ai = _player nearEntities ["Man", 50]; 
if (_ai isEqualTo []) exitWith {
	["No unit was found for the ritual to commence upon"] remoteExec ["hint", _player];
};

[_player, "STAR_WARS_FIGHT_POWERS_WAVE"] remoteExec ["switchMove", 0, true];

sleep 0.5;

{
	_x remoteExec ["WBK_Goliath_SpecialAttackGroundShard", _x];
	if (((side _player) getFriend (side _x)) > 0.6 && {!captive _x}) then {
    _player addRating -500000;
};
} forEach _ai;

sleep 1.5;

[_player, ""] remoteExec ["switchMove", 0, true];

_player setVariable ["ritualStatusWanderer", (_player getVariable ["ritualStatusWanderer",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;