params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusWanderer",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

LB_fnc_lookUnit = {
  params ["_player", ["_maxRange",3000]];
  private _u = cursorTarget;
  if (isNull _u || {!(_u isKindOf "Man")}) then {
    private _p0 = positionCameraToWorld [0,0,0];
    private _p1 = positionCameraToWorld [0,0,_maxRange];
    private _hits = lineIntersectsSurfaces [AGLToASL _p0, AGLToASL _p1, _player, vehicle _player, true, 1, "VIEW", "FIRE"];
    if (_hits isNotEqualTo []) then { _u = _hits#0#2 };
  };
  if (!isNull _u && { _u isKindOf "Man" }) exitWith { _u };
  objNull
};

// usage (client):
private _targetUnit = [_player, 3000] call LB_fnc_lookUnit;

if (isNull _targetUnit) exitWith { ["No unit was found for the ritual to commence upon"] remoteExec ["hint", _player]; };

[_player, "starWars_lightsaber_style1_attack_push"] remoteExec ["switchMove", 0, true];

sleep 0.5;

if (isPlayer _targetUnit) then {
	private _pos = [[5017.63,20048.2,0], 100, 800, 5, 0, 0.6, 0] call BIS_fnc_findSafePos;
	_targetUnit setPos _pos;
} else {
	deleteVehicle _targetUnit;
};

[_player, ""] remoteExec ["switchMove", 0, true];

_player setVariable ["ritualStatusWanderer", (_player getVariable ["ritualStatusWanderer",0]) - _sub, true];


[_player] spawn FN_updateRitualActions;