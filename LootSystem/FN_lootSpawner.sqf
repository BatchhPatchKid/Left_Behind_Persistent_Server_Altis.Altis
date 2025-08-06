params ["_pos","_levelGear"];

//spawning the loot box
_box = createVehicle ["Box_FIA_Wps_F", [_pos, 5, 15, 3, 0, 20, 0,[],[]] call BIS_fnc_findSafePos];
clearBackpackCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;

[_box, _levelGear] call (missionNamespace getVariable "FN_fillLootCrate");