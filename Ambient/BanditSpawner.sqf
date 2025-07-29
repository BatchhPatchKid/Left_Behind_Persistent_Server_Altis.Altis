if (side player != civilian) then {
    private _minDist = 270;
    private _maxDist = 500;
    private _banditTracker = 0;
    private _maxBanditGroups = 1;
    private _maxBandits = 1; // Bandits per group plus 1
    private _factionArray = ["taskFactionWeights"] call (missionNamespace getVariable "FN_arrayReturn");
    private _trader = false;

    null = [_maxBanditGroups, _minDist, _maxDist, _banditTracker, _maxBandits, _factionArray, _trader] spawn {
        params ["_maxBanditGroups", "_minDist", "_maxDist", "_banditTracker", "_maxBandits", "_factionArray", "_trader"];

        _banditGroupArray = [];

        while {true} do {
            // Checking if player alive 
            while {alive player} do {
                if (round (random 15) == 1) then {

                    if (!(vehicle player isKindOf "Helicopter")) then { //Jets check

                        // Checking if limit reached
                        if (_banditTracker < _maxBanditGroups) then {

                            // Selecting position
                            _pos = [getPos player, _minDist, _maxDist, 3, 0, 20, 0] call BIS_fnc_findSafePos;
							
							_faction = _factionArray call BIS_fnc_selectRandomWeighted;;
							_unitSkillsArray = [_faction, _pos] call compile preprocessFileLineNumbers "AISpawners\aiSubScripts\factionSideAndDifficulty.sqf";

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

							_meleeChance = [_faction] call compile preprocessFileLineNumbers "AISpawners\aiSubScripts\meleeChance.sqf";

                            // Spawning bandit
                            if ({_x distance2D _pos < (_minDist * 0.75)} count allPlayers == 0) then { // 0.75 * 150 = 112.5 real minimum distance
                                _groupBandit = createGroup [_side, true];

                                for "_i" from 0 to _maxBandits do {
									private _banditUnit;
									if (random 1 > _meleeChance) then {
										_banditUnit = _groupBandit createUnit [_unit, _pos, [], 15, "NONE"];
										[_faction, _banditUnit, false, false, _sfOverride] execVM "AISpawners\aiSubScripts\equipAI.sqf";
										[_banditUnit,_aim,_aimSpeed,_spot,_courage,_aimShake,_command,_spotDist,_reload] execVM "AISpawners\aiSubScripts\FN_setSkill.sqf";

										if (_side == WEST && (random 1) > .70) then {
											[_banditUnit] execVM "Economy System\economySystem.sqf";
										};
                                    } else {
										_grpTemp = createGroup east;
										_banditUnit = _grpTemp createUnit ["O_soldier_Melee_RUSH",([_pos, 0, 10, 3, 0, 20, 0,[],[]] call BIS_fnc_findSafePos),[],1,"NONE"];
										[_faction, _banditUnit, true, false, false] execVM "AISpawners\aiSubScripts\equipAI.sqf";
										[_banditUnit] joinSilent _groupBandit;
										[_banditUnit,_aim,_aimSpeed,_spot,_courage,_aimShake,_command,_spotDist,_reload] execVM "AISpawners\aiSubScripts\FN_setSkill.sqf";
									};
                                };

                                _pos = [getPos player, _minDist - 100, _maxDist - 100, 3, 0, 20, 0] call BIS_fnc_findSafePos;
                                _waypointPos = _pos;
                                _wp1 = _groupBandit addWaypoint [_waypointPos, 0];
                                _wp1 setWaypointType "MOVE";

                                _pos = [getPos player, _minDist - 100, _maxDist - 100, 3, 0, 20, 0] call BIS_fnc_findSafePos;
                                _waypointPos = _pos;
                                _wp2 = _groupBandit addWaypoint [_waypointPos, 1];
                                _wp2 setWaypointType "MOVE";

                                _pos = [getPos player, _minDist - 100, _maxDist - 100, 3, 0, 20, 0] call BIS_fnc_findSafePos;
                                _waypointPos = _pos;
                                _wp3 = _groupBandit addWaypoint [_waypointPos, 2];
                                _wp3 setWaypointType "MOVE";

                                _pos = [getPos player, _minDist - 100, _maxDist - 100, 3, 0, 20, 0] call BIS_fnc_findSafePos;
                                _waypointPos = _pos;
                                _wp4 = _groupBandit addWaypoint [_waypointPos, 3];
                                _wp4 setWaypointType "CYCLE";

                                _groupBandit enableGunLights "ForceOn";

                                _banditGroupArray = _banditGroupArray + [_groupBandit];
                                _banditTracker = _banditTracker + 1;
                                sleep 2;
                            };
                            sleep 2;
                        };
                        sleep 2;
                    };
                };

                if (count _banditGroupArray > 0) then {
                    _i = 0;
                    _deleteNum = 0;
                    private _headlessClients = entities "HeadlessClient_F";
                    private _humanPlayers = allPlayers - _headlessClients; // All players that aren't headless clients

                    {
                        for "_i" from 0 to (count _humanPlayers) do { // Going through each bandit group to see if it's not next to any player, so any group near a player will not be deleted
                            if (((_humanPlayers select _i) distance2D (getPos ((units _x) select 0))) > (_minDist + _maxDist)) then {
                                _deleteNum = _deleteNum + 1;
                            };
							sleep .01;
                        };

                        if (_deleteNum == (count _humanPlayers)) then {
                            {
                                deleteVehicle _x;
								sleep .01;
                            } forEach units _x;
                            _banditGroupArray = _banditGroupArray - [_x];
                            deleteGroup _x;
                            _banditTracker = _banditTracker - 1;
                        };
                        _deleteNum = 0;
                        sleep .5;
                    } forEach _banditGroupArray;

                    // Checking to see if all units have died
                    {
                        if (count units _x == 0) then {
                            deleteGroup _x;
                            _banditTracker = _banditTracker - 1;
                            _banditGroupArray = _banditGroupArray - [_x];
                        };
						sleep .01;
                    } forEach _banditGroupArray;
                    sleep 15;
                };
                sleep 30;
            };

            {
                {
                    deleteVehicle _x;
					sleep .01;
                } forEach units _x;
                _banditGroupArray = _banditGroupArray - [_x];
                deleteGroup _x;
                _banditTracker = _banditTracker - 1;
				sleep .01;
            } forEach _banditGroupArray;
            sleep 30;
        };
    };
};
