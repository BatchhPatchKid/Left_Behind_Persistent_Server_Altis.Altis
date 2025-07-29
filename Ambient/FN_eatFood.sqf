/*
    FN_eatFood.sqf
    --------------
    This function automatically selects and consumes a food source from the player's inventory.
    It uses a new food tier system with the following order:
    Usage:
       [player] call FN_eatFood;
*/

params ["_player"];

// ------------------------------------------------------------
// 1. Define arrays for each tier (one line each)
// ------------------------------------------------------------
private _foodTier1  = ["rvg_milk", "rvg_rice"];
private _foodTier2  = ["rvg_beans", "rvg_bacon"];
private _foodTier3  = ["ACE_Humanitarian_Ration", "ACE_MRE_BeefStew", "ACE_MRE_ChickenTikkaMasala", "ACE_MRE_ChickenHerbDumplings", "ACE_MRE_CreamChickenSoup", "ACE_MRE_CreamTomatoSoup", "ACE_MRE_MeatballsPasta", "ACE_MRE_SteakVegetables", "ACE_MRE_LambCurry", "rvg_Boar_Meat_Cooked"];
private _foodTier4  = ["rvg_Sheep_Meat_Cooked"];
private _foodTier5  = ["rvg_Boar_Meat", "rvg_Chicken_Meat_Cooked"];
private _foodTier6  = ["rvg_Sheep_Meat"];
private _foodTier7  = ["rvg_Chicken_Meat"];
private _foodTier8  = ["rvg_Rabbit_Meat_Cooked"];
private _foodTier9  = ["rvg_Rabbit_Meat"];
private _foodTier10 = ["rvg_Buffalo_Meat_Cooked"];
private _foodTier11 = ["rvg_Buffalo_Meat"];

// ------------------------------------------------------------
// 2. Assign default nutrition values for each tier
// ------------------------------------------------------------
private _val1  = 15;
private _val2  = 25;
private _val3  = 35;
private _val4  = 35;
private _val5  = 25;
private _val6  = 35;
private _val7  = 15;
private _val8  = 10;
private _val9  = 10;
private _val10 = 50;
private _val11 = 50;

// Combine all raw meat arrays (tiers that are uncooked) for reduction check:
// These tiers are: 5 (Boar Meat), 6 (Sheep Meat), 7 (Chicken Meat), 9 (Rabbit Meat), and 11 (Buffalo Meat)
private _allUncooked = _foodTier5 + _foodTier6 + _foodTier7 + _foodTier9 + _foodTier11;

// ------------------------------------------------------------
// 3. Variables to track selection
// ------------------------------------------------------------
private _selectedValue = 0;
private _selectedItem  = "";
private _selectedName  = ""; // cosmetic label

// ------------------------------------------------------------
// 4. Helper function to check an array for an item
// ------------------------------------------------------------
private _checkArray = {
    params ["_arr", "_val", "_label"];
    private _foundItem = "";
    {
        if ([_player, _x] call BIS_fnc_hasItem) exitWith { _foundItem = _x; };
    } forEach _arr;
    if (_foundItem != "") then {
        _selectedValue = _val;
        _selectedItem  = _foundItem;
        _selectedName  = _label;
    };
};

// ------------------------------------------------------------
// 5. Search tiers in priority order
// ------------------------------------------------------------
// Tier 1: Food
[_foodTier1, _val1, "Food"] call _checkArray;
// Tier 2: Food
if (_selectedValue == 0) then { [_foodTier2, _val2, "Food"] call _checkArray; };
// Tier 3: Food
if (_selectedValue == 0) then { [_foodTier3, _val3, "Food"] call _checkArray; };
// Tier 4: Food
if (_selectedValue == 0) then { [_foodTier4, _val4, "Food"] call _checkArray; };
// Tier 5: Uncooked Meat
if (_selectedValue == 0) then { [_foodTier5, _val5, "Uncooked Meat"] call _checkArray; };
// Tier 6: Uncooked Meat
if (_selectedValue == 0) then { [_foodTier6, _val6, "Uncooked Meat"] call _checkArray; };
// Tier 7: Uncooked Meat
if (_selectedValue == 0) then { [_foodTier7, _val7, "Uncooked Meat"] call _checkArray; };
// Tier 8: Food
if (_selectedValue == 0) then { [_foodTier8, _val8, "Food"] call _checkArray; };
// Tier 9: Uncooked Meat
if (_selectedValue == 0) then { [_foodTier9, _val9, "Uncooked Meat"] call _checkArray; };
// Tier 10: Food
if (_selectedValue == 0) then { [_foodTier10, _val10, "Food"] call _checkArray; };
// Tier 11: Uncooked Meat
if (_selectedValue == 0) then { [_foodTier11, _val11, "Uncooked Meat"] call _checkArray; };

// ------------------------------------------------------------
// 6. If nothing found, exit; otherwise consume item
// ------------------------------------------------------------
if (_selectedValue == 0) then {
    hintSilent "No food source available";
} else {
    // Remove one instance from inventory
    _player removeItem _selectedItem;

    // Start with the default value from the tier
    private _finalNutrition = _selectedValue;
    private _rads = 0;

    // --------------------------------------------------------
    // Override for special meats regardless of tier:
    // --------------------------------------------------------
	private _sanityInc = true;
    switch (true) do {
        case (_selectedItem in ["rvg_Rabbit_Meat", "rvg_Rabbit_Meat_Cooked"]): {
            _finalNutrition = 10;
			if (_selectedItem in _allUncooked) then {
				_finalNutrition = floor(_finalNutrition * 0.5);
			};
            _rads = 35;
			[_player, 45] call FN_addDefecationPoints;
			[_player, .55] call FN_theRuns;
			hintSilent format ["Consumed zombie meat for %1 nutrition (%2 rads)",_finalNutrition,_rads];
        };
        case (_selectedItem in ["rvg_Chicken_Meat", "rvg_Chicken_Meat_Cooked"]): {
            _finalNutrition = 15;
			if (_selectedItem in _allUncooked) then {
				_finalNutrition = floor(_finalNutrition * 0.5);
			};
            _rads = 5;
			hintSilent format ["Consumed human meat for %1 nutrition (%2 rads)",_finalNutrition,_rads];
			[-20, _player] call FN_changeSanity;
			[_player, 35] call FN_addDefecationPoints;
			[_player, .75] call FN_theRuns;
			_sanityInc = false;
        };
        case (_selectedItem in ["rvg_Boar_Meat", "rvg_Boar_Meat_Cooked"]): {
            _finalNutrition = 25;
			if (_selectedItem in _allUncooked) then {
				_finalNutrition = floor(_finalNutrition * 0.5);
			};
            _rads = 5;
			[_player, 20] call FN_addDefecationPoints;
			[_player, .80] call FN_theRuns;
			hintSilent format ["Consumed subpar meat for %1 nutrition (%2 rads)",_finalNutrition,_rads];
        };
        case (_selectedItem in ["rvg_Sheep_Meat", "rvg_Sheep_Meat_Cooked"]): {
            _finalNutrition = 35;
			if (_selectedItem in _allUncooked) then {
				_finalNutrition = floor(_finalNutrition * 0.5);
			};
            _rads = 0;
			[_player, 30] call FN_addDefecationPoints;
			hintSilent format ["Consumed animal meat for %1 nutrition (%2 rads)",_finalNutrition,_rads];
        };
        case (_selectedItem in ["rvg_Buffalo_Meat", "rvg_Buffalo_Meat_Cooked"]): {
            _finalNutrition = 50;
			if (_selectedItem in _allUncooked) then {
				_finalNutrition = floor(_finalNutrition * 0.5);
			};
            _rads = 100;
			[_player, 70] call FN_addDefecationPoints;
			hintSilent format ["Consumed mutant meat for %1 nutrition (%2 rads)",_finalNutrition,_rads];
        };
		default {
			[_player, 25] call FN_addDefecationPoints;
			hintSilent format ["Consumed regular food for %1 nutrition",_finalNutrition];
		};
    };

    // --------------------------------------------------------
    // Update player's nutrition (capped at 100)
    // --------------------------------------------------------
    private _currentNutrition = _player getVariable ["nutritionLevel", 100];
    private _newNutrition = _currentNutrition + _finalNutrition;
    if (_newNutrition > 100) then { _newNutrition = 100; };
    _player setVariable ["nutritionLevel", _newNutrition];
    
    [_rads] call FN_addRad;
	
	if (_sanityInc) then {
		[.5, _player] call FN_changeSanity;
	};

    // --------------------------------------------------------
    // Play eating animation based on player's stance
    // --------------------------------------------------------
    if ((stance _player) == "STAND") then {
        _player playMove "ace_field_rations_drinkFromSource";
    } else {
        if ((stance _player) == "CROUCH") then {
            _player playMove "ace_field_rations_drinkCrouchCan";
        } else {
            if ((stance _player) == "PRONE") then {
                _player playMove "ace_field_rations_drinkProneCan";
            };
        };
    };

    // --------------------------------------------------------
    // Clear hint after 3 seconds
    // --------------------------------------------------------
    0 spawn {
        sleep 3;
        hintSilent "";
    };
};