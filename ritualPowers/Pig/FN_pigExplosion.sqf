params ["_player", "_sub"];

if ((_player getVariable ["ritualStatusPig",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

private _ai = (_player nearEntities ["Man", 150]) select {alive _x && {(side _x getFriend side _player) < 0.6}};
if (_ai isEqualTo []) exitWith {
	["No was found for the ritual to commence upon"] remoteExec ["hint", _player];
};

[_player, "STAR_WARS_FIGHT_POWERS_PUSH"] remoteExec ["switchMove", 0, true];

sleep .5;

private _victim = selectRandom _ai;
private _explosive = createMine ["IEDUrbanBig_F", (getPosATL _victim), [], 0];

sleep 0.15;

private _victims = _explosive nearEntities ["Man", 10];
{
  if (typeOf _x == "O_soldier_Melee_RUSH") then {
      [_x, 1] remoteExec ["setDamage", 2];
  };

  if (((side _player) getFriend (side _x)) > 0.6 && {!captive _x}) then {
    _player addRating -500000;
};
} forEach _victims;

_explosive setDamage 1;

sleep 1.25;

[_player, ""] remoteExec ["switchMove", 0, true];

_player setVariable ["ritualStatusPig", (_player getVariable ["ritualStatusPig",0]) - _sub, true];

[_player] spawn FN_updateRitualActions;