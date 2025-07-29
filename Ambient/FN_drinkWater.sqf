/*
   FN_drinkWater.sqf
   -----------------
   This function automatically selects and consumes a hydration source from the player's inventory.
   It checks in the following priority order using BIS_fnc_hasItem:
      1. Sodas (adds 15 hydration)
      2. Water bottles (adds 25 hydration)
      3. Canteens (adds 40 hydration)
   If a source is found, one instance is removed from the inventory and the player's hydration is increased.
   Additionally, if the consumed item is a canteen (hydration value 40), an empty canteen ("rvg_canteenEmpty") is added.
   
   Usage:
       [player] call FN_drinkWater;
       
   Save this file in your mission folder and load it into missionNamespace in init.sqf.
*/

params ["_player"];

// Define arrays for each group of drinkable items.
private _sodas = ["rvg_franta","rvg_spirit","ACE_Can_Franta","ACE_Can_RedGull","ACE_Can_Spirit"];
private _waterBottles = ["rvg_plasticBottlePurified", "ACE_WaterBottle", "ACE_WaterBottle_Half"];
private _canteens = ["rvg_canteenPurified", "ACE_Canteen", "ACE_Canteen_Half"];
private _dirty = ["rvg_canteen","rvg_plasticBottle"];
private _blood = ["ACE_bloodIV_500","ACE_bloodIV_250","ACE_bloodIV"];

private _selectedValue = 0;
private _selectedItem = "";
private _selectedName = "";

// Check sodas first (15 hydration).
{
    if (([_player, _x] call BIS_fnc_hasItem) == true) exitWith { 
		_selectedValue = 15; 
		_selectedItem = _x;
		_selectedName = "Soda";
	};
} forEach _sodas;

// Check water bottles next (25 hydration).
if (_selectedValue == 0) then {
    {
        if (([_player, _x] call BIS_fnc_hasItem) == true) exitWith { 
			_selectedValue = 25; 
			_selectedItem = _x; 
			_selectedName = "Water Bottle"; 
		};
    } forEach _waterBottles;
};

// Check canteens last (40 hydration).
if (_selectedValue == 0) then {
    {
        if (([_player, _x] call BIS_fnc_hasItem) == true) exitWith { 
			_selectedValue = 40; 
			_selectedItem = _x; 
			_selectedName = "Canteen"; 
		};
    } forEach _canteens;
};

// Check dirty sources last (+10 rads).
if (([_player, "rvg_plasticBottle"] call BIS_fnc_hasItem) == true && _selectedValue == 0) then { 
	_selectedValue = 25; 
	_selectedItem = "rvg_plasticBottle";
	_selectedName = "Water Bottle";
};

if (([_player, "rvg_canteen"] call BIS_fnc_hasItem) == true && _selectedValue == 0) then { 
	_selectedValue = 40; 
	_selectedItem = "rvg_canteen";
	_selectedName = "Canteen";
};

if (([_player, "ACE_bloodIV_250"] call BIS_fnc_hasItem) == true && _selectedValue == 0) then { 
	_selectedValue = 8; 
	_selectedItem = "ACE_bloodIV_250";
	_selectedName = "250ml of human blood";
};

if (([_player, "ACE_bloodIV_500"] call BIS_fnc_hasItem) == true && _selectedValue == 0) then { 
	_selectedValue = 16; 
	_selectedItem = "ACE_bloodIV_500";
	_selectedName = "500ml of human blood";
};

if (([_player, "ACE_bloodIV"] call BIS_fnc_hasItem) == true && _selectedValue == 0) then { 
	_selectedValue = 32;
	_selectedItem = "ACE_bloodIV";
	_selectedName = "1 liter of human blood";
};

if (_selectedValue == 0) then {
    hint "No hydration source available";
} else {
    // Remove one instance of the selected item.
    _player removeItem _selectedItem;
    
    // If a canteen was used (hydration value 40), add an empty canteen.
    if (_selectedValue == 40) then {
         _player addItem "rvg_canteenEmpty";
    };
    
    // Increase hydration by the selected value, capped at 100.
    private _currentHydration = _player getVariable ["hydrationLevel", 100];
    private _newHydration = _currentHydration + _selectedValue;
    if (_newHydration > 100) then { _newHydration = 100; };
    _player setVariable ["hydrationLevel", _newHydration];
	private _itemsPlayer = itemsWithMagazines player;

	if (_selectedItem in _dirty or _selectedItem in _blood) then {
		[15] call FN_addRad;
		hintSilent format ["%1", _current];
		hint format ["Consumed an irradiated %1 for %2 hydration", _selectedName, _selectedValue];
		if ("rvg_Geiger" in _itemsPlayer) then {
			playSound3D [getMissionPath "sounds\rvg_geiger_3.ogg", player, false, getPosASL player, 5, 1, 30];
		};
	} else {
		if (_selectedItem in _sodas) then {
			[5] call FN_addRad;
			hint format ["Consumed a slightly irradiated %1 for %2 hydration", _selectedName, _selectedValue];
			if ("rvg_Geiger" in _itemsPlayer) then {
				playSound3D [getMissionPath "sounds\rvg_geiger_3.ogg", player, false, getPosASL player, 5, 1, 30];
			};
		} else {
			hint format ["Consumed a %1 for %2 hydration", _selectedName, _selectedValue];
		};
	};
	
	if ((stance player) == "STAND") then {
		_player playMove "ace_field_rations_drinkStand";
	} else { 
		if ((stance player) == "CROUCH") then {
			_player playMove "ace_field_rations_drinkCrouch";
		} else {
			if ((stance player) == "PRONE") then {
				_player playMove "ace_field_rations_drinkProne";
			};
		};
	};
};
_handle = 0 spawn {
	sleep 3;
	hintSilent "";
};