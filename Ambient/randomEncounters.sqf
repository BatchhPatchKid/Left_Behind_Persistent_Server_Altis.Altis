// Predefined arrays
private _factionArrayBanditCrazy = ["PF", 0.5, "Bandit", 0.5, "RC", 0.15, "Renegade", 0.25];
private _factionArrayBanditNotCrazy = ["ALF", 0.10, "WO", 0.15, "DT", 0.55, "NH", 0.55, "RC", 0.25, "TRB", .10];
sleep 5;
private _zedFast = ["fastZombie"] call (LB_fnc_arrayReturn);
private _zombieTypesNATO = ["natoZombie"] call (LB_fnc_arrayReturn);
private _heliArray = ["B_Heli_Light_01_dynamicLoadout_F", 0.20, "B_Heli_Transport_03_unarmed_F", 0.35, "B_Heli_Transport_01_F", 0.45, "B_Plane_CAS_01_dynamicLoadout_F", 0.10, "B_Plane_Fighter_01_F", 0.10];
private _ZedsSlow = ["slowZombie"] call (LB_fnc_arrayReturn);
private _ZedsRyan = ["RyanZombieC_man_1slowOpfor", 0.15, "RyanZombieC_man_polo_1_FslowOpfor", 0.15, "RyanZombieC_man_polo_2_FslowOpfor", 0.15, "RyanZombieC_man_polo_4_FslowOpfor", 0.15, "RyanZombieC_man_polo_5_FslowOpfor", 0.15, "RyanZombieC_man_p_fugitive_FslowOpfor", 0.15, "RyanZombieC_man_w_worker_FslowOpfor", 0.15, "RyanZombieC_scientist_FslowOpfor", 0.15, "RyanZombieC_man_hunter_1_FslowOpfor", 0.15, "RyanZombieC_man_pilot_FslowOpfor", 0.15, "RyanZombieC_journalist_FslowOpfor", 0.15, "RyanZombieC_OrestesslowOpfor", 0.15, "RyanZombieC_NikosslowOpfor", 0.15, "RyanZombie15slowOpfor", 0.15, "RyanZombie16slowOpfor", 0.15, "RyanZombie17slowOpfor", 0.15, "RyanZombie18slowOpfor", 0.15, "RyanZombie19slowOpfor", 0.15, "RyanZombie20slowOpfor", 0.15, "RyanZombie21slowOpfor", 0.15, "RyanZombie22slowOpfor", 0.15, "RyanZombie23slowOpfor", 0.15, "RyanZombie24slowOpfor", 0.15, "RyanZombie25slowOpfor", 0.15, "RyanZombie26slowOpfor", 0.15, "RyanZombie27slowOpfor", 0.15, "RyanZombie28slowOpfor", 0.15, "RyanZombie29slowOpfor", 0.15, "RyanZombie30slowOpfor", 0.15, "RyanZombie31slowOpfor", 0.15, "RyanZombie32slowOpfor", 0.15, "RyanZombieC_man_1walkerOpfor", 0.15, "RyanZombieC_man_polo_1_FwalkerOpfor", 0.15, "RyanZombieC_man_polo_2_FwalkerOpfor", 0.15, "RyanZombieC_man_polo_4_FwalkerOpfor", 0.15, "RyanZombieC_man_polo_5_FwalkerOpfor", 0.15, "RyanZombieC_man_polo_6_FwalkerOpfor", 0.15, "RyanZombieC_man_p_fugitive_FwalkerOpfor", 0.15, "RyanZombieC_man_w_worker_FwalkerOpfor", 0.15, "RyanZombieC_scientist_FwalkerOpfor", 0.15, "RyanZombieC_man_hunter_1_FwalkerOpfor", 0.15, "RyanZombieC_man_pilot_FwalkerOpfor", 0.15, "RyanZombieC_journalist_FwalkerOpfor", 0.15, "RyanZombieC_OresteswalkerOpfor", 0.15, "RyanZombieC_NikoswalkerOpfor", 0.15, "RyanZombie15walkerOpfor", 0.15, "RyanZombie16walkerOpfor", 0.15, "RyanZombie17walkerOpfor", 0.15, "RyanZombie18walkerOpfor", 0.15, "RyanZombie19walkerOpfor", 0.15, "RyanZombie20walkerOpfor", 0.15, "RyanZombie21walkerOpfor", 0.15, "RyanZombie22walkerOpfor", 0.15, "RyanZombie23walkerOpfor", 0.15, "RyanZombie24walkerOpfor", 0.15, "RyanZombie25walkerOpfor", 0.15, "RyanZombie26walkerOpfor", 0.15, "RyanZombie27walkerOpfor", 0.15, "RyanZombie28walkerOpfor", 0.15, "RyanZombie29walkerOpfor", 0.15, "RyanZombie30walkerOpfor", 0.15, "RyanZombie31walkerOpfor", 0.15, "RyanZombie32walkerOpfor", 0.15, "RyanZombieC_man_1mediumOpfor", 0.05, "RyanZombieC_man_polo_1_FmediumOpfor", 0.05, "RyanZombieC_man_polo_2_FmediumOpfor", 0.05, "RyanZombieC_man_polo_4_FmediumOpfor", 0.05, "RyanZombieC_man_polo_5_FmediumOpfor", 0.05, "RyanZombieC_man_polo_6_FmediumOpfor", 0.05, "RyanZombieC_man_p_fugitive_FmediumOpfor", 0.05, "RyanZombieC_man_w_worker_FmediumOpfor", 0.05, "RyanZombieC_scientist_FmediumOpfor", 0.05, "RyanZombieC_man_hunter_1_FmediumOpfor", 0.05, "RyanZombieC_man_pilot_FmediumOpfor", 0.05, "RyanZombieC_journalist_FmediumOpfor", 0.05, "RyanZombieC_OrestesmediumOpfor", 0.05, "RyanZombieC_NikosmediumOpfor", 0.05, "RyanZombie15mediumOpfor", 0.05, "RyanZombie16mediumOpfor", 0.05, "RyanZombie17mediumOpfor", 0.05, "RyanZombie18mediumOpfor", 0.05, "RyanZombie19mediumOpfor", 0.05, "RyanZombie20mediumOpfor", 0.05, "RyanZombie21mediumOpfor", 0.05, "RyanZombie22mediumOpfor", 0.05, "RyanZombie23mediumOpfor", 0.05, "RyanZombie24mediumOpfor", 0.05, "RyanZombie25mediumOpfor", 0.05, "RyanZombie26mediumOpfor", 0.05, "RyanZombie27mediumOpfor", 0.05, "RyanZombie28mediumOpfor", 0.05, "RyanZombie29mediumOpfor", 0.05, "RyanZombie30mediumOpfor", 0.05, "RyanZombie31mediumOpfor", 0.05, "RyanZombie32mediumOpfor", 0.05];
private _PBright = 1; private _PCon = 1; private _PRGB = 1; private _PColor = 0;
private _PBrightC = 0.5; private _PConC = 0.6; private _PR = 0.3; private _PColorC = 0.01;

//---------------------------------------------------------------------
// Helper function: Returns a safe position that is not too near any player.
FN_findValidPos = {
    params ["_basePos", "_minDist", "_maxDist"];
    private _pos = [_basePos, _minDist, _maxDist, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
    while { count (allPlayers select { (_x distance _pos) < _minDist }) > 0 } do {
        _pos = [_basePos, _minDist, _maxDist, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        sleep 0.01;
    };
    _pos
};

//---------------------------------------------------------------------
// Helper function: Creates a MOVE waypoint with standard settings.
FN_setMoveWaypoint = {
    params ["_grp", "_pos"];
    private _wp = _grp addWaypoint [_pos, 0];
    _wp setWaypointType "MOVE";
    _wp setWaypointSpeed "FULL";
    _wp setWaypointBehaviour "AWARE";
};

//---------------------------------------------------------------------
// Helper function: Retrieves faction skills array, melee chance, and calculates an override flag.
FN_getFactionData = {
    params ["_faction", "_pos"];
    private _unitSkillsArray = [_faction, _pos] call (missionNamespace getVariable "FN_getFactionSkills");
    private _meleeChance = [_faction] call (missionNamespace getVariable "FN_meleeChance");
    private _sfGroup = _unitSkillsArray select 10;
    private _sfOverride = (random _sfGroup < 1);
    [_unitSkillsArray, _meleeChance, _sfOverride]
};

//---------------------------------------------------------------------
// Main loop
while {true} do {
    private _minDist = 300;
    private _maxDist = 500;
    private _minValue = 3600;
    private _maxValue = 6400 + (600 * (count allPlayers));
    private _sleepAmount = _minValue + floor(random (_maxValue - _minValue));
    sleep _sleepAmount;
    private _rndEncounter = [1, 105] call BIS_fnc_randomInt;
	private _players = allPlayers - entities "HeadlessClient_F";
	private _player = selectRandom _players;
    // BANDIT AMBUSH (<15)
    if (_rndEncounter < 15) then {
        private _faction = selectRandomWeighted _factionArrayBanditCrazy;
        private _factionData = [getPos _player, _faction, _minDist, _maxDist] call { params ["_p", "_f", "_min", "_max"]; [_f, _p] call FN_getFactionData };
        private _unitSkillsArray = _factionData select 0;
        private _meleeChance = _factionData select 1;
        private _sfOverride = _factionData select 2;
        private _pos = [getPos _player, _minDist, _maxDist, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        _pos = [getPos _player, _minDist, _maxDist] call FN_findValidPos;
        private _numUnits = selectRandom [6, 12, 14];
        private _grpAmbush = createGroup independent;
        for "_i" from 0 to _numUnits do {
			private _newAI = _grpAmbush createUnit ["I_G_Survivor_F", _pos, [], 15, "NONE"];
			[_faction, _newAI, false, false, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
			[_newAI, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call (missionNamespace getVariable "FN_setSkill");
            sleep 0.01;
        };
        [getPos _player, _grpAmbush] call { params ["_p", "_g"]; [_g, _p] call FN_setMoveWaypoint; };
        hint "Something feels off. Your instincts tell you to prepare for something...";
    };
    
    // ZOMBIE AMBUSH (15 <= encounter < 30)
    if (_rndEncounter >= 15 && _rndEncounter < 30) then {
        _minDist = 150; _maxDist = 200;
        private _numUnits = selectRandom [12, 14, 16];
        private _pos = [getPos _player, _minDist, _maxDist, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        _pos = [getPos _player, _minDist, _maxDist] call FN_findValidPos;
        private _grpAmbush = createGroup east;
        for "_i" from 0 to _numUnits do { private _unit = selectRandomWeighted _zedFast; private _newAI = _grpAmbush createUnit [_unit, _pos, [], 15, "NONE"]; sleep 0.01; };
        sleep 8;
        [getPos _player, _grpAmbush] call { params ["_p", "_g"]; [_g, _p] call FN_setMoveWaypoint; };
        hint "Something feels off. Your instincts tell you to keep your eyes open for something dangerous...";
    };
    
    // ZOMBIES FIGHTING EACH OTHER (30 <= encounter < 35)
    if (_rndEncounter >= 30 && _rndEncounter < 35) then {
        _minDist = 300; _maxDist = 400;
        private _numUnits = selectRandom [14, 18, 22];
        private _pos = [getPos _player, _minDist - 100, _maxDist - 100, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        _pos = [getPos _player, _minDist - 100, _maxDist - 100] call FN_findValidPos;
        private _grpAmbush = createGroup independent;
        for "_i" from 0 to _numUnits do { private _unit = selectRandomWeighted _zedFast; private _newAI = _grpAmbush createUnit [_unit, _pos, [], 50, "NONE"]; sleep 0.01; };
        hint "You hear odd screams off in the distance...";
    };
    
    // BANDITS FIGHTING ZOMBIES (35 <= encounter < 50)
    if (_rndEncounter >= 35 && _rndEncounter < 50) then {
        private _faction = selectRandomWeighted _factionArrayBanditNotCrazy;
        private _numUnitsB = round(selectRandom [6, 10, 14]);
        private _numUnitsZ = round(selectRandom [14, 18, 22]);
        private _posB = [getPos _player, _minDist, _maxDist, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        _posB = [getPos _player, _minDist, _maxDist] call FN_findValidPos;
        private _factionData = [getPos _player, _faction, _minDist, _maxDist] call { params ["_p", "_f", "_min", "_max"]; [_f, _p] call FN_getFactionData };
        private _unitSkillsArray = _factionData select 0;
        private _meleeChance = _factionData select 1;
        private _sfOverride = _factionData select 2;
        private _grpAmbushB = createGroup independent;
        for "_i" from 0 to _numUnitsB do {
			private _newAI = _grpAmbushB createUnit ["I_G_Survivor_F", _posB, [], 15, "NONE"];
			[_faction, _newAI, false, false, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
			[_newAI, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call (missionNamespace getVariable "FN_setSkill");
        };
        private _posZ = [_posB, 10, 30, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        private _grpAmbushZ = createGroup east;
        for "_i" from 0 to _numUnitsZ do { private _unit = selectRandomWeighted _zedFast; private _newAI = _grpAmbushZ createUnit [_unit, _posZ, [], 15, "NONE"]; sleep 0.01; };
        [ _grpAmbushB, _posZ ] call FN_setMoveWaypoint;
        _grpAmbushB enableGunLights "ForceOn";
        hint "You hear a lot of gunfire off in the distance. You wonder what could be happening...";
    };
    
    // BANDITS FIGHTING OTHER BANDITS (50 <= encounter < 60)
    if (_rndEncounter >= 50 && _rndEncounter < 60) then {
        private _numUnitsB = round(selectRandom [6, 10, 12]);
        private _numUnits2 = round(selectRandom [6, 10, 12]);
        private _faction1 = selectRandomWeighted _factionArrayBanditNotCrazy;
        private _faction2 = selectRandomWeighted _factionArrayBanditCrazy;
        private _pos = [getPos _player, _minDist, _maxDist, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        _pos = [getPos _player, _minDist, _maxDist] call FN_findValidPos;
        private _factionData = [getPos _player, _faction1, _minDist, _maxDist] call { params ["_p", "_f", "_min", "_max"]; [_f, _p] call FN_getFactionData };
        private _unitSkillsArray = _factionData select 0;
        private _meleeChance = _factionData select 1;
        private _sfOverride = _factionData select 2;
        private _grpAmbush = createGroup east;
        for "_i" from 0 to _numUnitsB do {
			private _newAI = _grpAmbush createUnit ["O_G_Survivor_F", _pos, [], 15, "NONE"];
			[_faction1, _newAI, false, false, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
			[_newAI, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call (missionNamespace getVariable "FN_setSkill");
        };
        _grpAmbush setBehaviour "AWARE";
        private _pos2 = [_pos, 150, 200, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        _pos2 = [getPos _player, 150, 200] call FN_findValidPos;
        private _factionData2 = [getPos _player, _faction2, _minDist, _maxDist] call { params ["_p", "_f", "_min", "_max"]; [_f, _p] call FN_getFactionData };
        private _unitSkillsArray2 = _factionData2 select 0;
        private _meleeChance2 = _factionData2 select 1;
        private _sfOverride2 = _factionData2 select 2;
        private _grpAmbush2 = createGroup independent;
        for "_i" from 0 to _numUnits2 do {
			private _newAI = _grpAmbush2 createUnit ["I_G_Survivor_F", _pos2, [], 15, "NONE"];
			[_faction2, _newAI, false, false, _sfOverride2] call (missionNamespace getVariable "FN_equipAI");
			[_newAI, _unitSkillsArray2 select 2, _unitSkillsArray2 select 3, _unitSkillsArray2 select 4, _unitSkillsArray2 select 5, _unitSkillsArray2 select 6, _unitSkillsArray2 select 7, _unitSkillsArray2 select 8, _unitSkillsArray2 select 9] call (missionNamespace getVariable "FN_setSkill");
        };
        [ _grpAmbush2, _pos] call FN_setMoveWaypoint;
        _grpAmbush enableGunLights "ForceOn";
        _grpAmbush2 enableGunLights "ForceOn";
        hint "You hear a lot of gunfire off in the distance. You wonder what could be happening...";
    };
	
	// AIRBORNE FLYOVER (60 <= _rndEncounter < 70)
	if (_rndEncounter >= 60 && _rndEncounter < 70) then {
		private _playerPos = getPos _player;
		// Get a safe ground spawn position 1km away from the player.
		private _spawnPos = [_playerPos, 1000, 1500, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
		// Add a 300m altitude offset.
		private _spawnPosAir = _spawnPos vectorAdd [0, 0, 500];
		// Determine a target waypoint 1km away from the player at 300m altitude.
		private _targetWaypoint = [_playerPos, 5000, 7500, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
		
		// Create a group for the airborne event.
		private _airGroup = createGroup civilian;
		// Spawn a random helicopter from _heliArray at the air spawn position.
		private _heli = [_spawnPosAir, 0, (selectRandomWeighted _heliArray), _airGroup] call BIS_fnc_spawnVehicle;
		
		{
			_x setCaptive true;
		} forEach units _airGroup;
		
		// Add a waypoint so the aircraft flies over the player.
		private _wp1 = _airGroup addWaypoint [_playerPos, 0];
		_wp1 setWaypointType "MOVE";
		_wp1 setWaypointSpeed "FULL";
		_wp1 setWaypointBehaviour "CARELESS";
		
		// Add a second waypoint so the aircraft flies toward the target waypoint.
		private _wp2 = _airGroup addWaypoint [_targetWaypoint, 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointSpeed "FULL";
		_wp2 setWaypointBehaviour "CARELESS";
	};

    // HELI/PLANE CRASH (70 <= encounter < 80)
    if (_rndEncounter >= 70 && _rndEncounter < 80) then {
        private _pos = [getPos _player, _minDist, _maxDist, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        _pos = [getPos _player, _minDist, _maxDist] call FN_findValidPos;
        private _heli = (selectRandomWeighted _heliArray) createVehicle _pos;
		_heli setPosASL [((getPosASL _heli) select 0), ((getPosASL _heli) select 1), 500];
        sleep 8;
        [_pos, 2] call (LB_fnc_lootSpawner);
        private _rndNumCR = random 18;
        if (_rndNumCR <= 10) then {
            private _grpAmbush = createGroup east;
            private _numUnitsZ = round(selectRandom [15, 18, 21]);
            for "_i" from 0 to _numUnitsZ do {
                private _unit = selectRandomWeighted _zombieTypesNATO;
                private _newAI = _grpAmbush createUnit [_unit, _pos, [], 50, "NONE"];
                sleep 0.01;
            };
        } else {
            private _grpAmbush = createGroup independent;
            private _faction = selectRandomWeighted _factionArrayBanditNotCrazy;
            private _factionData = [_faction, getPos _player] call FN_getFactionData;
            private _unitSkillsArray = _factionData select 0;
            private _meleeChance = _factionData select 1;
            private _sfOverride = _factionData select 2;
            private _posB = [ _pos, 200, 300, 3, 0, 20, 0, [], [] ] call BIS_fnc_findSafePos;
            _posB = [ _pos, 200, 300 ] call FN_findValidPos;
            for "_i" from 0 to (round(selectRandom [4, 6, 8])) do {
				private _newAI = _grpAmbush createUnit ["I_G_Survivor_F", _posB, [], 15, "NONE"];
				[_faction, _newAI, false, false, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
				[_newAI, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call (missionNamespace getVariable "FN_setSkill");
                sleep 0.01;
            };
            [ _grpAmbush, _pos ] call FN_setMoveWaypoint;
            _grpAmbush enableGunLights "ForceOn";
        };
        hint "You hear a large explosion off in the distance. You wonder what that could be...";
    };
    
    // TANK vs SMASHER (80 <= encounter < 82)
    if (_rndEncounter >= 80 && _rndEncounter < 82) then {
        private _pos = [getPos _player, _minDist, _maxDist, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        _pos = [getPos _player, _minDist, _maxDist] call FN_findValidPos;
        private _tank = "B_MBT_01_TUSK_F" createVehicle _pos;
        private _tankGrp = createGroup independent;
        private _unit1 = _tankGrp createUnit ["I_crew_F", _tank, [], 10, "CARGO"];
        ["US", _unit1, false, true] call (missionNamespace getVariable "FN_equipAI");
        private _unit2 = _tankGrp createUnit ["I_crew_F", _tank, [], 10, "CARGO"];
        ["US", _unit2, false, true] call (missionNamespace getVariable "FN_equipAI");
        private _unit3 = _tankGrp createUnit ["I_crew_F", _tank, [], 10, "CARGO"];
        ["US", _unit3, false, true] call (missionNamespace getVariable "FN_equipAI");
        { _x moveInAny _tank } forEach units _tankGrp;
        clearWeaponCargoGlobal _tank;
        clearMagazineCargoGlobal _tank;
        clearItemCargoGlobal _tank;
        private _posS = [_pos, 300, 400, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        _posS = [_pos, 300, 400] call FN_findValidPos;
        [ _tankGrp, _posS ] call FN_setMoveWaypoint;
        private _smasherGrp = createGroup east;
        private _smasher = _smasherGrp createUnit ["WBK_SpecialZombie_Smasher_3", _posS, [], 0, "NONE"];
        sleep 10;
        [getPos _player, _smasherGrp] call { params ["_p", "_g"]; [_g, _p] call FN_setMoveWaypoint; };
        [1] spawn BIS_fnc_earthquake;
        hint "You hear huge explosions off in the distance followed by roars. You wonder what that could be...";
        sleep 25;
        _tank setDamage 1;
    };
    
    // BEING HUNTED BY A SNIPER (82 <= encounter < 90)
    if (_rndEncounter >= 82 && _rndEncounter < 90) then {
        private _pos = [getPos _player, _minDist, _maxDist, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
        _pos = [getPos _player, _minDist, _maxDist] call FN_findValidPos;
        private _sniperGrp = createGroup east;
        private _newAI = _sniperGrp createUnit ["O_G_Survivor_F", _pos, [], 15, "NONE"];
        _newAI addGoggles (selectRandom ["G_Balaclava_oli", "G_Balaclava_TI_blk_F", "G_Balaclava_TI_G_blk_F", "G_Balaclava_TI_tna_F", "G_Balaclava_TI_G_tna_F", "G_Balaclava_blk", "G_Balaclava_lowprofile"]);
        _newAI addUniform (selectRandom ["U_I_FullGhillie_ard", "U_O_FullGhillie_ard", "U_B_FullGhillie_ard", "U_O_T_FullGhillie_tna_F", "U_B_T_FullGhillie_tna_F", "U_I_FullGhillie_lsh", "U_O_FullGhillie_lsh", "U_B_FullGhillie_lsh", "U_I_FullGhillie_sard", "U_O_FullGhillie_sard", "U_B_FullGhillie_sard"]);
        _newAI addVest (selectRandom ["V_SmershVest_01_radio_F", "V_SmershVest_01_F"]);
        private _rifle = selectRandom ["rhs_weap_t5000", "rhs_weap_svds_npz", "srifle_DMR_04_Tan_F", "srifle_GM6_camo_F", "rhs_weap_M107_w", "rhs_weap_m14_wd", "srifle_LRR_camo_F", "rhs_weap_XM2010_sa", "rhs_weap_m24sws_wd", "rhs_weap_m40a5_wd", "rhs_weap_sr25_ec_wd", "rhs_weap_svdp_wd_npz"];
        private _scope = selectRandom ["optic_DMS", "optic_DMS_weathered_Kir_F", "optic_DMS_ghex_F", "optic_DMS_weathered_F", "optic_MRCO", "ACE_optic_MRCO_2D", "optic_KHS_hex", "optic_KHS_old", "optic_KHS_tan", "optic_Hamr", "optic_KHS_blk", "ACE_optic_Hamr_2D", "optic_Hamr_khk_F", "ACE_optic_Hamr_PIP", "optic_SOS", "optic_SOS_khk_F", "ACE_optic_SOS_PIP", "optic_NVS", "optic_AMS", "rhsusf_acc_ACOG_RMR", "optic_LRPS", "rhsusf_acc_nxs_3515x50f1_md_sun", "rhsusf_acc_nxs_5522x56_md_sun", "rhsusf_acc_LEUPOLDMK4_2_mrds", "rhsusf_acc_premier_low", "rhsusf_acc_M8541_low", "rhsusf_acc_ACOG3", "rhsusf_acc_ACOG_USMC"];
        if (round(random 10) == 5) then { _newAI linkItem "ACE_NVG_Gen1"; };
        [_newAI, _rifle, 5] call BIS_fnc_addWeapon;
        _newAI addPrimaryWeaponItem _scope;
        { _newAI setSkill [_x, 1]; } forEach ["aimingAccuracy", "aimingSpeed", "spotTime", "courage", "aimingShake", "commanding", "spotDistance", "reloadSpeed"];
        [getPos _player, _sniperGrp] call { params ["_p", "_g"]; [_g, _p] call FN_setMoveWaypoint; };
        _newAI setUnitPos "MIDDLE";
        hint "Something feels off. Your instincts tell you to prepare for something...";
    };
    
    // RANDOMLY TELEPORTED (90 <= encounter < 95)
    if (_rndEncounter >= 90 && _rndEncounter < 95) then {
        hint "You feel a monstrous presence nearby. Your instincts tell you to prepare for something…";
        sleep 5;
        private _wandGrp = createGroup civilian;
        private _wanderer = _wandGrp createUnit ["C_man_p_beggar_F", getPos _player, [], 20, "NONE"];
        _wanderer allowDamage false;
        _PBright = 1; _PCon = 1; _PRGB = 1; _PColor = 0;
        _PBrightC = 0.5; _PConC = 0.6; _PR = 0.3; _PColorC = 0.01;
        while { (_PBright > _PBrightC) || (_PColor < _PColorC) || (_PCon > _PConC) || (_PRGB > _PR) } do {
            "ColorInversion" ppEffectAdjust [_PColor, _PColor, _PColor];
            "ColorInversion" ppEffectEnable true;
            "ColorInversion" ppEffectCommit 0;
            if (_PColor < _PColorC) then { _PColor = _PColor + 0.01; };
            "colorCorrections" ppEffectAdjust [_PBright, _PCon, 0, [0.95,0,0,0], [0.95,_PRGB,_PRGB,0.5], [0.95,_PRGB,_PRGB,1]];
            "colorCorrections" ppEffectEnable true;
            "colorCorrections" ppEffectCommit 0;
            if (_PBright > _PBrightC) then { _PBright = _PBright - 0.0125; };
            if (_PCon > _PConC) then { _PCon = _PCon - 0.00625; };
            if (_PRGB > _PR) then { _PRGB = _PRGB - 0.05; };
            sleep 0.001;
        };
        sleep 5;
        deleteVehicle _wanderer;
        deleteGroup _wandGrp;
        sleep 5;
        _player setPos ([getPos _player, _minDist+300, _maxDist+500, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos);
        "colorCorrections" ppEffectAdjust [1, 0.8, 0, [0,0,0,0], [0.80,0.75,0.75,0.4], [0.2,0.5,0.5,0]];
        "colorCorrections" ppEffectEnable true;
        "colorCorrections" ppEffectCommit 0;
        sleep 2;
        _wandGrp = createGroup east;
        [_wandGrp, _ZedsSlow, 20, getPos _player, 15] call (missionNamespace getVariable "FN_spawnZom");
    };
    
    // TONS OF ZOMBIES SPAWN AROUND THE PLAYER (95 <= encounter < 100)
    if (_rndEncounter >= 95 && _rndEncounter < 100) then {
        hint "The ground shakes with a horrid smell coming from underneath. Your instincts tell you to run...";
        [1] spawn BIS_fnc_earthquake;
        sleep 5;
        private _wandGrp = createGroup east;
        [_wandGrp, _ZedsRyan, 20, getPos _player, 15] call (missionNamespace getVariable "FN_spawnZom");
        hintSilent "";
    };
    
    // TONS OF PEOPLE SPAWN (100 <= encounter < 105)
    if (_rndEncounter >= 100 && _rndEncounter < 105) then {
        hint "You feel a monstrous presence nearby. Your instincts tell you to prepare for something...";
        sleep 5;
        _PBright = 1; _PCon = 1; _PRGB = 1; _PColor = 0;
        _PBrightC = 0.5; _PConC = 0.6; _PR = 0.3; _PColorC = 0.01;
        while { (_PBright > _PBrightC) || (_PColor < _PColorC) || (_PCon > _PConC) || (_PRGB > _PR) } do {
            "ColorInversion" ppEffectAdjust [_PColor, _PColor, _PColor];
            "ColorInversion" ppEffectEnable true;
            "ColorInversion" ppEffectCommit 0;
            if (_PColor < _PColorC) then { _PColor = _PColor + 0.01; };
            "colorCorrections" ppEffectAdjust [_PBright, _PCon, 0, [0.95,0,0,0], [0.95,_PRGB,_PRGB,0.5], [0.95,_PRGB,_PRGB,1]];
            "colorCorrections" ppEffectEnable true;
            "colorCorrections" ppEffectCommit 0;
            if (_PBright > _PBrightC) then { _PBright = _PBright - 0.0125; };
            if (_PCon > _PConC) then { _PCon = _PCon - 0.00625; };
            if (_PRGB > _PR) then { _PRGB = _PRGB - 0.05; };
            sleep 0.001;
        };
        private _wandGrp = createGroup civilian;
        for "_i" from 0 to 30 do {
            private _wanderer = _wandGrp createUnit ["C_man_p_beggar_F", getPos _player, [], 50, "NONE"];
            _wanderer allowDamage false;
            sleep 0.01;
        };
        sleep 3;
        { deleteVehicle _x; sleep 0.01; } forEach units _wandGrp;
        "colorCorrections" ppEffectAdjust [1, 0.8, 0, [0,0,0,0], [0.80,0.75,0.75,0.4], [0.2,0.5,0.5,0]];
        "colorCorrections" ppEffectEnable true;
        "colorCorrections" ppEffectCommit 0;
        hintSilent "";
    };
};