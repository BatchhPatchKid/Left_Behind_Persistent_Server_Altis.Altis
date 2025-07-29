params ["_itemBool", "_temporaryStorage", "_arguments", "_amountOfMoneyToBePutIntoTheAmmoBox", "_caller"];
if (_itemBool == 0) then {
	_temporaryStorage addItemCargoGlobal [(_arguments select 0), 1];
	hintSilent format ["It would seem that your backpack is full %1, so the item is being put into this ammo box near me.", (name _caller)];
};
if (_itemBool == 1) then {
	_temporaryStorage addMagazineCargoGlobal [_arguments, _amountOfMoneyToBePutIntoTheAmmoBox];
	hintSilent format ["It would seem that your backpack is full %1, so the amount due (%2) is being put into this ammo box near me.", (name _caller), _amountOfMoneyToBePutIntoTheAmmoBox];
};
if (_itemBool == 2) then {
	_temporaryStorage addBackpackCargoGlobal [(_arguments select 0), 1];
	hintSilent format ["It would seem that your backpack is full %1, so the backpack is being put into this ammo box near me.", (name _caller)];
};
if (_itemBool == 3) then {
	_temporaryStorage addMagazineCargoGlobal [(_arguments select 0), 1];
	hintSilent format ["It would seem that your backpack is full %1, so the magazine is being put into this ammo box near me.", (name _caller)];
};