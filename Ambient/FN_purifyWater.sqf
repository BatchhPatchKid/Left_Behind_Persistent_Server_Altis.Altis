/*
   FN_purifyWater.sqf
   -------------------
   This function purifies water if the player has at least one "rvg_purificationTablets"
   and a dirty water container (either "rvg_canteen" or "rvg_plasticBottle").
   
   - If a dirty canteen is found, it is replaced with a clean canteen ("rvg_canteenPurified").
   - If not, and a dirty plastic bottle is found, it is replaced with a clean plastic bottle ("rvg_plasticBottlePurified").
   - In either case, one "rvg_purificationTablets" is removed.
   - If neither container is present, the player is notified.
   
   Usage:
       [player] call FN_purifyWater;
*/

params ["_player"];

if (!([ _player, "rvg_purificationTablets" ] call BIS_fnc_hasItem)) exitWith {
    hintSilent "You do not have any purification tablets.";
};

// Try to purify a canteen first.
if ([ _player, "rvg_canteen" ] call BIS_fnc_hasItem) exitWith {
    _player removeItem "rvg_canteen";
    _player addItem "rvg_canteenPurified";
    _player removeItem "rvg_purificationTablets";
    hintSilent "Your canteen has been purified.";
};

// Otherwise, try to purify a plastic bottle.
if ([ _player, "rvg_plasticBottle" ] call BIS_fnc_hasItem) exitWith {
    _player removeItem "rvg_plasticBottle";
    _player addItem "rvg_plasticBottlePurified";
    _player removeItem "rvg_purificationTablets";
    hintSilent "Your plastic bottle has been purified.";
};

hint "No dirty water container found";
_handle = 0 spawn {
	sleep 3;
	hintSilent "";
};