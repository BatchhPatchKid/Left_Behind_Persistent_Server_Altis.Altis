params ["_player", "_sub"];

if ((_player getVariable ["ritualStatus",0])-_sub < 0 ) exitWith { ["You do not hold enough ritual power to cast this spell"] remoteExec ["hint", _player]; };

[_player, "STAR_WARS_FIGHT_POWERS_OTHER_HEAL"] remoteExec ["switchMove", _player];

sleep 2;

_player setDamage 0;
[objNull, _player] call ace_medical_treatment_fnc_fullHeal;

[_player, ""] remoteExec ["switchMove", _player];

_player setVariable ["ritualStatus", (_player getVariable ["ritualStatus",0]) + _sub, true];

[_player] spawn FN_updateRitualActions;