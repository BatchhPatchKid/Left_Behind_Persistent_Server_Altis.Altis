/*
   FN_eatFood.sqf
   --------------
   Consume a specific edible item from the player's inventory.
   The caller must supply the classname of the item to eat.

   Usage:
       [player, "rvg_beans"] call FN_eatFood;
*/

params ["_player", "_item"];

// 1. Validate
if (!([_player, _item] call BIS_fnc_hasItem)) exitWith {
    hint "You don't have that food!";
    false
};

// 2. Define your arrays
private _arrayReturn = LB_fnc_arrayReturn;
private _tier1  = ["foodTier1"]  call _arrayReturn;
private _tier2  = ["foodTier2"]  call _arrayReturn;
private _tier3  = ["foodTier3"]  call _arrayReturn;
private _tier4  = ["foodTier4"]  call _arrayReturn;
private _tier5  = ["foodTier5"]  call _arrayReturn;
private _tier6  = ["foodTier6"]  call _arrayReturn;
private _tier7  = ["foodTier7"]  call _arrayReturn;
private _tier8  = ["foodTier8"]  call _arrayReturn;
private _tier9  = ["foodTier9"]  call _arrayReturn;
private _tier10 = ["foodTier10"] call _arrayReturn;
private _tier11 = ["foodTier11"] call _arrayReturn;

private _allUncooked = _tier5 + _tier6 + _tier7 + _tier9 + _tier11;

// 3. Determine nutrition value and post-eat behaviour
private _value = 0;
private _radAmount = 0;
private _sanityInc = true;

switch (true) do {
    case (_item in _tier1):  { _value = 25; };
    case (_item in _tier2):  { _value = 35; };
    case (_item in _tier3):  { _value = 45; };
    case (_item in _tier4):  { _value = 45; };
    case (_item in _tier5):  { _value = 35; };
    case (_item in _tier6):  { _value = 45; };
    case (_item in _tier7):  { _value = 25; };
    case (_item in _tier8):  { _value = 20; };
    case (_item in _tier9):  { _value = 20; };
    case (_item in _tier10): { _value = 60; };
    case (_item in _tier11): { _value = 60; };
    default { _value = 0; };
};

if (_item in _tier8 || _item in _tier5 || _item in _tier6 || _item in _tier7 || _item in _tier9 || _item in _tier11) then {
    if (_item in _allUncooked) then { _value = floor(_value * 0.5); };
};

switch (true) do {
    case (_item in ["rvg_Rabbit_Meat", "rvg_Rabbit_Meat_Cooked"]): {
        _radAmount = 35;
        [_player, 45] call FN_addDefecationPoints;
        [_player, 0.55] call FN_theRuns;
        hintSilent format ["Consumed zombie meat for %1 nutrition (%2 rads)", _value, _radAmount];
    };
    case (_item in ["rvg_Chicken_Meat", "rvg_Chicken_Meat_Cooked"]): {
        _radAmount = 5;
        hintSilent format ["Consumed human meat for %1 nutrition (%2 rads)", _value, _radAmount];
        [-20, _player] call FN_changeSanity;
        [_player, 35] call FN_addDefecationPoints;
        [_player, 0.75] call FN_theRuns;
        _sanityInc = false;
    };
    case (_item in ["rvg_Boar_Meat", "rvg_Boar_Meat_Cooked"]): {
        _radAmount = 5;
        [_player, 20] call FN_addDefecationPoints;
        [_player, 0.80] call FN_theRuns;
        hintSilent format ["Consumed subpar meat for %1 nutrition (%2 rads)", _value, _radAmount];
    };
    case (_item in ["rvg_Sheep_Meat", "rvg_Sheep_Meat_Cooked"]): {
        _radAmount = 0;
        [_player, 30] call FN_addDefecationPoints;
        hintSilent format ["Consumed animal meat for %1 nutrition (%2 rads)", _value, _radAmount];
    };
    case (_item in ["rvg_Buffalo_Meat", "rvg_Buffalo_Meat_Cooked"]): {
        _radAmount = 100;
        [_player, 70] call FN_addDefecationPoints;
        hintSilent format ["Consumed mutant meat for %1 nutrition (%2 rads)", _value, _radAmount];
    };
    default {
        [_player, 25] call FN_addDefecationPoints;
        hintSilent format ["Consumed food for %1 nutrition", _value];
    };
};

// 4. Remove the item
_player removeItem _item;

// 5. Adjust nutrition
private _current = _player getVariable ["nutritionLevel", 100];
private _new = _current + _value;
if (_new > 100) then { _new = 100; };
_player setVariable ["nutritionLevel", _new];

// 6. Apply rads
if (_radAmount > 0 && (itemsWithMagazines player)) then {
    [_radAmount] call FN_addRad;
    [_player, ["rvg_geiger_1", 100, 1]] remoteExec ["say3D"];
};

if (_sanityInc) then {
    [0.5, _player] call FN_changeSanity;
};

// 7. Play eat animation
switch (stance _player) do {
    case "STAND": { _player playMove "ace_field_rations_drinkFromSource"; };
    case "CROUCH": { _player playMove "ace_field_rations_drinkCrouchCan"; };
    case "PRONE": { _player playMove "ace_field_rations_drinkProneCan"; };
};

// 8. Clear hint after a bit
0 spawn {
    sleep 3;
    hintSilent "";
};

// 9. Update eat actions
[_player] call FN_updateEatActions;

// 10. Return success
true