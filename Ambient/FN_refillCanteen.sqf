/*
   FN_refillCanteen.sqf
*/
params ["_player"];

// original list of water-source class names
private _waterSources = ["Land_ConcreteWell_02_F","Land_Water_source_F","Land_StallWater_F","Land_WaterTank_04_F","Land_WaterTank_02_F","Land_WaterTank_03_F","Land_WaterTank_01_F","Land_WaterCooler_01_new_F","Land_WaterCooler_01_old_F","Land_WaterTank_F","Land_WaterBarrel_F"];

// build a filter for only those classes in the map’s Structures category
private _filter = format ["configName _x in %1", _waterSources];
private _terrainClasses = _filter configClasses (configFile >> "CfgWorlds" >> worldName >> "Structures");

// detect water surface or any terrain-placed source within 50 m
private _inWaterSurface  = surfaceIsWater (getPos _player);
private _nearTerrainWater = (count (nearestTerrainObjects [_player, _terrainClasses, 50, true])) > 0;
private _nearWater = _inWaterSurface || _nearTerrainWater;

if (!(_nearWater)) exitWith {
    hint "You are not near a water source";
};

if (([_player, "rvg_canteenEmpty"] call BIS_fnc_hasItem) || ([_player, "ACE_Canteen_Empty"] call BIS_fnc_hasItem)) then {
    _player removeItem "rvg_canteenEmpty";
    _player addItem "rvg_canteen";
    hintSilent "Your canteen has been refilled";
    _player playMove "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic";
} else {
    if (([_player, "rvg_plasticBottleEmpty"] call BIS_fnc_hasItem) || ([_player, "ACE_WaterBottle_Empty"] call BIS_fnc_hasItem)) then {
        _player removeItem "rvg_plasticBottleEmpty";
        _player addItem "rvg_plasticBottle";
        hintSilent "Your water bottle has been refilled";
        _player playMove "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic";
    } else {
        hintSilent "You don't have an empty water container to refill";
    };
};

// clear hints after 3 seconds
_handle = 0 spawn {
    sleep 3;
    hintSilent "";
};