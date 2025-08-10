/*
    FN_hasDrink.sqf
    ----------------
    Returns true if the given player has any drinkable item in their inventory.
    Usage:
        [player] call FN_hasDrink;
*/
params ["_player"];

private _arrayReturn = LB_fnc_arrayReturn;
private _sodas        = ["drinkSodas"] call _arrayReturn;
private _waterBottles = ["drinkWaterBottles"] call _arrayReturn;
private _canteens     = ["drinkCanteens"] call _arrayReturn;
private _dirty        = ["drinkDirty"] call _arrayReturn;
private _blood        = ["drinkBlood"] call _arrayReturn;

private _allDrinks = _sodas + _waterBottles + _canteens + _dirty + _blood;

{
    if ([_player, _x] call BIS_fnc_hasItem) exitWith {true};
} forEach _allDrinks;

false