params ["_container", "_caller", "_actionId", "_arguments"];
_itemsPlayer = itemsWithMagazines _container;

_bankNotesCount = { _x == "rvg_money" } count magazines _caller;

if (_bankNotesCount == 0) exitWith {
	hintSilent "Sorry, but yo ass broke";
	sleep 3;
	hintSilent "";
};

if (_bankNotesCount < _arguments select 1 AND _bankNotesCount != 0) then {
	hintSilent "Sorry, not enough money to purchase item";
	sleep 3;
	hintSilent "";
} else {
	_index = 0;
	while {_index < _arguments select 1} do { // removing the money from the players inventory
		_caller removeItem "rvg_money";
		_index = _index + 1;
	};
	
	backpackSelection = ["backpack"] call (missionNamespace getVariable "FN_arrayReturn");
	backpackSelectionRare = ["backpackExpensive"] call (missionNamespace getVariable "FN_arrayReturn");
	
	if ((_arguments select 0) in backpackSelection or (_arguments select 0) in backpackSelectionRare) then {
		[_container, _caller, _actionId, _arguments, 2, 0] call (missionNamespace getVariable "FN_ammoBoxCheck");
	} else {
		if (_caller canAddItemToBackpack (_arguments select 0)) then {
			_caller addItemToBackpack (_arguments select 0);
			_index = 0;
			hintSilent format ["The item has been put in your bag %1. Thank you for doing busines with us.", (name _caller)];
			sleep 3;
			hintSilent "";
		} else {
			[_container, _caller, _actionId, _arguments, 0, 0] call (missionNamespace getVariable "FN_ammoBoxCheck");
		};
	};
};