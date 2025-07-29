/*
    FN_sanitySystem.sqf
    -------------------
    Handles player's sanity adjustments and gradual restoration.
    Sanity ranges from 0 (insane) to 100 (fully sane).
    When sanity falls to 10 or below, the player's faction alliance is forced to Pig's Flesh.
    
    Usage:
      // To decrease sanity by 5:
      [ -5, player ] call FN_changeSanity;
      
      // To increase sanity by 3:
      [ 3, player ] call FN_changeSanity;
*/

// Function to change sanity by a delta value.
FN_changeSanity = {
    params ["_delta", "_player"];
    private _currentSanity = _player getVariable ["sanityLevel", 100];
    
    // Adjust sanity by the provided delta.
    _currentSanity = _currentSanity + _delta;
    
    // Clamp sanity between 0 and 100.
    _currentSanity = 0 max (_currentSanity min 100);
    _player setVariable ["sanityLevel", _currentSanity, true];
};

// Function to check the player's sanity.
FN_checkSanity = {
    _handle = 0 spawn {
        private _sanity = player getVariable ["sanityLevel", 100];
        if (_sanity <= 10) then {
            hintSilent parseText format["<t color='#ff0000' size='1.2'>Sanity: %1</t>", _sanity];
        } else {
            hintSilent parseText format["<t color='#ffffff' size='1.2'>Sanity: %1</t>", _sanity];
        };
        sleep 3;
        hintSilent "";
    };
};

// Main loop: gradually restores sanity, applies radiation and mutant penalties, and handles low sanity effects.
[] spawn {
    private _restoreRate = 0.005;   // Increase sanity by 0.005 every cycle.
    while { true } do {
		while {alive player} do {
    
			// Gradually restore sanity.
			[_restoreRate, player] call FN_changeSanity;
			
			// Apply radiation-based sanity decrease if radiation is 50 or above.
			private _radValue = player getVariable ["Rad", 0];
			if (_radValue >= 50) then {
				// Calculate sanity loss: scales linearly with rad value from 50 (0.05 loss) to 100 (0.1 loss).
				private _sanityLoss = 0.05 * (_radValue / 50);
				[(-1 * _sanityLoss), player] call FN_changeSanity;
			};
			
			// Apply mutant proximity sanity decrease.
			private _enemyTypes = [
				"DSA_411", "DSA_Abomination", "DSA_Crazy", "DSA_ActiveIdol", 
				"DSA_ActiveIdol2", "DSA_Hatman", "DSA_Mindflayer", "DSA_Rake", 
				"DSA_Shadowman", "DSA_Snatcher", "DSA_Vampire", "DSA_Wendigo"
			];
			private _maxDistance = 50;
			private _lossTotal = 0;
			private _nearbyEnemies = allUnits select {
				((typeOf _x) in _enemyTypes) && ((player distance _x) < _maxDistance)
			};
			{
				private _dist = player distance _x;
				// Linear scaling: 0.1 loss when at 0m, 0.001 when at _maxDistance.
				private _loss = 0.1 - (0.099 * (_dist / _maxDistance));
				_loss = 0.01 max (_loss min 0.5);
				_lossTotal = _lossTotal + _loss;
			} forEach _nearbyEnemies;
			if (_lossTotal > 0) then {
				[ -_lossTotal, player ] call FN_changeSanity;
			};
			
			// Retrieve the updated sanity value.
			private _currentSanity = player getVariable ["sanityLevel", 100];
			
			// If sanity is 10 or below, force faction alliance to Pig's Flesh and occasionally play sounds.
			if (_currentSanity <= 10) then {
				// Occasionally play a laugh sound.
				if ((random 1) > 0.90) then {
					private _soundIndex = floor(random 5) + 1;
					switch (_soundIndex) do {
						case 1: {
							[player, ["laugh_1", 100, 1]] remoteExec ["say3D"]; 
						};
						case 2: {
							[player, ["laugh_2", 100, 1]] remoteExec ["say3D"];
						};
						case 3: {
							[player, ["laugh_3", 100, 1]] remoteExec ["say3D"];
						};
						case 4: {
							[player, ["laugh_4", 100, 1]] remoteExec ["say3D"];
						};
						case 5: {
							[player, ["laugh_5", 100, 1]] remoteExec ["say3D"];
						};
					};
					// If sanity reaches 1, occasionally play a heartbeat sound (client side only).
					if (_currentSanity <= 1) then {
						if (!isServer && (random 1) > 0.90) then {
							[player, ["heartbeat", 100, 1]] remoteExec ["say3D"];
						};
					};
				};
			};
			sleep 15;
		};
		player setVariable ["sanityLevel", 100, true];
		sleep 10;
    };
};