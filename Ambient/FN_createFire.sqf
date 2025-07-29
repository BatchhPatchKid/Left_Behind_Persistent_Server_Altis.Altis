/*
    FN_createFire.sqf
    -----------------
    Checks if player has 'rvg_matches' plus one of these perishable items
    in priority order: rvg_notepad, rvg_docFolder, rvg_money.
    Removes exactly one perishable, spawns a "FirePlace_burning_F" several 
    meters in front of (and at the same altitude as) the player.
*/

params ["_player"];

// 1) Non-perishable item
private _matches = "rvg_matches";

// 2) Check for matches
if (!([_player, _matches] call BIS_fnc_hasItem)) exitWith {
    hint "You lack the matches needed to start a fire";
};

// 3) Priority list of perishable items (just one gets used)
private _perishableUsed = "";

// Check each in turn, exit once we find one
if ([_player, "rvg_notepad"] call BIS_fnc_hasItem) then {
    _perishableUsed = "rvg_notepad";
} else {
    if ([_player, "rvg_docFolder"] call BIS_fnc_hasItem) then {
        _perishableUsed = "rvg_docFolder";
    } else {
        if ([_player, "rvg_money"] call BIS_fnc_hasItem) then {
            _perishableUsed = "rvg_money";
        };
    };
};

// If none found, exit
if (_perishableUsed isEqualTo "") exitWith {
    hint "You have no suitable perishable item to burn";
};

// 4) Remove exactly one instance of the chosen perishable
_player removeItem _perishableUsed;

// 5) Determine a position in front of (and at the same altitude as) the player.
private _spawnPos = _player modelToWorld [0,1.5,0];

// 6) Create the fire object
private _fireObj = createVehicle ["FirePlace_burning_F", _spawnPos, [], 0, "CAN_COLLIDE"];
_fireObj setDir (getDir _player);

hint format ["You created a fire by burning %1", _perishableUsed];
_player playMove "AinvPknlMstpSnonWnonDnon_medic0";
// Clear hint after a few seconds
_handle = 0 spawn {
	sleep 3;
	hintSilent "";
};