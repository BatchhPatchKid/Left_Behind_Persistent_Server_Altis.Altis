params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusPig",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

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

if (!_found) exitWith { ["No valid placement point"] remoteExec ["hint", _player]; };

[_player, "starWars_lightsaber_style1_attack_push"] remoteExec ["switchMove", 0, true];

sleep 0.25;

// exact Z where you're looking:
private _ied = createMine ["IEDUrbanSmall_F", [0,0,0], [], 0];
_ied setPosASL _posASL;
_ied setVectorUp _normal;

private _victims = _ied nearEntities ["Man", 3];
{
  if (typeOf _x == "O_soldier_Melee_RUSH") then {
      [_x, 1] remoteExec ["setDamage", 2];
  };

  if (((side _player) getFriend (side _x)) > 0.6 && {!captive _x}) then {
    _player addRating -500000;
};
} forEach _victims;

_ied setDamage 1;

sleep 1.25;

[_player, ""] remoteExec ["switchMove", 0, true];

_player setVariable ["ritualStatusPig", (_player getVariable ["ritualStatusPig",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;