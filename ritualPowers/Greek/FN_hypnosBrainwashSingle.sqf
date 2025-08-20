params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusZeus",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _ai = (_player nearEntities ["Man", 50]) select {alive _x && {(side _x getFriend side _player) < 0.6}};
if (_ai isEqualTo []) exitWith {
	["No unit was found for the ritual to commence upon"] remoteExec ["hint", _player];
};

[_player, "STAR_WARS_FIGHT_POWERS_PUSH"] remoteExec ["switchMove", 0, true];

sleep 1.5; 

_brainwashGrp = createGroup (side _player);

[selectRandom _ai] join _brainwashGrp;

[_player, ""] remoteExec ["switchMove", 0, true];

_player setVariable ["ritualStatusZeus", (_player getVariable ["ritualStatusZeus",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;