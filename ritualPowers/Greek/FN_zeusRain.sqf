params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusZeus",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _ai = (_player nearEntities ["Man", 50]) select {alive _x && {(side _x getFriend side _player) < 0.6}};
if (_ai isEqualTo []) exitWith {
	["No unit was found for the ritual to commence upon"] remoteExec ["hint", _player];
};

[_player, "STAR_WARS_FIGHT_POWERS_WAVE"] remoteExec ["switchMove", 0, true];

sleep 2.0; 
	
[_player, ""] remoteExec ["switchMove", 0, true];

{
	private _p = getPosASL _x;
	_x setPosASL [_p # 0, _p # 1, (_p # 2) + random (100)+100];
} forEach _ai;

sleep 3;

{
	if (typeOf _x == "O_soldier_Melee_RUSH") then {
        [_x, 1] remoteExec ["setDamage", 2];
    };

	if (((side _player) getFriend (side _x)) > 0.6 && {!captive _x}) then {
		_player addRating -500000;
	};
} forEach _ai;

_player setVariable ["ritualStatusZeus", (_player getVariable ["ritualStatusZeus",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;