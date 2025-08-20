params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusWanderer",0]) - _sub < 0) exitWith {
  ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player];
};

private _maxRange = 5000;
private _found = false;
private _posASL = [0,0,0];
private _normal = [0,0,1];

private _t = cursorTarget;
if (!isNull _t) then {
  private _d = _player distance _t;
  if (_d <= _maxRange) then {
    _posASL = getPosASL _t;
    _found = true;
  };
};

if (!_found) then {
  private _p0 = positionCameraToWorld [0,0,1];
  private _p1 = positionCameraToWorld [0,0,_maxRange];
  private _hits = lineIntersectsSurfaces [AGLToASL _p0, AGLToASL _p1, _player, vehicle _player, true, 1, "VIEW", "FIRE"];
  if (_hits isNotEqualTo []) then {
    private _hitObj = _hits # 0 # 2;
    if (isNull _hitObj || { _hitObj != _player && { _hitObj != vehicle _player } }) then {
      _posASL = _hits # 0 # 0;
      _normal = _hits # 0 # 1;
      private _d2 = _player distance (ASLToAGL _posASL);
      if (_d2 <= _maxRange) then { _found = true; };
    };
  };
};

if (!_found) exitWith {
  ["No valid placement point"] remoteExec ["hint", _player];
};

[_player, "starWars_lightsaber_style1_attack_push"] remoteExec ["switchMove", 0, true];
sleep 0.25;

// --- Black sphere projectile ---
private _startATL = getPosATL _player; 
_startATL set [2, (_startATL select 2) + 1.5];
private _dstATL = ASLToATL _posASL;

private _s = createVehicle ["Sign_Sphere10cm_F", _startATL, [], 0, "CAN_COLLIDE"];
_s setObjectMaterialGlobal [0, "\A3\Data_F\default.rvmat"];
_s setObjectTextureGlobal  [0, "#(rgb,8,8,3)color(0,0,0,1)"];
_s setObjectScale 2.0;

// travel loop
private _speed = 200;
private _eps2D = 1;

private _p = getPosATL _s;
private _dx = (_dstATL select 0) - (_p select 0);
private _dy = (_dstATL select 1) - (_p select 1);
private _dist2D = sqrt (_dx*_dx + _dy*_dy);

sleep 1.05;

[_player, ""] remoteExec ["switchMove", 0, true];

private _dt = 0.05;
private _deadline = time + 60;

while {alive _s && time < _deadline} do {
  _p = getPosATL _s;
  _dx = (_dstATL#0) - (_p#0);
  _dy = (_dstATL#1) - (_p#1);
  _dist2D = sqrt (_dx*_dx + _dy*_dy);

  if (_dist2D <= _eps2D) exitWith { _s setPosATL [_dstATL#0, _dstATL#1, (_p#2) max 0.5]; };

  private _step = (_speed * _dt) min _dist2D;
  if (_dist2D > 0) then {
    private _ux = _dx / _dist2D;
    private _uy = _dy / _dist2D;
    private _nx = (_p#0) + _ux * _step;
    private _ny = (_p#1) + _uy * _step;
    private _nz = (_p#2) max 0.5;  // keep at least 0.5 ATL above ground; tune as needed
    _s setPosATL [_nx, _ny, _nz];
  };
  sleep _dt;
};

// snap to destination
_s setPosASL _posASL;
_s setVectorUp _normal;

// expand in place
private _scale = getObjectScale _s;
for "_i" from 1 to 30 do {
  _scale = _scale * 1.12;
  _s setObjectScale _scale;
  sleep 0.02;
};

// apply effects
private _victims = _s nearEntities ["Man", 7];

{
	[_x, "flamethrower_burning_3"] remoteExec ["switchMove", 0, true];

    if (!isPlayer _x) then {
       
	   //kill if the unit is melee
	   if (typeOf _x == "O_soldier_Melee_RUSH") then {
			[_x, 1] remoteExec ["setDamage", 2];
		} else {
			_x setRandomLip false;
			_x setSpeaker "NoVoice";
			_x disableAI "ALL";
		};
    } else {
		[_x, ""] remoteExec ["switchMove", 0, true];
	};

    if (((side _player) getFriend (side _x)) > 0.6 && {!captive _x}) then {
        _player addRating -500000;
    };
} forEach _victims;

deleteVehicle _s;

_player setVariable ["ritualStatusWanderer", (_player getVariable ["ritualStatusWanderer",0]) - _sub, true];
[_player] spawn FN_updateRitualActions;