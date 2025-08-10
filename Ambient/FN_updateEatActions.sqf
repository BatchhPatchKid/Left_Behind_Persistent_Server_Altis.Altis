/*
    FN_updateEatActions.sqf
    ----------------------
    Updates the "Eat" submenu and hooks into the new FN_eatFood signature.
    Usage (client-side only): [player] call FN_updateEatActions;
*/

params ["_player"];

// 1. Define the parent branch path
private _branchParent = ["ACE_SelfActions","Survival_System","Eat"];

// 2. Remove all old Eat actions by their full-paths
private _oldEntries = _player getVariable ["LB_currentEatEntries", []];
{
    [typeOf _player, 1, _x, false] call ace_interact_menu_fnc_removeActionFromClass;
} forEach _oldEntries;

// 3. Gather master list of all possible edibles
private _categories = ["foodTier1","foodTier2","foodTier3","foodTier4","foodTier5","foodTier6","foodTier7","foodTier8","foodTier9","foodTier10","foodTier11"];
private _masterList = [];
{
    _masterList append ([_x] call (missionNamespace getVariable "FN_arrayReturn"));
} forEach _categories;

// 4. For each food the player actually has, create an ACE action
private _newEntries = [];
{
    private _item = _x;
    if ([_player, _item] call BIS_fnc_hasItem) then {
        private _dn = getText (configFile >> "CfgWeapons" >> _item >> "displayName");
        if (_dn isEqualTo "") then {
            _dn = getText (configFile >> "CfgMagazines" >> _item >> "displayName");
            if (_dn isEqualTo "") then { _dn = _item; };
        };

        private _action = [
            format ["eat_%1", _item],
            format ["Eat %1", _dn],
            "",
            {   params ["_t","_p","_params"];
                private _success = [_p, _params select 0] call FN_eatFood;
                if (_success) then { [_p] call FN_updateEatActions; };
            },
            { true },
            {},
            [_item]
        ] call ace_interact_menu_fnc_createAction;

        private _fullPath = [typeOf _player,1,_branchParent,_action] call ace_interact_menu_fnc_addActionToClass;

        _newEntries pushBack _fullPath;
    };
} forEach _masterList;

// 5. Store the fullPaths for precise removal next time
_player setVariable ["LB_currentEatEntries", _newEntries, true];