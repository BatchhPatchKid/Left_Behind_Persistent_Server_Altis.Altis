/* FN_getScalar.sqf
   This function returns a scalar value between 0 and 0.3 based on the player's temperature.
   - At 98.6°F, the scalar is 0.
   - At 89°F (or lower) and 108°F (or higher), the scalar is 0.3.
   The increase is linear between these values.
   
   Usage:
       private _scalar = [player] call FN_getScalar;
*/
FN_getScalar = {
    private _temp = [player] call FN_getTemp;
    private _scalar = 0;
    if (_temp < 98.6) then {
        _scalar = ((98.6 - _temp) / (98.6 - 89)) * 0.3;
    } else {
        _scalar = ((_temp - 98.6) / (108 - 98.6)) * 0.3;
    };
    _scalar = _scalar min 0.3;
    _scalar = _scalar max 0;
    _scalar
};

/* hydrationNutritionSystem.sqf
   This script handles both hydration and nutrition for the player using the new scalar system.
   
   Hydration:
   - Maximum: 100.
   - Base rate: 1 point per cycle (2 minutes).
   - Modified by adding the scalar value from FN_getScalar (0 to 0.3).
     
   Nutrition:
   - Maximum: 100.
   - Base rate: 1 point per 3 minutes (≈0.67 points per 30 second cycle).
   - Modified by adding the scalar value from FN_getScalar.
     
   When either hydration or nutrition reaches 0:
   - A 10% chance will trigger a pass out using [player, true, 15] call ace_medical_fnc_setUnconscious.
   - A 20% chance will kill the player (using player setDamage 1).
   
   Note: Drinking water (e.g., rvg_plasticBottlePurified) should restore 35 hydration points,
         and eating food should restore nutrition (handled in their respective scripts/actions).
*/

// Display function for stats (using hint for simplicity)
FN_displayHydrationNutrition = {
    _handle = 0 spawn {
        private _hydration = player getVariable ["hydrationLevel", 100];
        private _nutrition = player getVariable ["nutritionLevel", 100];
        hintSilent parseText format["<t color='#ffffff' size='1'>Hydration: %1<br/>Nutrition: %2</t>", _hydration, _nutrition];
        sleep 3;
        hintSilent "";
    };
};

// Initialize hydration and nutrition if not already set
if (isNil "hydrationLevel") then {
    player setVariable ["hydrationLevel", 100];
};

if (isNil "nutritionLevel") then {
    player setVariable ["nutritionLevel", 100];
};

private _displayText = format ["<t color='#000000' size='.75'></t>"];

sleep 0.5;

while {true} do {
    while {alive player} do {
        ///////////////////////
        // HYDRATION SECTION //
        ///////////////////////
        
        // Calculate the scalar adjustment based on the player's temperature.
        private _scalar = [player] call FN_getScalar;
        // Base hydration decrease is 1 point per cycle.
        private _baseHydrationDecrease = 1;
        // Final hydration decrease is base rate plus the scalar.
        private _finalHydrationRate = _baseHydrationDecrease + _scalar;
        
        // Update hydration, ensuring it doesn't drop below 0.
        private _currentHydration = player getVariable ["hydrationLevel", 100];
        private _newHydration = _currentHydration - _finalHydrationRate;
        if (_newHydration < 0) then { _newHydration = 0; };
        player setVariable ["hydrationLevel", _newHydration];
        
        // If hydration reaches 0, check for passing out or death.
        if (_newHydration == 0) then {
            if (random 1 < 0.1) then {
                [player, true, 15] call ace_medical_fnc_setUnconscious;
            };
            if (random 1 < 0.20) then {
                player setDamage 1;
            };
        };
        
        //////////////////////////
        // NUTRITION SECTION  //
        //////////////////////////
        
        // Base nutrition decrease is 1 point per 3 minutes (≈0.67 per 30 second cycle).
        private _baseNutritionDecrease = 2/3;
        // Final nutrition decrease is base rate plus the scalar.
        private _finalNutritionDecrease = _baseNutritionDecrease + _scalar;
        
        // Update nutrition, ensuring it doesn't drop below 0.
        private _currentNutrition = player getVariable ["nutritionLevel", 100];
        private _newNutrition = _currentNutrition - _finalNutritionDecrease;
        if (_newNutrition < 0) then { _newNutrition = 0; };
        player setVariable ["nutritionLevel", _newNutrition];
        
        // Warning section for low nutrition.
        if (_newNutrition < 20) then {
            if (_newNutrition <= 1) then {
                if ((random 1) > 0.20) then {
                    _displayText = format ["<t color='#aa6910' size='1.2'>Your stomach growls violently</t>"];
                    [ _displayText, 0.85, 1, 2, 0.3, 0, 789 ] spawn BIS_fnc_dynamicText;
                };
            } else {
                if ((random 1) > 0.85) then {
                    _displayText = format ["<t color='#e7b774' size='.80'>Your stomach growls loudly</t>"];
                    [ _displayText, 0.85, 1, 2, 0.3, 0, 789 ] spawn BIS_fnc_dynamicText;
                };
            };
        };
        
        // Warning section for low hydration.
        if (_newHydration < 20) then {
            if (_newHydration <= 1) then {
                if ((random 1) > 0.20) then {
                    _displayText = format ["<t color='#36aac2' size='1.2'>You feel extremely parched, and your muscles cramp insistently</t>"];
                    [ _displayText, 0.70, 1, 2, 0.3, 0, 789 ] spawn BIS_fnc_dynamicText;
                };
            } else {
                if ((random 1) > 0.85) then {
                    _displayText = format ["<t color='#74d3e7' size='.80'>Your mouth feels dry</t>"];
                    [ _displayText, 0.85, 1, 2, 0.3, 0, 789 ] spawn BIS_fnc_dynamicText;
                };
            };
        };
        
        // If nutrition reaches 0, check for passing out or death.
        if (_newNutrition == 0) then {
            if (random 1 < 0.1) then {
                [player, true, 15] call ace_medical_fnc_setUnconscious;
            };
            if (random 1 < 0.20) then {
                player setDamage 1;
            };
        };
        
		//hintSilent parseText format ["<t>Current scalar: %1<br/>Dehydration Rate: %2<br/>Starvation Rate: %3</t>", _scalar, _finalHydrationRate, _finalNutritionDecrease];
        sleep 30;
    };
    // When the player is dead, reset the levels and wait a few seconds before restarting the loop.
    player setVariable ["hydrationLevel", 100];
    player setVariable ["nutritionLevel", 100];
    sleep 5;
};