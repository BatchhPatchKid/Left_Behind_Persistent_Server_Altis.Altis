params ["_container", "_caller", "_actionId", "_arguments"];

headgearArraySelectionRare = ["headgearExpensive"] call (missionNamespace getVariable "FN_arrayReturn");
gasArraySelection = ["gas"] call (missionNamespace getVariable "FN_arrayReturn");
coolClothing = ["clothingExpensive"] call (missionNamespace getVariable "FN_arrayReturn");
monoNVG = ["monoNVG"] call (missionNamespace getVariable "FN_arrayReturn");
binoNVG = ["binoNVG"] call (missionNamespace getVariable "FN_arrayReturn");
quadNVG = ["quadNVG"] call (missionNamespace getVariable "FN_arrayReturn");
explosive = ["explosive"] call (missionNamespace getVariable "FN_arrayReturn");
thrownExplosives = ["thrownExplosives"] call (missionNamespace getVariable "FN_arrayReturn");
melee = ["melee"] call (missionNamespace getVariable "FN_arrayReturn");
pistol = ["pistol"] call (missionNamespace getVariable "FN_arrayReturn");
autoPistol = ["autoPistol"] call (missionNamespace getVariable "FN_arrayReturn");
launcherArraySelection = ["launcher"] call (missionNamespace getVariable "FN_arrayReturn");
smg = ["smg"] call (missionNamespace getVariable "FN_arrayReturn");
shotgun = ["shotgun"] call (missionNamespace getVariable "FN_arrayReturn");
assualtRifle = ["assualtRifle"] call (missionNamespace getVariable "FN_arrayReturn");
LMG = ["LMG"] call (missionNamespace getVariable "FN_arrayReturn");
DMR = ["DMR"] call (missionNamespace getVariable "FN_arrayReturn");
sniperRifle = ["sniperRifle"] call (missionNamespace getVariable "FN_arrayReturn");
antiMaterial = ["antiMaterial"] call (missionNamespace getVariable "FN_arrayReturn");
opticsArraySelection = ["optics"] call (missionNamespace getVariable "FN_arrayReturn");
opticsArraySelectionRare = ["opticsExpensive"] call (missionNamespace getVariable "FN_arrayReturn");
muzzleArraySelection = ["muzzle"] call (missionNamespace getVariable "FN_arrayReturn");
muzzleArraySelectionRare = ["muzzleExpensive"] call (missionNamespace getVariable "FN_arrayReturn");
railArraySelection = ["rail"] call (missionNamespace getVariable "FN_arrayReturn");
railArraySelectionRare = ["railExpensive"] call (missionNamespace getVariable "FN_arrayReturn");
backpackSelection = ["backpack"] call (missionNamespace getVariable "FN_arrayReturn");
backpackSelectionRare = ["backpackExpensive"] call (missionNamespace getVariable "FN_arrayReturn");
vestSelectionRare = ["vestExpensive"] call (missionNamespace getVariable "FN_arrayReturn");
mutantMeat = ["rvg_Buffalo_Meat_Cooked","rvg_Buffalo_Meat"];

FN_RemoveItem = {
	params ["_container", "_caller", "_actionId", "_arrayToCheck", "_amountToSell", "_item"];
	if (_item in _arrayToCheck) then {
		_container removeItemFromBackpack _item;
	} else {
		_amountToSell = 0;
	};
	_amountToSell;
};

_moneyPayedBack = 0;
{
	if (_x != "rvg_money") then {
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, mutantMeat, 1000, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, headgearArraySelectionRare, 10, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, gasArraySelection, 3, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, coolClothing, 10, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, monoNVG, 50, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, binoNVG, 75, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, quadNVG, 200, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, explosive, 20, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, thrownExplosives, 3, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, melee, 3, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, pistol, 3, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, autoPistol, 15, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, launcherArraySelection, 50, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, smg, 15, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, shotgun, 15, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, assualtRifle, 15, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, LMG, 30, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, DMR, 35, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, sniperRifle, 40, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, antiMaterial, 80, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, opticsArraySelection, 10, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, opticsArraySelectionRare, 30, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, railArraySelection, 3, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, railArraySelectionRare, 20, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, muzzleArraySelection, 10, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, muzzleArraySelectionRare, 50, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, backpackSelection, 10, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, backpackSelectionRare, 30, _x] call FN_RemoveItem);
		_moneyPayedBack = _moneyPayedBack + ([_container, _caller, _actionId, vestSelectionRare, 30, _x] call FN_RemoveItem);
		if (!(isNil "_x")) then {
			_container removeItemFromBackpack _x;
			_moneyPayedBack = _moneyPayedBack + 1;
		};
	};
} forEach (backpackItems _container);

_hadToCreateTempStorage = false;
_temporaryStorage = "";
for "_i" from 1 to _moneyPayedBack do {
	if (_caller canAddItemToBackpack "rvg_money") then {
		_caller addItemToBackpack "rvg_money"; 
		hintSilent format ["All of the amount owed to you ($%2) has been put in your backpack, %1. Good doing business with you.", (name _caller), _moneyPayedBack];
	} else {
		[_container, _caller, _actionId, "rvg_money", 1, (_moneyPayedBack-_i)+1] execVM "Economy System\functions\FN_ammoBoxCheck.sqf";
		break;
	};
};