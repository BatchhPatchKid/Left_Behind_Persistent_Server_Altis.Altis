/*
   FN_refillCanteen.sqf
   ---------------------
   This function refills a canteen if the player has at least one empty canteen ("rvg_canteenEmpty","ACE_Canteen_Empty")
   and is near water. The definition of “near water” is:
     - The player is standing on a water surface (surfaceIsWater returns true), or
     - One of the specified water source objects is within 50 meters.
	 
       
   If these conditions are met, one empty canteen is removed and a full canteen ("rvg_canteen") is added.
   
   Usage:
       [player] call FN_refillCanteen;
       
   Save this file in your mission folder.
*/
params ["_player"];

// Define an array of water source class names.
private _waterSources = ["Land_ConcreteWell_02_F","Land_Water_source_F","Land_StallWater_F","Land_WaterTank_04_F","Land_WaterTank_02_F","Land_WaterTank_03_F","Land_WaterTank_01_F","Land_WaterCooler_01_new_F","Land_WaterCooler_01_old_F","Land_WaterTank_F","Land_WaterBarrel_F"];

// Determine if the player is near water.
// The player is considered near water if they are on a water surface or if there is any water source within 50 meters.
private _nearWater = surfaceIsWater (getPos player) || ((count (nearestObjects [(getPos player), _waterSources, 5])) > 0);

if (!(_nearWater)) exitWith {
    hint "You are not near a water source";
};

if (([_player, "rvg_canteenEmpty"] call BIS_fnc_hasItem) || ([_player, "ACE_Canteen_Empty"] call BIS_fnc_hasItem)) then {
    _player removeItem "rvg_canteenEmpty";
    _player addItem "rvg_canteen";
    hintSilent "Your canteen has been refilled";
	_player playMove "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic";
} else {
    hintSilent "You don't have an empty canteen to refill";
};

_handle = 0 spawn {
	sleep 3;
	hintSilent "";
};