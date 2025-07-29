/*
    FN_updateDrinkActions.sqf
    -------------------------
    Creates ACE self actions for each drinkable item in the player's inventory.
    Removes the action after the item is consumed.
    Usage:
        [player] call FN_updateDrinkActions;
*/

params ["_player"];

// Remove previously created drink actions
if (isNil { _player getVariable "LB_currentDrinkActions" }) then {
    _player setVariable ["LB_currentDrinkActions", []];
};

{
    [_player, 1, ["ACE_SelfActions", "Main", "Survival System", "Survival Actions", "Drink"], _x select 1] call ace_interact_menu_fnc_removeActionFromObject;
} forEach (_player getVariable ["LB_currentDrinkActions", []]);

_player setVariable ["LB_currentDrinkActions", []];

// Retrieve drinkable item arrays
private _sodas         = ["drinkSodas"]         call (missionNamespace getVariable "FN_arrayReturn");
private _waterBottles  = ["drinkWaterBottles"]  call (missionNamespace getVariable "FN_arrayReturn");
private _canteens      = ["drinkCanteens"]      call (missionNamespace getVariable "FN_arrayReturn");
private _dirty         = ["drinkDirty"]         call (missionNamespace getVariable "FN_arrayReturn");
private _blood         = ["drinkBlood"]         call (missionNamespace getVariable "FN_arrayReturn");

private _allDrinks = _sodas + _waterBottles + _canteens + _dirty + _blood;

// Loop through each drink item and add ACE action if player has it
{
    private _item = _x;

    if ([_player, _item] call BIS_fnc_hasItem) then {
        private _displayName = getText (configFile >> "CfgWeapons" >> _item >> "displayName");
        if (_displayName isEqualTo "") then { _displayName = _item };

        private _action = [
            format ["drink_%1", _item],
            format ["Drink %1", _displayName],
            "",
            {
                params ["_target", "_player", "_params"];
                private _itemName = _params select 0;

                // Call the actual drink function
                [_player, _itemName] call FN_drinkWater;

                // Remove the action after consumption
                private _actions = _player getVariable ["LB_currentDrinkActions", []];
                {
                    private _storedItem = _x select 0;
                    private _storedAction = _x select 1;
                    if (_storedItem isEqualTo _itemName) exitWith {
                        [_player, 1, ["ACE_SelfActions", "Main", "Survival System", "Survival Actions", "Drink"], _storedAction] call ace_interact_menu_fnc_removeActionFromObject;
                        _actions deleteAt _forEachIndex;
                    };
                } forEach _actions;

                _player setVariable ["LB_currentDrinkActions", _actions];
            },
            { true },
            {},
            [_item]
        ] call ace_interact_menu_fnc_createAction;

        // Add the action to the player
        [_player, 1, ["ACE_SelfActions", "Main", "Survival System", "Survival Actions", "Drink"], _action] call ace_interact_menu_fnc_addActionToObject;

        // Track the action with the associated item
        private _currentActions = _player getVariable ["LB_currentDrinkActions", []];
        _currentActions pushBack [_item, _action];
        _player setVariable ["LB_currentDrinkActions", _currentActions];
    };
} forEach _allDrinks;