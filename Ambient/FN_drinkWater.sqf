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
*/

params ["_player", ["_item", ""]];

private _sodas = ["drinkSodas"] call (missionNamespace getVariable "FN_arrayReturn");
private _waterBottles = ["drinkWaterBottles"] call (missionNamespace getVariable "FN_arrayReturn");
private _canteens = ["drinkCanteens"] call (missionNamespace getVariable "FN_arrayReturn");
private _dirty = ["drinkDirty"] call (missionNamespace getVariable "FN_arrayReturn");
private _blood = ["drinkBlood"] call (missionNamespace getVariable "FN_arrayReturn");

private _selectedValue = 0;
private _selectedItem = "";
private _selectedName = "";

// If a specific item was supplied, select it directly
if (_item != "") then {
    _selectedItem = _item;
    switch (true) do {
        case (_item in _sodas): { _selectedValue = 15; _selectedName = "Soda"; };
        case (_item in _waterBottles): { _selectedValue = 25; _selectedName = "Water Bottle"; };
        case (_item in _canteens): { _selectedValue = 40; _selectedName = "Canteen"; };
        case (_item == "rvg_plasticBottle"): { _selectedValue = 25; _selectedName = "Water Bottle"; };
        case (_item == "rvg_canteen"): { _selectedValue = 40; _selectedName = "Canteen"; };
        case (_item == "ACE_bloodIV_250"): { _selectedValue = 8; _selectedName = "250ml of human blood"; };
        case (_item == "ACE_bloodIV_500"): { _selectedValue = 16; _selectedName = "500ml of human blood"; };
        case (_item == "ACE_bloodIV"): { _selectedValue = 32; _selectedName = "1 liter of human blood"; };
    };
};

// If no item was directly supplied, search inventory in priority order
if (_selectedValue == 0) then {
    {
        if (([_player, _x] call BIS_fnc_hasItem)) exitWith {
            _selectedValue = 15;
            _selectedItem = _x;
            _selectedName = "Soda";
        };
    } forEach _sodas;
};

if (_selectedValue == 0) then {
    {
        if (([_player, _x] call BIS_fnc_hasItem)) exitWith {
            _selectedValue = 25;
            _selectedItem = _x;
            _selectedName = "Water Bottle";
        };
    } forEach _waterBottles;
};

if (_selectedValue == 0) then {
    {
        if (([_player, _x] call BIS_fnc_hasItem)) exitWith {
            _selectedValue = 40;
            _selectedItem = _x;
            _selectedName = "Canteen";
        };
    } forEach _canteens;
};

if (([_player, "rvg_plasticBottle"] call BIS_fnc_hasItem) && _selectedValue == 0) then {
    _selectedValue = 25;
    _selectedItem = "rvg_plasticBottle";
    _selectedName = "Water Bottle";
};

if (([_player, "rvg_canteen"] call BIS_fnc_hasItem) && _selectedValue == 0) then {
    _selectedValue = 40;
    _selectedItem = "rvg_canteen";
    _selectedName = "Canteen";
};

if (([_player, "ACE_bloodIV_250"] call BIS_fnc_hasItem) && _selectedValue == 0) then {
    _selectedValue = 8;
    _selectedItem = "ACE_bloodIV_250";
    _selectedName = "250ml of human blood";
};

if (([_player, "ACE_bloodIV_500"] call BIS_fnc_hasItem) && _selectedValue == 0) then {
    _selectedValue = 16;
    _selectedItem = "ACE_bloodIV_500";
    _selectedName = "500ml of human blood";
};

if (([_player, "ACE_bloodIV"] call BIS_fnc_hasItem) && _selectedValue == 0) then {
    _selectedValue = 32;
    _selectedItem = "ACE_bloodIV";
    _selectedName = "1 liter of human blood";
};

if (_selectedValue == 0) then {
    hint "No hydration source available";
    false
} else {
    _player removeItem _selectedItem;

    if (_selectedValue == 40) then {
        _player addItem "rvg_canteenEmpty";
    };

    private _currentHydration = _player getVariable ["hydrationLevel", 100];
    private _newHydration = _currentHydration + _selectedValue;
    if (_newHydration > 100) then { _newHydration = 100; };
    _player setVariable ["hydrationLevel", _newHydration];

    private _itemsPlayer = itemsWithMagazines player;

    if (_selectedItem in _dirty || _selectedItem in _blood) then {
        [15] call FN_addRad;
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

    switch (stance player) do {
        case "STAND": { _player playMove "ace_field_rations_drinkStand"; };
        case "CROUCH": { _player playMove "ace_field_rations_drinkCrouch"; };
        case "PRONE": { _player playMove "ace_field_rations_drinkProne"; };
    };

    _handle = 0 spawn {
        sleep 3;
        hintSilent "";
    };

    true
};