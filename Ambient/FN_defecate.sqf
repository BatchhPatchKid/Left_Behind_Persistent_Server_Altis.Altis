// Retrieve the current defecation status (expected to be between 0 and 100)
private _status = player getVariable ["defecationStatus", 0];

// Check if the player is allowed to defecate
if (_status < 10) exitWith {
	hint "You don't feel the urge to defecate yet";
	//Clear hint after ~3s
	0 spawn {
		sleep 3;
		hintSilent "";
	};
};

// Calculate the delay linearly from 12.5 sec (minimum) to 25 sec (if status=100)
private _delay = 12.5 + ((_status / 100) * 12.5);

_handle = [_delay] spawn {
	params ["_delay"];
	// Play the animation chain using your provided animations
	player playMove "AmovPercMstpSrasWrflDnon_AmovPknlMstpSlowWrflDnon";
	sleep 1.5;
	player switchMove "Acts_AidlPercMstpSloWWrflDnon_warmup_6_loop";
	sleep _delay;
	player playMoveNow "AmovPercMstpSrasWrflDnon";
};

// Reset the defecation status
player setVariable ["defecationStatus", 0];