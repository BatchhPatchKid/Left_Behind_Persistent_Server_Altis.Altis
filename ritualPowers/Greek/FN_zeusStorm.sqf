params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusZeus",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _radius = 50;
private _radiusMin = 8;
private _numOfExtraLightning = round (random 20);

private _r = 8;
private _n = 5;
private _base = random 360;

[_player, "STAR_WARS_FIGHT_POWERS_WAVE"] remoteExec ["switchMove", 0, true];


for "_i" from 0 to (_n - 1) do {
	private _a = _base + _i * (360 / _n);
	private _posAGL = _player modelToWorld [_r * cos _a, _r * sin _a, 0];
	private _m = "Land_HelipadEmpty_F" createVehicle _posAGL;
	_m setPosASL (AGLToASL _posAGL);
	[_m, nil, true] remoteExec ["BIS_fnc_moduleLightning", 0];
	uiSleep 0.15;
};
	
[_player, ""] remoteExec ["switchMove", 0, true];

for "_i" from 0 to _numOfExtraLightning do {
	private _angle = random 360;
	private _r = sqrt (random 1 * (_radius*_radius - _radiusMin*_radiusMin) + (_radiusMin*_radiusMin)); 
	
	private _base = getPosATL _player;
	private _posAGL = [(_base # 0) + _r * sin _angle, (_base # 1) + _r * cos _angle, 0];

	private _m = "Land_HelipadEmpty_F" createVehicle _posAGL;
	_m setPosASL (AGLToASL _posAGL);
	[_m, nil, true] remoteExec ["BIS_fnc_moduleLightning", 0];

	private _victims = _m nearEntities ["Man", 6];
	{
		if (typeOf _x == "O_soldier_Melee_RUSH") then {
			[_x, 1] remoteExec ["setDamage", 2];
		};

		if (((side _player) getFriend (side _x)) > 0.6 && {!captive _x}) then {
			_player addRating -500000;
		};
	} forEach _victims;
	

	uiSleep (random 1);
};

_player setVariable ["ritualStatusZeus", (_player getVariable ["ritualStatusZeus",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;