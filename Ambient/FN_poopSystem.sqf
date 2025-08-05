// Initialize defecation status to 0
player setVariable ["defecationStatus", 0];

FN_checkDefecationStatus = {
	params ["_player", "_display"];
    private _status = player getVariable ["defecationStatus", 0];
	// Ensure that any status below 1 is treated as 1 for tier calculation.
	private _adjusted = _status max 1;
	// Calculate a tier from 0 to 4 for values 1–100.
	// For instance, values 1-20 become tier 0, 21–40 become tier 1, etc.
	private _tier = floor(( _adjusted - 1 ) / 20);

	private _text = "";
	switch (_tier) do {
		case 0: { _text = "You feel comfortable. No urgent need to defecate."; };
		case 1: { _text = "You feel a slight urge to defecate."; };
		case 2: { _text = "Your stomach is rumbling – you may need to find a bush soon."; };
		case 3: { _text = "The need is strong – you should defecate very soon"; };
		case 4: { _text = "You desperately need to defecate"; };
		default { _text = "Defecation status is unknown"; };
	};

	if (_display) exitWith {
		[_text] spawn {
			params ["_text"];
			hintSilent _text;
			sleep 3;
			hintSilent "";
		};
	};

	_text
};

FN_addDefecationPoints = {
    params ["_player", "_points"];
    private _currentStatus = _player getVariable ["defecationStatus", 0];
    _currentStatus = _currentStatus + _points;
    if (_currentStatus > 100) then { _currentStatus = 100; };
    _player setVariable ["defecationStatus", _currentStatus];
};

// Update every 10 seconds, meter grows to 100 in one hour.
[] spawn {
	while {true} do {
		while { alive player } do {
			sleep 360; // check every 5 minutes
			
			private _currentStatus = player getVariable ["defecationStatus", 0];
			_currentStatus = _currentStatus + 1;
			if (_currentStatus > 100) then { _currentStatus = 100; };
			player setVariable ["defecationStatus", _currentStatus];
			
			// Auto-trigger defecation when meter reaches 100
			if (_currentStatus >= 100) then {
				_displayText1 = format ["<t color='#873e23' size='0.8'>Your bowels moan loudly<br/>You will have to relieve yourself in 10 seconds</t>"];
				[ _displayText1, 0.75, 1, 2, 0.3, 0, 789 ] spawn BIS_fnc_dynamicText;
				sleep 10;
				[player] call FN_defecate;
				player setVariable ["defecationStatus", 0];
			} else {
				if (_currentStatus > 90) then {
					if ((random 1) > 0.75) then {
						_displayText = format ["<t color='#873e23' size='.80'>Your bowels moan loudly</t>"];
						[ _displayText, 0.85, 1, 2, 0.3, 0, 789 ] spawn BIS_fnc_dynamicText;
					};
				};
			};
		};
		player setVariable ["defecationStatus", 0];
		sleep 5;
	};
};