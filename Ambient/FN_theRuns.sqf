params ["_player","_theRunsChance"];

if (_theRunsChance < (random 1)) then {
	private _currentHydration = _player getVariable ["hydrationLevel", 100];
	private _newHydration = _currentHydration - ((random 20)+5);
	_player setVariable ["hydrationLevel", _newHydration];
	
	_handle = [_player] spawn {
		params ["_player"];
		sleep 10;
		_displayText1 = format ["<t color='#873e23' size='0.8'>After eating some bad food, your bowels moan loudly<br/>You will have to relieve yourself in 10 seconds</t>"];
		[ _displayText1, 0.75, 1, 2, 0.3, 0, 789 ] spawn BIS_fnc_dynamicText;
		sleep 10;
		_player setVariable ["defecationStatus", 100];
		[_player] call FN_defecate;
	};
};