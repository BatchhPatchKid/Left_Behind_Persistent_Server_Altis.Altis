/*
    FN_cookOnePiece.sqf
    --------------------
    This script checks if the player has any uncooked meat from _meatPairs;
    if so, it removes ONE uncooked piece and adds the corresponding cooked version,
    displaying a hint about what was converted.
    
    Usage:
        [player] call FN_cookOnePiece;  // or however you're calling it in your mission
*/

params ["_player"];

// Define uncooked → cooked pairs
private _meatPairs = [
    ["rvg_Rabbit_Meat",   "rvg_Rabbit_Meat_Cooked"],
    ["rvg_Boar_Meat",     "rvg_Boar_Meat_Cooked"],
    ["rvg_Chicken_Meat",  "rvg_Chicken_Meat_Cooked"],
    ["rvg_Buffalo_Meat",  "rvg_Buffalo_Meat_Cooked"],
    ["rvg_Sheep_Meat",    "rvg_Sheep_Meat_Cooked"]
];

// Loop through each pair; cook only one piece total
{
    private _uncooked = _x select 0;
    private _cooked   = _x select 1;

    // If the player has at least one piece of this uncooked meat
    if ([_player, _uncooked] call BIS_fnc_hasItem) exitWith {
        // Remove one uncooked and add one cooked
        _player removeItem _uncooked;
        _player addItem    _cooked;

        // Show which item was cooked
        hint format ["You successfully cooked a piece of meat", _uncooked, _cooked];
		_player playMove "AinvPknlMstpSnonWnonDnon_medicUp5";
		0 spawn {
			sleep 3;
			hintSilent "";
		};
    };
} forEach _meatPairs;