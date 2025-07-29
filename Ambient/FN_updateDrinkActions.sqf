params ["_player"];
if (isNil "LB_currentDrinkActions") then { LB_currentDrinkActions = []; };

// First remove all old actions
{
    [(typeOf _player), 1, ["ACE_SelfActions","Main","Survival System", "Survival Actions", "Drink"], _x] call ace_interact_menu_fnc_removeActionFromClass;
} forEach LB_currentDrinkActions;
LB_currentDrinkActions = [];

private _drinkables = (["drinkSodas", "drinkWaterBottles", "drinkCanteens", "drinkDirty", "drinkBlood"] apply {
    [_x] call (missionNamespace getVariable "FN_arrayReturn")
}) joinString [];

private _itemsPlayer = items player;

{
    private _item = _x;
    if (_item in _itemsPlayer) then {
        private _displayName = getText(configFile >> "CfgWeapons" >> _item >> "displayName");
        if (_displayName == "") then { _displayName = _item; };

        private _action = [
            format["drink_%1", _item],
            format["Drink %1", _displayName],
            "",
            {
                params ["_target","_player","_params"];
                private _item = _params select 0;
                private _success = [_player, _item] call FN_drinkWater;

                if (_success) then {
                    // Remove action if item was consumed
                    [_item] call {
                        private _id = format["drink_%1", _this];
                        {
                            if (_x select 0 == _id) exitWith {
                                [(typeOf _player), 1, ["ACE_SelfActions","Main","Survival System", "Survival Actions", "Drink"], _x] call ace_interact_menu_fnc_removeActionFromClass;
                                LB_currentDrinkActions deleteAt _forEachIndex;
                            };
                        } forEach LB_currentDrinkActions;
                    };
                };
            },
            {
                // Only show action if the player has the item still
                params ["_target", "_player", "_params"];
                (_params select 0) in (items _player)
            },
            {},
            [_item]
        ] call ace_interact_menu_fnc_createAction;

        [(typeOf _player), 1, ["ACE_SelfActions","Main","Survival System", "Survival Actions", "Drink"], _action] call ace_interact_menu_fnc_addActionToClass;
        LB_currentDrinkActions pushBack _action;
    };
} forEach _drinkables;