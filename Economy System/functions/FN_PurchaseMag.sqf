params ["_container", "_caller", "_actionId", "_arguments"];

_bankNotesCount = { _x == "rvg_money" } count magazines _caller;

if (_bankNotesCount == 0) exitWith {
	hintSilent "Sorry, but yo ass broke";
	sleep 3;
	hintSilent "";
};

if (_bankNotesCount < (_arguments select 1) AND _bankNotesCount != 0) then {
	hintSilent "Sorry, not enough money to purchase item";
	sleep 3;
	hintSilent "";
} else {
	_primaryWeapon = primaryWeapon _caller;
	_secondaryWeapon = secondaryWeapon _caller;
	_handgunWeapon = handgunWeapon _caller;
	
	_reminder = true;
	
	if (!("" == _primaryWeapon) AND (_arguments select 0) == 0) then {
		_reminder = false;
		// Get the available magazines for the primary weapon
		_magazines = compatibleMagazines _primaryWeapon;
		if (count _magazines != 0) then {
			if (_container canAddItemToBackpack (_magazines select 0)) then {
				_index = 0;
				while {_index < 10} do {
					_caller removeItem "rvg_money";
					_index = _index + 1;
				};
				if (_caller canAddItemToBackpack (_magazines select 0)) then {
					_caller addItemToBackpack (_magazines select 0); 
					hintSilent format ["Your primary magazine was successfully purchased. The magazine is in your bag %1.",(name _caller)];
				} else {
					[_container, _caller, _actionId, (_magazines select 0), 3, 0] call LB_fnc_ammoBoxCheck;
				};
			};
		} else {
			hintSilent "Sorry, but we weren't able to find any magazines in stock for that weapon.";
		};
	};
	if (!("" == _secondaryWeapon) AND (_arguments select 0) == 1) then {
		_reminder = false;
		_magazines = compatibleMagazines _secondaryWeapon;
		if (count _magazines != 0) then {
			if (_container canAddItemToBackpack (_magazines select 0)) then {
				_index = 0;
				while {_index < 10} do {
					_caller removeItem "rvg_money";
					_index = _index + 1;
				};
				if (_caller canAddItemToBackpack (_magazines select 0)) then {
					_caller addItemToBackpack (_magazines select 0); 
					hintSilent format ["Your launchers rocket was successfully purchased. The magazine is in your bag %1.",(name _caller)];
				} else {
					[_container, _caller, _actionId, (_magazines select 0), 3, 0] call LB_fnc_ammoBoxCheck;
				};
			};
		} else {
			hintSilent "Sorry, but we weren't able to find any magazines in stock for that weapon.";
		};
	};
	if (!("" == _handgunWeapon) AND (_arguments select 0) == 2) then {
		_reminder = false;
		_magazines = compatibleMagazines _handgunWeapon;
		if (count _magazines != 0) then {
			if (_container canAddItemToBackpack (_magazines select 0)) then {
				_index = 0;
				while {_index < 10} do {
					_caller removeItem "rvg_money";
					_index = _index + 1;
				};
				if (_caller canAddItemToBackpack (_magazines select 0)) then {
					_caller addItemToBackpack (_magazines select 0); 
					hintSilent format ["Your handguns magazine was successfully purchased. The magazine is in your bag %1.",(name _caller)];
				} else {
					[_container, _caller, _actionId, (_magazines select 0), 3, 0] call LB_fnc_ammoBoxCheck;
				};
			};
		} else {
			hintSilent "Sorry, but we weren't able to find any magazines in stock for that weapon.";
		};
	};
	if (_reminder) then {
		hintSilent "Sorry, but we weren't able to find a magazine to supply you with. Ensure that you have the weapon equipped if you want to buy a magazine for it.";
	};
};