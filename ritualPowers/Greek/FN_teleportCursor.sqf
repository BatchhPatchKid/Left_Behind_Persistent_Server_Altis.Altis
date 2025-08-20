params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusZeus",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _maxRange = 5000;
private _minSeparation = 5;

private _found = false;
private _posASL = [0,0,0];

private _t = cursorTarget;
if (!isNull _t) then {
  private _d = _player distance _t;
  if (_d >= _minSeparation && _d <= _maxRange) then {
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
      private _d2 = _player distance (ASLToAGL _posASL);
      if (_d2 >= _minSeparation && _d2 <= _maxRange) then { _found = true; };
    };
  };
};

if (!_found) exitWith { ["No valid teleport point"] remoteExec ["hint", _player]; };

private _dropASL = _posASL vectorAdd [0,0,0.2];

private _grp = group _player;
{
	if (isPlayer _x) then {
		[_x, "STAR_WARS_FORCE_CHOKE_victim"] remoteExec ["switchMove", 0, true];
	};
} forEach (units _grp);

sleep 1.5;

private _moved = [];
{
  private _obj = if (vehicle _x != _x) then { vehicle _x } else { _x };
  if (!(_obj in _moved)) then {
    _moved pushBack _obj;
    if (local _obj) then { _obj setPosASL _dropASL } else { [_obj, _dropASL] remoteExec ["setPosASL", _obj] };
  };

  [_x, ""] remoteExec ["switchMove", 0, true];
} forEach (units _grp);

_player setVariable ["ritualStatusZeus", (_player getVariable ["ritualStatusZeus",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;