params ["_faction", "_buildingMain", "_pos"];
_newAI = "";

//For debugging purposes 
//_pos = getPos player;    
//_buildingMain = "CamoNet_OPFOR_open_F";    
//_faction = "ALF"; 

private _unitSkillsArray = [_faction, _pos] call (missionNamespace getVariable "FN_getFactionSkills");
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

[_pos, "Campfire_burning_F", 0, 1, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

_grpCamp = createGroup _side;  
_grpCamp setBehaviour "AWARE";

switch _faction do {
	case "RU": {
		[_pos, _buildingMain, 0, 1, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_01_line_5_green_F", -.41,-.91, -6.9, -3.5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_01_line_5_green_F", -.056, .998, -1.3, -4.6, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_01_line_5_green_F", -.795, .606, 3.7, -2, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagBunker_01_small_green_F", -.202, -.979, -.6, 4.6, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_01_line_5_green_F", .807, .59, 3.7, 3.3, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_01_line_5_green_F", -.9598, .28071, -3.4, 5.5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_01_line_5_green_F", -.271, -.962, -5.6, .2, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagBunker_01_small_green_F", .976, -.216, -5.7, 3.3, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_round_green_F", .936, -.352, -10.6, -.1, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_CampingTable_small_F", -.821, -.571, 2.9, 1.6, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 0, 1, .8, .5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Laptop_device_F", -.627, -.779, 2.8, 1.8, .85, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "RuggedTerminal_01_communications_F", .751, -.661, 1.1, -2.6, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", -.228, .974, -.4, 1.9, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", -.845, .531, -1.9, 1, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		
		[_pos, _unit, _grpCamp, "NONE", 0, 0, -9.5, -0.5, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 0.422, -0.906, -0.4, 1.9, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, 0, -1.9, 1, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, 0, 1.8, -1, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");

		if ((random 1) > .25) then { 
			_turretSelected = [_pos, "I_G_HMG_02_high_F", -.963, .266, -5.9, 3.4, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			
			
			_newAI_Turret = [_pos, _unit, _grpCamp, "NONE", 0, 0, 0, 0, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			_newAI_Turret moveInAny _turretSelected;
		} else {
			[_pos, _unit, _grpCamp, "NONE", -1, 0, -5.9, 3.4, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		};

		if ((random 1) > .25) then { 
			_turretSelected = [_pos, "I_G_HMG_02_high_F", -.202, .979, -.6, 4.5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			
			
			_newAI_Turret = [_pos, _unit, _grpCamp, "NONE", 0, 0, 0, 0, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			_newAI_Turret moveInAny _turretSelected;
		} else {
			[_pos, _unit, _grpCamp, "NONE", -1, 0, -0.6, 4.5, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		};
	};

	case "US": {
		[_pos, _buildingMain, .9997, -.024, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", -.855, -.518, -4.7, -3.9, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", .028, -1, .2, -5.7, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagBunker_Tower_F", -1, -.0013, 7.7, -3.3, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "CamoNet_BLUFOR_open_F", .055, .999, 6.6, 3, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", -.1515, -.99, 2.3, 5.9, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagBunker_Small_F", -.158, -.987, 7.2, 4.4, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", .527, -.85, -3.2, 4.8, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagBunker_Small_F", .984, -.176, -4.1, .5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Round_F", -.999, -.017, 3.9, .9, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", 1, 0, 12.3, 4, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", 0, 1, 11, 5.8, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "CamoNet_BLUFOR_open_F", .9997, -.024, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_PortableLight_double_F", -.707, -.707, 11.5, 5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 0, 1, 5.1, -4.5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_PortableLight_double_F", 0, 1, -2.5, -4.4, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_CampingTable_F", 0, 1, 1.8, -4.3, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "RuggedTerminal_01_communications_F", .0286, .999, -.2, -4.2, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Laptop_03_black_F", .447, -.895, 2.5, -4.4, 0.84, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_PortableServer_01_olive_F", -.028, -.999, 1.3, -4.3, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_SolarPanel_04_olive_F", .759, .651, 5, -4.5, 2.8, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Router_01_olive_F", -.247, -.969, 2.1, -4.4, .85, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_MultiScreenComputer_01_closed_olive_F", -.645, -.764, 1.3, -4.3, .85, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", -.752, -.66, -1.8, -1.4, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", -.068, -.998, -.1, -2.1, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", .999, -.018, 7.2, -4.4, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", .999, -.018, 9.7, -4.3, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "NONE", 0, 0, 11.3, 3.8, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");

		if ((random 1) > .65) then { 
			_turretSelected = [_pos, "I_G_HMG_02_high_F", 0, 1, 7.3, 4.3, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			
			_newAI_Turret = [_pos, _unit, _grpCamp, "NONE", 0, 0, 0, 0, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			_newAI_Turret moveInAny _turretSelected;
		} else {
			[_pos, _unit, _grpCamp, "NONE", -1, 0, 7.3, 4.3, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		};

		[_pos, _unit, _grpCamp, "NONE", 0, 0, 2.8, 1.1, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");

		if ((random 1) > .65) then { 
			_turretSelected = [_pos, "I_G_HMG_02_high_F", -1, 0, -4.1, 0.6, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			
			
			_newAI_Turret = [_pos, _unit, _grpCamp, "NONE", 0, 0, 0, 0, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			_newAI_Turret moveInAny _turretSelected;
		} else {
			[_pos, _unit, _grpCamp, "NONE", -1, 0, -4.1, 0.6, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		};

		[_pos, _unit, _grpCamp, "NONE", 0, 0, -1.7, -1.3, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 0, 0, -0.1, -2, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, 0, 1.9, -3.1, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, 1, 7.2, -4.3, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, 0, 9.6, -4.3, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, 0, 5.1, -2.5, 2.8, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, 0, 6.6, -4.6, 2.8, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");

		if ((random 1) > .65) then { 
			_turretSelected = [_pos, "I_G_HMG_02_high_F", 1, 0, 9, -3.4, 2.8, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			
			
			_newAI_Turret = [_pos, _unit, _grpCamp, "NONE", 0, 0, 0, 0, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			_newAI_Turret moveInAny _turretSelected;
		} else {
			[_pos, _unit, _grpCamp, "NONE", -1, 0, 9, -3.4, 2.8, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		};
	};
	case "BB": {
		_mainBuildingObject = createVehicle [_buildingMain, [0, 0, 0], [], 0, "CAN_COLLIDE"];    
		_mainBuildingObject allowDamage false;    
		_mainBuildingObject setVectorDirAndUp [[0,1,0], (vectorUp _mainBuildingObject)];    
		_mainBuildingObject setPosATL [_pos select 0, _pos select 1, 0]; 
		
		if ((random 1) > .5) then {
			[_pos, "Land_CampingTable_F", .9917, .129, -2.8, -.4, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			[_pos, "Land_Laptop_device_F", -.9394, -.3428, -2.9, .1, 0.85, .25] call (missionNamespace getVariable "FN_createObject_Fortifications");
		};
		[_pos, "Land_CampingChair_V2_F", -.55, .835, -3.7, .3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 0, 1, -.3, -1, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Portable_generator_F", .9882, .1531, -2, -.7, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "SatelliteAntenna_01_Black_F", -.9335, .3586, -3, 1.4, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_TentA_F", -.264, .9649, -.7, 2.4, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_TentA_F", .8583, .5131, 2.2, 1.3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_3_F", -.3884, .9215, -3.1, 3.9, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_3_F", -.9216, .276, -5.6, 1.4, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_3_F", .7612, .6486, -5, -2.1, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_3_F", 0, 1, -1.8, -3.6, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", -.2571, .9664, 1.4, -3.7, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", -.681, .7323, 3.7, -2.3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", .4278, .904, -.3, 5.2, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", .007, 1, 2.5, 4.6, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Round_F", -.721, -.693, 4.3, 3.4, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Round_F", -.984, .176, 5.2, -.3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "NONE", -.721, .693, 3.3, 3.4, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -.984, -.176, 4.2, -0.3, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -.984, -.176, 1, -2.8, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -.984, -.176, 1.4, 3.7, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", -.984, -.176, 1.2, -0.6, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", .874, -.486, -1.7, 0.5, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
	case "RC": {
		[_pos, _buildingMain, 0, 1, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "CROUCH", 0, 1, 0, -1.7, 0, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 1, 1, -1.5, -1.5, 0, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, -1, 0, 1.6, 0, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");

		[_pos, "Land_Camping_Light_F", 0, 1, 4, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_TentDome_F", -.5, 1, 4, 2.5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_TentDome_F", .5, 1, 4, -2.3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_CampingTable_F", .75, 1, -5, -3.3, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_CampingChair_V2_F", -.75, 1, -4.4, -2.5, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "NONE", 1, 1, -5.265, -4.60, 0, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");

		[_pos, "Land_Camping_Light_F", .75, 1, -5, -3.3, 2, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_WoodPile_F", .75, 1, -4.4, 3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_WoodenLog_F", 0, 1, -4, 2.5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_long_green_F", 0, 1, 4, 4.5, -.1, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_long_green_F", .75, 1, 6.65, 3.5, -.1, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_long_green_F", 1, 0, 7.9, 1.2, -.1, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_long_green_F", 1, -0.2, 7.6, -1.7, -.1, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "NONE", 1, 1, 6.75, -2.5, 0, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 1, 1, 6.6, 2.35, 0, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");

		if (random 1 > .5) then {
			[_pos, "Land_BagFence_01_long_green_F", .8, -1, 6.25, -4, -.1, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			[_pos, "Land_BagFence_01_long_green_F", 0, .8, 3.75, -4.9, -.1, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		};
	};
	case "ALF": {
		[_pos, _buildingMain, 0, 1, 0, 0, 0.15, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 1, 0, 1.1, 0.9, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", .877, -.48, -5.9, 2.3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_BagBunker_Small_F", .95, .31, -3.9, -1.8, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		if (random 1 > .65) then {
			_turretSelected = [_pos, "I_G_HMG_02_high_F", -.95, -.31, -3.9, -1.8, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			_newAI_Turret = [_pos, _unit, _grpCamp, "NONE", 0, 0, 0, 0, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			_newAI_Turret moveInAny _turretSelected;
		} else {
			[_pos, _unit, _grpCamp, "NONE", .95, -.31, -3.9, -1.8, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		};
		
		[_pos, "Land_BagFence_Long_F", .188, .982, -1.1, -3.6, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", .0898, -.996, 1.6, -3.8, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_BagBunker_Small_F", -.893, .45, 4.8, -2.2, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		if (random 1 > .65) then {
			_turretSelected = [_pos, "I_G_HMG_02_high_F", .893, -.45, 4.8, -2.2, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			_newAI_Turret = [_pos, _unit, _grpCamp, "NONE", 0, 0, 0, 0, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			_newAI_Turret moveInAny _turretSelected;
		} else {
			[_pos, _unit, _grpCamp, "NONE", -.893, -.45, 4.8, -2.2, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		};
		
		[_pos, "Land_HBarrier_5_F", -.924, -.383, 6.1, 2.1, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", -.135, -.991, -1.2, 4.5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Round_F", -.068, -.998, 3.2, 6.4, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", .149, .989, .2, 2.2, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", -.86, .511, -2.1, 1.1, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", -.169, -.986, -.3, -2, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_WoodPile_F", .358, -.934, 4.9, 1.1, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_WoodenLog_F", 0, 1, 4.5, .3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_Sink_F", .881, -.473, -4.1, 2.8, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "NONE", .149, -.989, .2, 2.2, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", .86, -.511, -2.1, 1.1, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", -.169, .986, -.3, -2, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -.068, .998, 3.2, 5.4, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", .0898, -.996, 1.6, -2.6, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
	case "PMC": {
		[_pos, _buildingMain, 1, 0, 0, 0, 0.15, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 1, 0, -2, -2, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_BagBunker_01_small_green_F", 1, 0, -2.5, -3, 0, .25] call (missionNamespace getVariable "FN_createObject_Fortifications");

		if (random 1 > .65) then {
			_turretSelected = [_pos, "I_G_HMG_02_high_F", -1, 0, -2.5, -2.85, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			_newAI_Turret = [_pos, _unit, _grpCamp, "NONE", 0, 0, 0, 0, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			_newAI_Turret moveInAny _turretSelected;
		} else {
			[_pos, _unit, _grpCamp, "NONE", -1, 0, -2.5, -2.85, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		};
	
		[_pos, "Land_HBarrier_01_line_5_green_F", 1, 0, -3.95, 2, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_01_line_3_green_F", 0, 1, -1.55, 5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_round_green_F", -.75, -1, 1.35, 5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_long_green_F", 1, 0, 2.15, 2.5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_long_green_F", 1, 0, 2.15, 0, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_long_green_F", 0, 1, 0, -5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_corner_green_F", 1, 0, 2, -4.60, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", -1, 1, -1.5, 1.5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", 0, 1, 0, 2.5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "RuggedTerminal_01_communications_F", 0, 1, -2.45, -0.25, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Fridge_01_closed_F", 0, 1, -2.65, 4.25, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_PortableServer_01_olive_F", 0.25, -1, 0.55, -4.25, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		if (random 1 > .5) then {
			[_pos, "Land_CampingTable_small_F", 0, 1, 1.5, -4.35, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			[_pos, "Land_Laptop_03_olive_F", 0.25, -1, 1.65, -4.5, 1.25, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
			[_pos, "Head_Brain", 0.75, -1, 1.35, -4.25, .85, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		};
		
		[_pos, _unit, _grpCamp, "CROUCH", 1, -1, -2.15, 1.85, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 0, -1, 0, 2.5, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, -1, 1, 4.5, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, -1, 1.25, -.5, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
	case "Bandit": {
		[_pos, _buildingMain, 1, 0, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 1, 0, -2, -2, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_TentA_F", 1, 0, 2, 0, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_TentA_F", 0.5, -1, 1, -2.5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_TentA_F", 0.5, 1, 1, 2.5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		if ((random 1) > .5) then {
			[_pos, "Land_WoodPile_F", 1, 0.5, -3, 6, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			[_pos, "Land_WoodenLog_F", 0, 1, -2.75, 5.5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		};

		[_pos, "Land_Mound01_8m_F", 0.5, 1, 1, 7, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Mound01_8m_F", -0.15, 1, -1, -5.5, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "CROUCH", 1, 1, -2, 0, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 0, -1, -1.5, 1.5, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 0, 1, -1.5, -1.5, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0.75, 1, -2, 5.5, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0.75, 1, -3, -5, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
	case "WO": {
		[_pos, _buildingMain, 1, 0, 0, 1, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 1, 0, -2, -2, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", 1, 0, 3, 0, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", 1, .8, 2, 2, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", 1, -.8, 2, -2, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", 1, .5, 5, 4, -0.15, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", 1, -.5, -5, 4, -0.15, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", 1, -.5, 5, -1.75, -0.15, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", 1, .5, -5, -1.75, -0.15, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", 0, -1, 1.75, 6, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Short_F", 0, 1, -2.25, 6, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", 0, -1, 1.75, -3.75, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Short_F", 0, 1, -2.25, -3.75, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "impaled_body", 0, 1, 0, -7, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "impaled_body", 0, -1, 0, 10, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "OmniDirectionalAntenna_01_black_F", 0, -1, 4.5, 1.5, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		if ((random 1) > .5) then { 
			[_pos, "Land_CampingTable_small_F", 0, -1, 3.25, 5.5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			[_pos, "Land_MultiScreenComputer_01_black_F", 0.25, 1, 3, 5.25, 1, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		};

		[_pos, _unit, _grpCamp, "CROUCH", 0, -1, 0, 2, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 0, 1, 0, -2.2, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -1, 0, 2, 0, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, -1, 1.75, -2.75, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 1, 0, -2.25, -2.75, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, -1, -2.25, 5, 0, .35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
	case "PF": {
		[_pos, _buildingMain, 0, 1, 1, -1, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 1, 0, -2, -2, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "corpse_mass", 0, 1, 0, 0, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Round_F", 1, 1, -3, -3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Cargo10_brick_red_F", 0, 1, 2, 2.2, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", 0, 1, -1, 2.2, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Round_F", 1, -0.75, -3.5, 1.3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", 1, 0, 3.5, -0.65, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Round_F", -1, 0.75, 3, -3, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "impaled_skeleton", 1, -0.75, -3.5, 0.15, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "impaled_skeleton", -1, 0.75, 3, -2, 0, .5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "NONE", -1, 0, 2.4, -2.4, 0, .25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -1, 0, -2.4, -2.4, 0, .25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -1, 0, -2.9, 1.5, 0, .25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 1, 0, -0.5, 1.5, 0, .25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 0, 1, -0, -2, 0, .25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
	case "ROA": {
		[_pos, _buildingMain, 0, 1, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 1, 0, -0.75, -0.75, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

		if ((random 1) > .25) then { 
			[_pos, "Land_BagBunker_01_small_green_F", -1, 0.5, 4, -1.5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			if (random 1 > .65) then { 
				_turretSelected = [_pos, "I_G_HMG_02_high_F", 1, 0, 4, -1.5, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
				
				_newAI_Turret = [_pos, _unit, _grpCamp, "NONE", 0, 0, 4, -1.5, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
				_newAI_Turret moveInAny _turretSelected;
			} else {
				[_pos, _unit, _grpCamp, "NONE", 1, 0, 4, -1.5, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			};
		} else {
			[_pos, _unit, _grpCamp, "NONE", 1, 0, 4, -1.5, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		};

		[_pos, "Land_BagFence_01_long_green_F", 0, 1, 1, -3, 0, 0.25] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_long_green_F", 0, 1, -2, -3, 0, 0.25] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_long_green_F", 1, 1, -4.65, -2, 0, 0.25] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "CROUCH", -1, 0, 2, 0, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 1, -0.5, -1.8, 1, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 1, -0.5, -4.85, -1, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 1, 0, -1.85, -1.5, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
	case "TRB": {
		[_pos, _buildingMain, 0, 1, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 1, 0, -0.75, -0.75, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", 0, 1, 0, 4, -0.15, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", 1, 1, 5.3, 2.5, -0.15, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", -1, 1, 5.3, -2.5, -0.15, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_HBarrier_5_F", 0, 1, 0, -4, -0.15, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", 1, 0, 3, 0, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", 1, .8, 2, 2, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Sleeping_bag_F", 1, -.8, 2, -2, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Long_F", 1, 0, -6, 0, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Round_F", 1, -1, -5.3, 2.6, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_Round_F", 1, 1, -5.3, -2.6, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		if ((random 1) > .85) then { 
			_turretSelected = [_pos, "I_G_HMG_02_high_F", -1, 0, -4, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
			
			_newAI_Turret = [_pos, _unit, _grpCamp, "NONE", 0, 0, 0, 0, 0, 0, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			_newAI_Turret moveInAny _turretSelected;
		} else {
			[_pos, _unit, _grpCamp, "NONE", -1, 0, -4.5, 2.3, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
			[_pos, _unit, _grpCamp, "NONE", -1, 0, -4.5, -2.3, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		};

		[_pos, _unit, _grpCamp, "CROUCH", -1, 0, 3, 0, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", -1, -1, 2, 2, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", -1, 1, 2, -2, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
	case "NH": {
		[_pos, _buildingMain, 0, 1, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 1, 0, -0.75, -0.75, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "rvg_dome_tent_gry", 0.15, 1, 5, 0, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "rvg_dome_tent_gry", -1, 1, 4, 3.5, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "rvg_dome_tent_gry", 1, 1, 4, -3.5, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_Shoot_House_Wall_Long_Crouch_F", -1, -1, 5, 5.3, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Shoot_House_Wall_Long_Crouch_F", -1, 0, 6.4, 2, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_Shoot_House_Wall_Long_Crouch_F", -1, 1, 5, -5.3, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Shoot_House_Wall_Long_Crouch_F", -1, 0, 6.4, -2, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_WoodenBox_F", 0.75, 1, 3.8, 5.8, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 0.75, 1, 3.8, 5.8, 1, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_PaperBox_closed_F", 1, 1, 3.1, -6, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_BagFence_01_round_green_F", 1, 0.5, -6, -2.5, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_BagFence_01_round_green_F", 1, -0.5, -6, 2.5, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "CROUCH", 0, -1, 0, 2, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 0, 1, 0, -2.2, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -1, 0, 2, 0, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, 1, 3.1, 5.1, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, 1, -5, -2.4, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 0, 1, -5, 2.4, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
	case "DT": {
		[_pos, _buildingMain, 0, 1, -1, 2, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, _buildingMain, 0, 1, -1, -2, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 1, 0, 0.75, 0.75, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_TentA_F", 1, 0, 3, 0, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_TentA_F", 1, 1, 2, 3, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_TentA_F", 1, -1, 2, -3, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_TablePlastic_01_F", 1, 0, -2.8, 0, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 1, 0, -2.95, 0, 2, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_CampingChair_V2_F", -0.9, 1, -3, 1.6, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "NONE", 0, 0.5, -2.5, -2, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", 1, 1, -2, 0, 0, 0.25, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");

		[_pos, "Land_Mound01_8m_F", 1, 0.15, -6, 1, 0, 0.45] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Mound01_8m_F", 0.15, 1, -1, 6, 0, 0.45] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "CROUCH", 0, -0.5, 0.25, 3, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", -1, -0.4, 2.3, 1.5, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -1, 0.2, 2.8, -1.5, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 0, 0.5, 0.25, -3, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
	default { // default is survivors union
		[_pos, _buildingMain, 0, 1, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 0, 1, -1, -1, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_Mound01_8m_F", 0.032, -0.99949, 1.9, -4.4, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Mound01_8m_F", 0.0494, -0.999, -0.2, 3.4, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "rvg_dome_tent_gry", -0.88, 0.475, 4.6, 1.1, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "rvg_dome_tent_gry", -0.864, 0.503, 1.3, 2.2, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "rvg_dome_tent_gry", 0.827, 0.562, 4.3, -2, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "rvg_dome_tent_gry", 0.923, 0.3845, 1.1, -2.2, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_WoodenTable_02_large_F", -0.218, -0.976, -5.3, -1.2, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Camping_Light_F", 0, 1, -5.9, -2.2, 0.98, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_Map_altis_F", 0.467, 0.884, -5, -0.4, 0.99, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, "Land_Sink_F", 0.117, 0.992, -1.7, 2.1, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_WoodPile_F", -0.645, -0.764, -4.6, 1.6, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
		[_pos, "Land_WoodenLog_F", 0, 1, -3.4, 1.8, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");

		[_pos, _unit, _grpCamp, "NONE", -0.218, -0.976, -4, -1.2, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -0.218, 0.976, -1, -2.5, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "NONE", -0.88, 0.475, 6, -0.5, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 1, 0, -2, 0, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
		[_pos, _unit, _grpCamp, "CROUCH", 0, -1, 0, 1.35, 0, 0.35, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
	};
};