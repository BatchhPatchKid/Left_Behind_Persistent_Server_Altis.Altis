// Initial variable declarations

bodyTemp = 98.6;
private _coldWeatherClothing = ["coldWeatherClothing"] call (missionNamespace getVariable "FN_arrayReturn");
private _hotWeatherClothing = ["hotWeatherClothing"] call (missionNamespace getVariable "FN_arrayReturn");
private _coldWeatherGoggles = ["coldWeatherGoggles"] call (missionNamespace getVariable "FN_arrayReturn");
private _coldWeatherHeadgear = ["coldWeatherHeadgear"] call (missionNamespace getVariable "FN_arrayReturn");
private _coldVests = ["coldVests"] call (missionNamespace getVariable "FN_arrayReturn");
private _coldUniform = 1; // lower is better
private _coldRain = 0; // higher is better
private _fireCancel = 1; // stops cold from being as brutal due to fire being close to player
private _inBuilding = false; // in-building increases fire warmth and decreases cold taken, as well as eliminates rain coldness multiplier
private _checkStats = false;
_bodyTempCalc = 0;
player setVariable ["Temp", 98.6, true];

FN_temperature = {
	_handle = 0 spawn {
		
		private _coldWeatherClothing = ["coldWeatherClothing"] call (missionNamespace getVariable "FN_arrayReturn");
		private _hotWeatherClothing = ["hotWeatherClothing"] call (missionNamespace getVariable "FN_arrayReturn");
		private _coldWeatherGoggles = ["coldWeatherGoggles"] call (missionNamespace getVariable "FN_arrayReturn");
		private _coldWeatherHeadgear = ["coldWeatherHeadgear"] call (missionNamespace getVariable "FN_arrayReturn");
		private _coldVests = ["coldVests"] call (missionNamespace getVariable "FN_arrayReturn");

		_playerUniform = uniform player;
		_playerHeadgear = headgear player;
		_playerGoggles = goggles player;
		_playerVest = vest player;
		_playerUniformText = "not cold nor hot weather capable";
		_playerHeadgearText = "not cold weather capable";
		_playerGogglesText = "not cold weather capable";
		_playerVestText = "does not add any warmth";
		
		if (_playerUniform == "") then { _playerUniformText = "not being worn at the moment"; };
		if (_playerUniform in _coldWeatherClothing) then { _playerUniformText = "cold weather capable"; };
		if (_playerUniform in _hotWeatherClothing) then { _playerUniformText = "hot weather capable"; };
		if (_playerHeadgear in _coldWeatherHeadgear) then { _playerHeadgearText = "cold weather capable"; };
		if (_playerGoggles in _coldWeatherGoggles) then { _playerGogglesText = "cold weather capable"; };
		if (_playerVest in _coldVests) then { _playerVestText = "adds some warmth"; };


		if (bodyTemp < 93) then {
			hintSilent parseText format["<t color='#0000FF' size='1'>Body Temp: %1<br/>Uniform is %2<br/> Headgear is %3<br/>Facewear is %4<br/>Vest %5</t>",bodyTemp,_playerUniformText, _playerHeadgearText, _playerGogglesText, _playerVestText];
		};
		if (bodyTemp > 100) then {
			hintSilent parseText format["<t color='#F38701' size='1'>Body Temp: %1<br/><t color='#ffffff' size='1'>Uniform is %2<br/> Headgear is %3<br/>Facewear is %4<br/>Vest %5</t>",bodyTemp,_playerUniformText, _playerHeadgearText, _playerGogglesText, _playerVestText];
		};
		if (bodyTemp <= 100 && bodyTemp >= 93) then {
			hintSilent parseText format["<t color='#ffffff' size='1'>Body Temp: %1<br/>Uniform is %2<br/> Headgear is %3<br/>Facewear is %4<br/>Vest %5</t>",bodyTemp,_playerUniformText, _playerHeadgearText, _playerGogglesText, _playerVestText];
		};
		sleep 6;
		hintSilent "";
	};
};

FN_getTemp = {
	bodyTemp;
};

getCalculatedBodyTempAndHealth = {
    params ["_checkStats"];
    _coldUniform = 1; // lower is better
    _coldRain = 0; // higher is better
    _fireCancel = 1;
    _inBuilding = false;
    _bodyTempCalc = 0;
    _time = daytime;

    // Searching for fire
    _objectsNearPlayer = nearestObjects [player, ["Campfire_burning_F", "FirePlace_burning_F", "MetalBarrel_burning_F"], 5];
    _numObjects = count _objectsNearPlayer;
    _isFire = _numObjects > 0;

    // Getting altitude of player
    _playerAlt = (getPosASL player) select 2;

    // Getting uniform of player to decrease the cold if cold weather gear is being worn or increase the cold if hot weather clothing is being worn
    _playerUniform = uniform player;
	_playerHeadgear = headgear player;
	_playerGoggles = goggles player;
	_playerVest = vest player;
	
    if (_playerUniform == "") then { _coldUniform = 3.0 };
    if (_playerUniform in _coldWeatherClothing) then { _coldUniform = _coldUniform * 0.2 };
    if (_playerUniform in _hotWeatherClothing) then { _coldUniform = _coldUniform * 5.0 };
	if (_playerHeadgear in _coldWeatherHeadgear) then { _coldUniform = _coldUniform  * 0.75; };
	if (_playerGoggles in _coldWeatherGoggles) then { _coldUniform = _coldUniform  * 0.75; };
	if (_playerVest in _coldVests) then { _coldUniform = _coldUniform * 0.90 };

    // GET NEAREST BUILDING
    _nbuilding = nearestObjects [player, ["house"], 10];

    {
        if ((typeOf _x isEqualTo "Campfire_burning_F") or (typeOf _x isEqualTo "FirePlace_burning_F") or (typeOf _x isEqualTo "MetalBarrel_burning_F")) then {
            _nbuilding = _nbuilding - [_x];
        };
		sleep .01;
    } forEach _nbuilding;

    _inBuilding = false;
    if (count _nbuilding > 0) then { _inBuilding = true; } else { _inBuilding = false; };

    if !(_inBuilding) then {
        if (rain > .9) then { _coldRain = .3; };
        if (rain > .7 && rain <= .9) then { _coldRain = .09; };
        if (rain > .5 && rain <= .7) then { _coldRain = .07; };
        if (rain > .3 && rain <= .7) then { _coldRain = .05; };
        if (rain > .15 && rain <= .3) then { _coldRain = .03; };
        if (rain > 0.1 && rain <= .15) then { _coldRain = .01; };
        if (rain <= 0.1) then { _coldRain = 0; };
        _inBuilding = false;
    } else {
        _inBuilding = true;
    };

    if (_isFire) then {
        if (bodyTemp < 98.6) then {
            bodyTemp = bodyTemp + 0.25;
            if (_inBuilding) then { _fireCancel = .01; };
        } else {
            bodyTemp = bodyTemp + 0.005;
        };
    };

    if (_time < 4 || _time > 20) then { // Night time
        if (_playerAlt > 450) then { _bodyTempCalc = _fireCancel * ((0.03556 * _coldUniform) + _coldRain); };
        if (_playerAlt > 400 && _playerAlt <= 450) then { _bodyTempCalc = _fireCancel * ((0.03048 * _coldUniform) + _coldRain); };
        if (_playerAlt > 300 && _playerAlt <= 350) then { _bodyTempCalc = _fireCancel * ((0.02667 * _coldUniform) + _coldRain); };
        if (_playerAlt > 250 && _playerAlt <= 300) then { _bodyTempCalc = _fireCancel * ((0.02370 * _coldUniform) + _coldRain); };
        if (_playerAlt > 200 && _playerAlt <= 250) then { _bodyTempCalc = _fireCancel * ((0.02133 * _coldUniform) + _coldRain); };
        if (_playerAlt > 150 && _playerAlt <= 200) then { _bodyTempCalc = _fireCancel * ((0.01939 * _coldUniform) + _coldRain); };
        if (_playerAlt > 100 && _playerAlt <= 150) then { _bodyTempCalc = _fireCancel * ((0.01778 * _coldUniform) + _coldRain); };
        if (_playerAlt > 50 && _playerAlt <= 100) then { _bodyTempCalc = _fireCancel * ((0.01641 * _coldUniform) + _coldRain); };
        if (_playerAlt > 0 && _playerAlt <= 50) then { _bodyTempCalc = _fireCancel * ((0.01524 * _coldUniform) + _coldRain); };
    } else { // Day time
        if (_playerAlt > 450) then { _bodyTempCalc = _fireCancel * ((0.02133 * _coldUniform) + _coldRain); };
        if (_playerAlt > 400 && _playerAlt <= 450) then { _bodyTempCalc = _fireCancel * ((0.01939 * _coldUniform) + _coldRain); };
        if (_playerAlt > 300 && _playerAlt <= 350) then { _bodyTempCalc = _fireCancel * ((0.01778 * _coldUniform) + _coldRain); };
        if (_playerAlt > 250 && _playerAlt <= 300) then { _bodyTempCalc = _fireCancel * ((0.01641 * _coldUniform) + _coldRain); };
        if (_playerAlt > 200 && _playerAlt <= 250) then { _bodyTempCalc = _fireCancel * ((0.01524 * _coldUniform) + _coldRain); };
        if (_playerAlt > 150 && _playerAlt <= 200) then { _bodyTempCalc = _fireCancel * ((0.01422 * _coldUniform) + _coldRain); };
        if (_playerAlt > 100 && _playerAlt <= 150) then { _bodyTempCalc = _fireCancel * ((0.01333 * _coldUniform) + _coldRain); };
        if (_playerAlt > 50 && _playerAlt <= 100) then { _bodyTempCalc = _fireCancel * ((0.01255 * _coldUniform) + _coldRain); };
        if (_playerAlt > 0 && _playerAlt <= 50) then { _bodyTempCalc = _fireCancel * ((0.01185 * _coldUniform) + _coldRain); };
    };

    if (surfaceIsWater getPos player && isNull objectParent player && !(_checkStats)) then { // Checking to see if the player is in water and not in a boat
        bodyTemp = bodyTemp - 0.3;
    };
	
	// if the player is in a vehicle, then have the body temperature slow down in either overheating or freezing
	if !(isNull objectParent player) then { 
		_bodyTempCalc = _bodyTempCalc * .85;
	};
    
    if !(_checkStats) then {
		bodyTemp = bodyTemp - _bodyTempCalc;
        if (bodyTemp < 91) then {
            if (bodyTemp < 89 && (random 1) > .80) then {  player setDamage 1; };
            addCamShake [0.5, 1, 10];
           

            [format ["<t color='#0000FF' size='.5'>EXTREMELY LOW BODY TEMP<br/>Current Temp: %1</t>",bodyTemp], .8, 1, 1.5, .3, 0, 789] spawn BIS_fnc_dynamicText;

            if ((round (random 20)) == 1) then {
                [player, true, 15] call ace_medical_fnc_setUnconscious;
            };
        };
        if (bodyTemp > 106) then {
            if (bodyTemp > 108 && (random 1) > .80) then { player setDamage 1; };
            addCamShake [0.5, 1, 10];

            [format ["<t color='#F38701' size='.5'>EXTREMELY HIGH BODY TEMP<br/>Current Temp: %1</t>",bodyTemp], .8, 1, 1.5, .3, 0, 789] spawn BIS_fnc_dynamicText;
				
            if ((round (random 20)) == 1) then {
                [player, true, 15] call ace_medical_fnc_setUnconscious;
            };
        };
    };
    [bodyTemp, _bodyTempCalc];
};

while {true} do {
    while {alive player} do {
        _returnedValues = [false] call getCalculatedBodyTempAndHealth;
        bodyTemp = _returnedValues select 0;
        sleep 5;
    };
    // Once the player dies, reset the variables
    bodyTemp = 98.6;
    _coldUniform = 1; // lower is better
    _coldRain = 0; // higher is better
    _fireCancel = 1;
    _inBuilding = false;
    sleep 5;
};