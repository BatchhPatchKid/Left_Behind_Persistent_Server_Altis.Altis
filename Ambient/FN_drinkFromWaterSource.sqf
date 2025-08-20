params ["_player"];

//1. Give Radiation posioning equal to half of the hydration given
private _current = _player getVariable ["hydrationLevel", 100];

private _radAmount = (100 - _current)/2;
private _currentRad = _player getVariable ["Rad", 0];
_player setVariable ["Rad", _currentRad + _radAmount, true];

_arr = (itemsWithMagazines _player) select { _x == "rvg_geiger" };
if ((count _arr) > 0) then {
	[_player, ["rvg_geiger_1", 100, 1]] remoteExec ["say3D"];
};

//2. Make the player complete an animation + set hydration
[_player, "ace_field_rations_drinkCrouchCan"] remoteExec ["switchMove", 0, true];

_player setVariable ["hydrationLevel", 100, true]; //drinking from water source sets the hydration to 100

sleep 4;

//3. Release player and inform them it worked
[_player, ""] remoteExec ["switchMove", 0, true];

["You successfully drank from the water source"] remoteExec ["hintSilent", _player];