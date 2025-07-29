/*
    FN_updateDrinkActions.sqf
    -------------------------
    Creates ACE self actions for each drinkable item in the player's inventory.
    Usage:
        [player] call FN_updateDrinkActions;
*/

params ["_player"];

// Remove previously created drink actions
if (isNil "LB_currentDrinkActions") then { LB_currentDrinkActions = []; };
{
    [(typeOf _player), 1, ["ACE_SelfActions","Main","Survival System", "Survival Actions"], _x] call ace_interact_menu_fnc_removeActionFromClass;
} forEach LB_currentDrinkActions;
LB_currentDrinkActions = [];

private _sodas = ["drinkSodas"] call (missionNamespace getVariable "FN_arrayReturn");
private _waterBottles = ["drinkWaterBottles"] call (missionNamespace getVariable "FN_arrayReturn");
private _canteens = ["drinkCanteens"] call (missionNamespace getVariable "FN_arrayReturn");
private _dirty = ["drinkDirty"] call (missionNamespace getVariable "FN_arrayReturn");
private _blood = ["drinkBlood"] call (missionNamespace getVariable "FN_arrayReturn");

private _all = _sodas + _waterBottles + _canteens + _dirty + _blood;

{
    private _item = _x;
    if ([_player, _item] call BIS_fnc_hasItem) then {
        private _displayName = getText(configFile >> "CfgWeapons" >> _item >> "displayName");
        if (_displayName == "") then { _displayName = _item; };
        private _action = [format["drink_%1", _item], format["Drink %1", _displayName], "", { params ["_target","_player","_params"]; [_player, _params select 0] call FN_drinkWater; }, {true}, {}, [_item]] call ace_interact_menu_fnc_createAction;
        [(typeOf _player), 1, ["ACE_SelfActions","Main","Survival System", "Survival Actions"], _action] call ace_interact_menu_fnc_addActionToClass;
        LB_currentDrinkActions pushBack _action;
    };
} forEach _all;