params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusPig",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _ai = _player nearEntities ["Man", 100];
private _ai = (_player nearEntities ["Man", 100]) select {alive _x && {lifeState _x != "INCAPACITATED"} && {[_x] call ace_common_fnc_isAwake}};
if (_ai isEqualTo []) exitWith {
	["No unit was found for the ritual to commence upon"] remoteExec ["hint", _player];
};

[_player, "STAR_WARS_FIGHT_POWERS_WAVE"] remoteExec ["switchMove", 0, true];

sleep 2.0;  
	
[_player, ""] remoteExec ["switchMove", 0, true];

{
	[_x, "flamethrower_burning_3"] remoteExec ["switchMove", 0, true];
} forEach _ai;

sleep 3.5;

{
	if (isPlayer _x) then {
		[_x, ""] remoteExec ["switchMove", 0, true];
	} else {
		_x setUnconscious true;
		_x setRandomLip false;
		_x setSpeaker "NoVoice";
	};
} forEach _ai;

_player setVariable ["ritualStatusPig", (_player getVariable ["ritualStatusPig",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;