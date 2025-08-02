params ["_pos"];

private _crate = createVehicle ["Box_NATO_Support_F", _pos, [], 0, "CAN_COLLIDE"];
clearBackpackCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearItemCargoGlobal _crate;

[_crate, 1] call (missionNamespace getVariable "FN_fillLootCrate");

private _piles = missionNamespace getVariable ["garbagePilePositions", []];
_piles = _piles select { _x distance _pos > 0.1 };
missionNamespace setVariable ["garbagePilePositions", _piles];