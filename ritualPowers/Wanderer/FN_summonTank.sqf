params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusWanderer",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _class  = "WBK_SpecialZombie_Smasher_3";
private _radius = 20;

private _tmpGrp = createGroup (side _player);

[_player, "flamethrower_burning_3"] remoteExec ["switchMove", 0, true];

private _a = random 360;
private _r = 3 + random (_radius max 3);
private _pos = _player modelToWorld [_r * sin _a, _r * cos _a, 0];
_pos set [2,0];
_tmpGrp createUnit [_class, _pos, [], 0, "FORM"];

{ 
	[_x] joinSilent (group _player);
	_x setRandomLip false;
	_x setSpeaker "NoVoice";
} forEach units _tmpGrp;
deleteGroup _tmpGrp;

sleep 3.5;

[_player, ""] remoteExec ["switchMove", 0, true];

_player setVariable ["ritualStatusWanderer", (_player getVariable ["ritualStatusWanderer",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;