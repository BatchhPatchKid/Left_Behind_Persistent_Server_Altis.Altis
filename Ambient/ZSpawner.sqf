if (side player != civilian) then {
	private _minDist = 150;
	private _maxDist = 220;
	private _zedTracker = 0;
	private _maxZedGroups = 1;
	private _maxZeds = 2;
	private _ZedsSlow = ["Zombie_O_Walker_Civ", .95,
	"Zombie_O_Crawler_Civ", .25,
	"Zombie_O_Shooter_FIA", .05,
	"WBK_SpecialZombie_Corrupted_3", .10,
	"RyanZombieC_man_1slowOpfor", .005,
	"RyanZombieC_man_hunter_1_FslowOpfor", .005,
	"RyanZombieC_man_pilot_FslowOpfor", .005,
	"RyanZombieC_journalist_FwalkerOpfor", .005,
	"RyanZombie19walkerOpfor", .005,
	"RyanZombie26walkerOpfor", .005];
	
	sleep 1;
	private _zedFast = ["fastZombie"] call (missionNamespace getVariable "FN_arrayReturn");

	null = [_maxZedGroups, _minDist, _maxDist, _zedTracker, _ZedsSlow, _zedFast, _maxZeds] spawn {
		params ["_maxZedGroups", "_minDist", "_maxDist", "_zedTracker", "_ZedsSlow", "_zedFast", "_maxZeds"];
		_zedGroupArray = [];
		
		while {true} do {
	  
			// Checking if player alive
			while {alive player} do {
				_time = daytime;
				if ((_time < 4 || _time > 20) || (round (random 150) == 1)) then {
					if (!(vehicle player isKindOf "Helicopter")) then { //Jets check

						// Checking if limit reached
						if (_zedTracker < _maxZedGroups) then {

							//selecting position
							_pos = [getPos player, _minDist, _maxDist, 3, 0, 20, 0] call BIS_fnc_findSafePos;

							// Spawning bandit
							if ({_x distance2D _pos < (_minDist*0.75)} count allPlayers == 0) then { //0.75*150 =112.5 real minimum distance	
								
								_groupZed = createGroup [east, true];
								_zedType = "";
								
								for "_i" from 0 to _maxZeds do {
									if (vehicle player isKindOf "car" or (_time < 4 || _time > 20)) then { 
										_zedType = _zedFast call BIS_fnc_selectRandomWeighted;
									} else { 
										_zedType = _ZedsSlow call BIS_fnc_selectRandomWeighted; 
									};
									ZedUnit = _groupZed createUnit [_zedType, _pos, [], 30, "NONE"];
									sleep .01;
								};
								
								_pos = [getPos player, _minDist, _maxDist, 3, 0, 20, 0] call BIS_fnc_findSafePos;
								_waypointPos = _pos;
								_wp1 = _groupZed addWaypoint [_waypointPos, 0];
								_wp1 setWaypointType "MOVE";
								
								_pos = [getPos player, _minDist, _maxDist, 3, 0, 20, 0] call BIS_fnc_findSafePos;
								_waypointPos = _pos;
								_wp2 = _groupZed addWaypoint [_waypointPos, 1];
								_wp2 setWaypointType "MOVE";
								
								_pos = [getPos player, _minDist, _maxDist, 3, 0, 20, 0] call BIS_fnc_findSafePos;
								_waypointPos = _pos;
								_wp3 = _groupZed addWaypoint [_waypointPos, 2];
								_wp3 setWaypointType "MOVE";
								
								_pos = [getPos player, _minDist, _maxDist, 3, 0, 20, 0] call BIS_fnc_findSafePos;
								_waypointPos = _pos;
								_wp4 = _groupZed addWaypoint [_waypointPos, 3];
								_wp4 setWaypointType "CYCLE";
								
								_zedGroupArray = _zedGroupArray + [_groupZed];
								_zedTracker = _zedTracker + 1;
								sleep 2;
							};
							sleep 2;
						};
						sleep 2;
					};
				};
				
				if (count _zedGroupArray > 0) then {
					_i = 0;
					_deleteNum = 0;
					private _headlessClients = entities "HeadlessClient_F";
					private _humanPlayers = allPlayers - _headlessClients; //All players that aren't headless clients
					{
						for "_i" from 0 to (count _humanPlayers) do { // going through each bandit group to see if it's not next to any player, so any group near a player will not be deleted
							if (((_humanPlayers select _i) distance2D (getPos ((units _x) select 0))) > (_minDist + _maxDist)) then { 
								_deleteNum = _deleteNum + 1; 
							};
							sleep .01;
						};
						
						if (_deleteNum == (count _humanPlayers)) then { 
							{ 
								deleteVehicle _x;
							} forEach units _x;
							_zedGroupArray = _zedGroupArray - [_x]; 
							deleteGroup _x; 
							_zedTracker = _zedTracker - 1; 
						};
						_deleteNum = 0;
						sleep .5;
					} forEach _zedGroupArray;
					
					//Checking to see if all units have died
					{
						if (count units _x == 0) then {
							deleteGroup _x;
							_zedTracker = _zedTracker - 1;
							_zedGroupArray = _zedGroupArray - [_x]; 
						};
						sleep .01;
					} forEach _zedGroupArray;
					sleep 2;
				};
				sleep 30;
			};
			sleep 30;
			
			{
				{ 
					deleteVehicle _x;
					sleep .01;
				} forEach units _x;
				_zedGroupArray = _zedGroupArray - [_x]; 
				deleteGroup _x; 
				_zedTracker = _zedTracker - 1; 
				sleep .01;
			} forEach _zedGroupArray;
			sleep .01;
		};
	};
};