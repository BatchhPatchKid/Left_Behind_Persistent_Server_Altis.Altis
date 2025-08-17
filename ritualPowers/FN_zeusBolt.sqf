params ["_player", "_sub"];

if ((_player getVariable ["ritualStatus",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _maxRange = 3000;

private _found = false;
private _posASL = [0,0,0];

// 1) Crosshair target only (no cursorObject fallback)
private _t = cursorTarget;
if (!isNull _t) then {
	private _d = _player distance _t;
	if (_d <= _maxRange) then {
		_posASL = getPosASL _t;
		_found = true;
	};
};

// 2) Camera raycast up to _maxRange if no valid crosshair target
if (!_found) then {
	private _p0 = positionCameraToWorld [0,0,1];                          // 1 m ahead of camera
	private _p1 = positionCameraToWorld [0,0,_maxRange];
	private _hits = lineIntersectsSurfaces [AGLToASL _p0, AGLToASL _p1, _player, vehicle _player, true, 1, "VIEW", "FIRE"];
	if (_hits isNotEqualTo []) then {
		private _hitObj = _hits # 0 # 2;
		// ignore hitting yourself / your vehicle
		if (isNull _hitObj || { _hitObj != _player && { _hitObj != vehicle _player } }) then {
			_posASL = _hits # 0 # 0;
			private _d2 = _player distance (ASLToAGL _posASL);
			if (_d2 <= _maxRange) then { _found = true; };
		};
	};
};

// Bail out if no safe, in-range point found (prevents “strike on player”)
if (!_found) exitWith {
	["No position for Zeus's bolt was found"] remoteExec ["hint", player];
};

[_player, "starWars_lightsaber_style1_attack_push"] remoteExec ["switchMove", _player];
sleep 0.5;

private _m = "Land_HelipadEmpty_F" createVehicle (ASLToAGL _posASL);
_m setPosASL _posASL;
[_m, nil, true] remoteExec ["BIS_fnc_moduleLightning", 0];

//For sure killing all AI in the area around the lightning bolt
private _victims = _m nearEntities ["Man", 6]; 
{ [_x, 1] remoteExec ["setDamage", 2]; } forEach _victims;

sleep 1;
[_player, ""] remoteExec ["switchMove", _player];

_player setVariable ["ritualStatus", (_player getVariable ["ritualStatus",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;