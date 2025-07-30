/*
    FN_updateDrinkActions.sqf
    -------------------------
    Updates the “Drink” submenu and hooks into the new FN_drinkWater signature.
    Usage (client‑side only): [player] call FN_updateDrinkActions;
*/

params ["_player"];

// 1. Define the parent branch path
private _branchParent = [
    "ACE_SelfActions",
    "Main",
    "Survival System",
    "Survival Actions",
    "Drink"
];

// 2. Remove all old Drink actions by their full‑paths
private _oldEntries = _player getVariable ["LB_currentDrinkEntries", []];
{
    // _x is the fullPath array returned previously by addActionToClass
    [typeOf _player, 1, _x, false] call ace_interact_menu_fnc_removeActionFromClass;
} forEach _oldEntries;

// 3. Gather master list of all possible drinkables
private _categories = [
    "drinkSodas",
    "drinkWaterBottles",
    "drinkCanteens",
    "drinkDirty",
    "drinkBlood"
];
private _masterList = [];
{
    _masterList append ([_x] call (missionNamespace getVariable "FN_arrayReturn"));
} forEach _categories;

// 4. For each drinkable the player actually has, create an ACE action
private _newEntries = [];
{
    private _item = _x;
    if ([_player, _item] call BIS_fnc_hasItem) then {
        // a) Resolve a display name
        private _dn = getText (configFile >> "CfgWeapons"   >> _item >> "displayName");
        if (_dn isEqualTo "") then {
            _dn = getText (configFile >> "CfgMagazines" >> _item >> "displayName");
            if (_dn isEqualTo "") then { _dn = _item; };
        };

        // b) Build the action array, passing _item to FN_drinkWater
        private _action = [
            format ["drink_%1", _item],           // internal ID
            format ["Drink %1", _dn],             // visible text
            "",                                   // icon (none)
            {   params ["_t","_p","_params"];
                // Call the new FN_drinkWater signature
                private _success = [_p, _params select 0] call FN_drinkWater;
                // If it returned true (consumed), re‑run the updater
                if (_success) then { [_p] call FN_updateDrinkActions; };
            },
            { true },                             // show condition (always shown if in list)
            {},                                   // enable condition (unused)
            [_item]                               // parameters: pass the classname
        ] call ace_interact_menu_fnc_createAction;

        // c) Add it to the player’s class and capture its fullPath
        private _fullPath = [
            typeOf _player,
            1,                    // self‑action
            _branchParent,
            _action
        ] call ace_interact_menu_fnc_addActionToClass;

        _newEntries pushBack _fullPath;
    };
} forEach _masterList;

// 5. Store the fullPaths for precise removal next time
_player setVariable ["LB_currentDrinkEntries", _newEntries, true];
