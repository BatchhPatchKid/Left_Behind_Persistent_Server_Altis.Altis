params ["_container", "_caller", "_actionId", "_arguments", "_itemBool", "_amountOfMoneyToBePutIntoTheAmmoBox"];
_temporaryStorageArray = nearestObjects [_container, ["Box_NATO_Ammo_F"], 10];
_temporaryStorage = "";
if (count _temporaryStorageArray == 0) then {
	_temporaryStorage = "Box_NATO_Ammo_F" createVehicle getPos _container;
	_temporaryStorage allowDamage false;
	clearItemCargoGlobal _temporaryStorage;
	clearMagazineCargoGlobal _temporaryStorage;
	[_itemBool, _temporaryStorage, _arguments, _amountOfMoneyToBePutIntoTheAmmoBox, _caller] call (missionNamespace getVariable "FN_addItemToAmmoBox");
	
} else {
	_temporaryStorage = _temporaryStorageArray select 0;
	[_itemBool, _temporaryStorage, _arguments, _amountOfMoneyToBePutIntoTheAmmoBox, _caller] call (missionNamespace getVariable "FN_addItemToAmmoBox");
};