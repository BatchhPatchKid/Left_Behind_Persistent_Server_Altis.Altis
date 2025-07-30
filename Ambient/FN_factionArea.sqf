if (isServer) then {

	params ["_faction", "_trigger"];
	
	[_faction, _trigger] spawn {
		params ["_faction", "_trigger"];
		
		_meleeChance = [_faction] call (missionNamespace getVariable "FN_meleeChance");
		
		_vehArray = "";
		
		switch _faction do {
			case "TRB": { _vehArray = ["TRBVeh"] call (missionNamespace getVariable "FN_arrayReturn"); };
			case "US": { _vehArray = ["USVeh"] call (missionNamespace getVariable "FN_arrayReturn"); };
			case "RU": { _vehArray = ["RUVeh"] call (missionNamespace getVariable "FN_arrayReturn"); };
			case "ROA": { _vehArray = ["ROAVeh"] call (missionNamespace getVariable "FN_arrayReturn"); };
			case "PMC": { _vehArray = ["PMCVeh"] call (missionNamespace getVariable "FN_arrayReturn"); };
			case "ALF": { _vehArray = ["ALFVeh"] call (missionNamespace getVariable "FN_arrayReturn"); };
			default { _vehArray = ["defaultVeh"] call (missionNamespace getVariable "FN_arrayReturn"); };
		};
		
		private _playersInTrigger = [];
		private _index = 0;
		private _minDist = 350;
		private _maxDist = 800;
		private _vehicleBoolean = false;
		
		while {true} do {
			_index = 0;
			private _players = allPlayers - entities "HeadlessClient_F";
			_playersInTrigger= [];
			
			{
				if (_x inArea _trigger) then { _index = _index + 1; _playersInTrigger = _playersInTrigger + [_x];};
				sleep .01;
			} forEach _players;
			
			if (_index == 0) then { break; };
			
			_playerSelected = selectRandom _playersInTrigger;
			
			_pos = [(getPos _playerSelected), _minDist, _maxDist, 3, 0, 20, 0,[],[]] call BIS_fnc_findSafePos;
			
			sleep 1; //waiting for the player to have their faction update incase if it isnt already
			
			_unitSkillsArray = [_faction, _pos] call (missionNamespace getVariable "FN_getFactionSkills");

			_side = _unitSkillsArray select 0;
			_unit = _unitSkillsArray select 1;
			_aim = _unitSkillsArray select 2;
			_aimSpeed = _unitSkillsArray select 3;
			_spot = _unitSkillsArray select 4;
			_courage = _unitSkillsArray select 5;
			_aimShake = _unitSkillsArray select 6;
			_command = _unitSkillsArray select 7;
			_spotDist = _unitSkillsArray select 8;
			_reload = _unitSkillsArray select 9;
			_sfGroup = _unitSkillsArray select 10;
			
			_sfOverride = false;
			if (random _sfGroup < 1) then { _sfOverride = true; };
				
			_breakOut = false;
			while {!(_breakOut)} do {
				{
					if (_playerSelected distance _pos < _minDist) then { [getPos _playerSelected, _minDist, _maxDist, 3, 0, 20, 0,[],[]] call BIS_fnc_findSafePos; } else { _breakOut = true; break; };
					sleep .01;
				} forEach allPlayers;
				sleep .01;
			};
			
			_vehicleBoolean = random 1 > 0.75;
				
			_grpAmbush = createGroup _side;
			
			_trader = false;

			if (_side == WEST) then {
				_trader = TRUE;
			};
				
			if (_vehicleBoolean) then {
				_vehSelection = _vehArray call BIS_fnc_selectRandomWeighted;
				 _veh = _vehSelection createVehicle ([_pos, 5, 15, 3, 0, 20, 0,[],[]] call BIS_fnc_findSafePos);
				
				clearWeaponCargoGlobal _veh;
				clearMagazineCargoGlobal _veh;
				clearItemCargoGlobal _veh;
					
				_numUnits = ceil (random 2)+1;
				for "_i" from 0 to _numUnits do {
					_newAI = _grpAmbush createUnit [_unit,_pos,[],15,"NONE"];
					[_faction, _newAI, false, false, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
					[_newAI, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload] call (missionNamespace getVariable "FN_setUnitSkills");
					_newAI moveInAny _veh;
					sleep .01;
				};
			} else {
				_numUnits = random [2, 3, 4];
				if (random 1 > _meleeChance) then {
					for "_i" from 0 to _numUnits do {
						_newAI = _grpAmbush createUnit [_unit,_pos,[],15,"NONE"];
						[_faction, _newAI, false, false, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
						[_newAI, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload] call (missionNamespace getVariable "FN_setUnitSkills");	
						if (_trader AND (random 1 > .75)) then {
							[_newAI] execVM "Economy System\economySystem.sqf";
						};	
					};
				} else {			
					for "_i" from 0 to _numUnits do {
						grpTemp = createGroup east;
						_newAI = grpTemp createUnit ["O_soldier_Melee_RUSH", _pos, [], 1, "NONE"];
						[_faction, _newAI, true, false, false] call (missionNamespace getVariable "FN_equipAI");
						[_newAI] joinSilent _grpAmbush;
						[_newAI, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload] call (missionNamespace getVariable "FN_setUnitSkills");		
					};
					sleep .01;
				};
			};
				
			_pos = [getPos _playerSelected, _minDist-250, _maxDist-300, 3, 0, 20, 0,[],[]] call BIS_fnc_findSafePos;
			_waypoint1 = _grpAmbush addWaypoint [_pos, 0];
			_waypoint1 setWaypointType "MOVE";
			_waypoint1 setWaypointSpeed "FULL";
			_waypoint1 setWaypointBehaviour "AWARE";
				
			_pos = [getPos _playerSelected, _minDist-250, _maxDist-300, 3, 0, 20, 0,[],[]] call BIS_fnc_findSafePos;
			_waypoint1 = _grpAmbush addWaypoint [_pos, 1];
			_waypoint1 setWaypointType "MOVE";
			_waypoint1 setWaypointSpeed "FULL";
			_waypoint1 setWaypointBehaviour "AWARE";
			
			_pos = [getPos _playerSelected, _minDist-250, _maxDist-300, 3, 0, 20, 0,[],[]] call BIS_fnc_findSafePos;
			_waypoint1 = _grpAmbush addWaypoint [_pos, 2];
			_waypoint1 setWaypointType "CYCLE";
			_waypoint1 setWaypointSpeed "FULL";
			_waypoint1 setWaypointBehaviour "AWARE";
				
			_grpAmbush enableGunLights "ForceOn";
		
			sleep (random 1800)+600;
			
			_index = 0;
			
			{
				if (_x inArea _trigger) then { _index = _index + 1;};
			} forEach _players;
			
			if (_index == 0) then { break; };
		
			sleep .01;
		};
	};
};