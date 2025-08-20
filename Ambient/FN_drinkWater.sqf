/*
   FN_drinkWater.sqf
   -----------------
   Consume a specific drinkable item from the player’s inventory.
   The caller must supply the classname of the item to drink.

   Usage:
       [player, "rvg_canteen"] call FN_drinkWater;
*/

params ["_player", "_item"];

// 1. Validate
if (!([_player, _item] call BIS_fnc_hasItem)) exitWith {
    hint "You don’t have that drink!";
    false
};

// 2. Define your arrays
private _arrayReturn = missionNamespace getVariable "FN_arrayReturn";

private _sodas = ["drinkSodas"] call _arrayReturn;
private _waterBottles = ["drinkWaterBottles"] call _arrayReturn;
private _canteens = ["drinkCanteens"] call _arrayReturn;
private _dirty = ["drinkDirty"] call _arrayReturn;
private _blood = ["drinkBlood"] call _arrayReturn;

// 3. Determine hydration value and post‑drink behavior
private _value = 0;
private _radAmount = 0;

switch (true) do {
    case (_item in _sodas): {
        _value = 20;
        _radAmount = 5;
    };

    case (_item in _waterBottles): {
        _value = 35;
    };

    case (_item in _canteens): {
        _value = 60;
    };

    case (_item in _dirty): {
        _value = 25;
        _radAmount = 15;
    };

    case (_item in _blood): {
        switch (_item) do {
            case "ACE_bloodIV_250": { _value = 8; };
            case "ACE_bloodIV_500": { _value = 16; };
            case "ACE_bloodIV":     { _value = 32; };
            default { _value = 0; };
        };
        _radAmount = 0;
    };

    default {
        _value = 0;
    };
};

// 4. Remove the item
_player removeItem _item;

// 5. Add empty canteen if applicable
if (_item in _canteens || _item == "rvg_canteen") then {
    _player addItem "rvg_canteenEmpty";
};

if (_item in _waterBottles || _item == "rvg_plasticBottle") then {
    _player addItem "rvg_plasticBottleEmpty";
};

// 6. Adjust hydration
private _current = _player getVariable ["hydrationLevel", 100];
private _new = _current + _value;
if (_new > 100) then { _new = 100; };
_player setVariable ["hydrationLevel", _new, true];

// 7. Apply radiation
_arr = (itemsWithMagazines _player) select { _x == "rvg_geiger" };
private _currentRad = _player getVariable ["Rad", 0];
_player setVariable ["Rad", _currentRad + _radAmount, true];
if ((_radAmount > 0) and ((count _arr) > 0)) then {
	[_player, ["rvg_geiger_1", 100, 1]] remoteExec ["say3D"];
};

// 8. Show feedback
hint format ["You consumed a %1 for %2 hydration.", _item, _value];

// 9. Play drink animation
switch (stance _player) do {
    case "STAND": { _player playMove "ace_field_rations_drinkStand"; };
    case "CROUCH": { _player playMove "ace_field_rations_drinkCrouch"; };
    case "PRONE": { _player playMove "ace_field_rations_drinkProne"; };
};

// 10. Clear hints after a bit
0 spawn {
    sleep 3;
    hintSilent "";
};

//11. Update drink actions
[_player] call FN_updateDrinkActions;

// 12. Return success
true