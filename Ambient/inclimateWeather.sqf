if (isServer) then {
	 player setVariable ["Temp", bodyTemp, true];
	params ["_trigger", "_type"];

	private _coldWeatherClothing = ["coldWeatherClothing"] call (LB_fnc_arrayReturn);
	private _hotWeatherClothing = ["hotWeatherClothing"] call (LB_fnc_arrayReturn);
	private _coldWeatherGoggles = ["coldWeatherGoggles"] call (LB_fnc_arrayReturn);
	private _coldWeatherHeadgear = ["coldWeatherHeadgear"] call (LB_fnc_arrayReturn);
	private _coldVests = ["coldVests"] call (LB_fnc_arrayReturn);

	private _weatherCoe = 1;

	private _playersInTrigger = [];
	private _index = 0;
	
	if (_type == "cold") then {
		while {true} do {
			_index = 0;
			private _players = allPlayers - entities "HeadlessClient_F";
			_playersInTrigger = [];
		
			{
				if (_x inArea _trigger) then { _index = _index + 1; _playersInTrigger = _playersInTrigger + [_x];};
				sleep .01;
			} forEach _players;
		
			if (_index == 0) then { break; };
			_index = 0;
			
			// Getting uniform of player to decrease the cold if cold weather gear is being worn or increase the cold if hot weather clothing is being worn
			_playerUniform = uniform player;
			_playerHeadgear = headgear player;
			_playerGoggles = goggles player;
			_playerVest = vest player;
			if (_playerUniform == "") then { _weatherCoe = _weatherCoe * 1.2; };
			if (_playerUniform in _coldWeatherClothing) then { _weatherCoe = _weatherCoe * 0.2; };
			if (_playerUniform in _hotWeatherClothing) then { _weatherCoe = _weatherCoe * 2.0; };
			if (_playerHeadgear in _coldWeatherHeadgear) then { _weatherCoe = _weatherCoe  * 0.75; };
			if (_playerGoggles in _coldWeatherGoggles) then { _weatherCoe = _weatherCoe  * 0.75; };
			if (_playerVest in _coldVests) then { _weatherCoe = _weatherCoe * 0.90 };
			
			
			{
				// Getting altitude of player
				_playerAlt = (getPosASL _x) select 2;
			
				if (_playerAlt < 100) then { bodyTemp = bodyTemp - (.25*_weatherCoe); };
				if (_playerAlt >= 100 AND _playerAlt < 200) then { bodyTemp = bodyTemp - (.3*_weatherCoe); };
				if (_playerAlt >= 200 AND _playerAlt < 300) then { bodyTemp = bodyTemp - (.4*_weatherCoe); };
				if (_playerAlt >= 300) then { bodyTemp = bodyTemp - (.5*_weatherCoe); };
				sleep .01;
			} forEach _playersInTrigger;
			_weatherCoe = 1;
			sleep 10;
		};
	} else { // Else == HOT
		while {true} do {
		
			_index = 0;
			private _players = allPlayers - entities "HeadlessClient_F";
			_playersInTrigger = [];
		
			{
				if (_x inArea _trigger) then { _index = _index + 1; _playersInTrigger = _playersInTrigger + [_x];};
				sleep .01;
			} forEach _players;
		
			if (_index == 0) then { break; };
			_index = 0;
			
			// Getting uniform of player to decrease the cold if cold weather gear is being worn or increase the freezing effect if hot weather clothing is being worn
			_playerUniform = uniform player;
			_playerHeadgear = headgear player;
			_playerGoggles = goggles player;
			_playerVest = vest player;
			if (_playerUniform == "") then { _weatherCoe = _weatherCoe * 0.5 };
			if (_playerUniform in _coldWeatherClothing) then { _weatherCoe = _weatherCoe * 1.75; };
			if (_playerUniform in _hotWeatherClothing) then { _weatherCoe = _weatherCoe * 0.05; };
			if (_playerHeadgear in _coldWeatherHeadgear) then { _weatherCoe = _weatherCoe  * 1.2; };
			if (_playerGoggles in _coldWeatherGoggles) then { _weatherCoe = _weatherCoe  * 1.5; };
			if (_playerVest in _coldVests) then { _weatherCoe = _weatherCoe * 1.15; };
			
			{
				// Getting altitude of player
				_playerAlt = (getPosASL _x) select 2;
			
				if (_playerAlt < 100) then { bodyTemp = bodyTemp + (.1*_weatherCoe); };
				if (_playerAlt >= 100 AND _playerAlt < 200) then { bodyTemp = bodyTemp + (.08*_weatherCoe); };
				if (_playerAlt >= 200 AND _playerAlt < 300) then { bodyTemp = bodyTemp + (.06*_weatherCoe); };
				if (_playerAlt >= 300) then { bodyTemp = bodyTemp + (.04*_weatherCoe); };
				sleep .01;
			} forEach _playersInTrigger;
			_weatherCoe = 1;
			sleep 10;
		};
	};
};