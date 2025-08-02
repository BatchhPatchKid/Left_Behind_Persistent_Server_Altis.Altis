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
private _sodas = ["drinkSodas"] call (missionNamespace getVariable "FN_arrayReturn");
private _waterBottles = ["drinkWaterBottles"] call (missionNamespace getVariable "FN_arrayReturn");
private _canteens = ["drinkCanteens"] call (missionNamespace getVariable "FN_arrayReturn");
private _dirty = ["drinkDirty"] call (missionNamespace getVariable "FN_arrayReturn");
private _blood = ["drinkBlood"] call (missionNamespace getVariable "FN_arrayReturn");

// 3. Determine hydration value and post‑drink behavior
private _value = 0;
private _radAmount = 0;

if (_item in _sodas) then {
    _value = 15;
    _radAmount = 5;
} else {
    if (_item in _waterBottles) then {
        _value = 25;
    } else {
        if (_item in _canteens) then {
            _value = 40;
        } else {
            if (_item in _dirty) then {
                _value = 25;
                _radAmount = 15;
            } else {
                if (_item in _blood) then {
                    switch (_switchItem) do {
						case "ACE_bloodIV_250": {
							// 250 ml blood
							_value = 8;
							_selectedName  = "250 ml of human blood";
						};
						case "ACE_bloodIV_500": {
							// 500 ml blood
							_value = 16;
							_selectedName  = "500 ml of human blood";
						};
						case "ACE_bloodIV": {
							// 1 L blood
							_value = 32;
							_selectedName  = "1 liter of human blood";
						};
						default {
							// fallback if somehow another item got through
							_value = 0;
							_selectedName  = "";
						};
					};
                    _radAmount = 0;
                } else {
                    // Fallback
                    _value = 0;
                };
            };
        };
    };
};

// 4. Remove the item
_player removeItem _item;

// 5. Add empty canteen if applicable
if (_item in _canteens) then {
    _player addItem "rvg_canteenEmpty";
};

// 6. Adjust hydration
private _current = _player getVariable ["hydrationLevel", 100];
private _new = _current + _value;
if (_new > 100) then { _new = 100; };
_player setVariable ["hydrationLevel", _new, true];

// 7. Apply radiation
if (_radAmount > 0) then {
    [_radAmount] call FN_addRad;
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