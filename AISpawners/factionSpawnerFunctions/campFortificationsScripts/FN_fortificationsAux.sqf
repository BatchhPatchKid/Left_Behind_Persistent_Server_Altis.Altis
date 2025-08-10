params ["_faction", "_pos", "_buildingMain", "_addCamps"];

//For debugging purposes 
//_pos = getPos player;    
//_buildingMain = "CamoNet_OPFOR_open_F";    
//_faction = "ALF"; 

_campPos = [_pos, 15, 100, 10, 0, 20, 0,[],[]] call BIS_fnc_findSafePos; 

if (_side != WEST) then {
	switch (_faction) do {
		case "US": { [_campPos, 2] call (missionNamespace getVariable "FN_lootSpawner"); }; 
		case "RU": { [_campPos, 2] call (missionNamespace getVariable "FN_lootSpawner"); };
		case "TRB": { [_campPos, 1] call (missionNamespace getVariable "FN_lootSpawner"); };
		case "PMC": { [_campPos, 1] call (missionNamespace getVariable "FN_lootSpawner"); };
		case "ROA": { [_campPos, 1] call (missionNamespace getVariable "FN_lootSpawner"); };
		case "ALF": { [_campPos, 1] call (missionNamespace getVariable "FN_lootSpawner"); };
		default { [_campPos, 0] call (missionNamespace getVariable "FN_lootSpawner"); };
	};
};

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

//For debugging purposes
//_probAdd = 10;

_grpCamp = createGroup _side;  
_grpCamp setBehaviour "AWARE";

[_campPos, _unit, _grpCamp, "NONE", 1, 1, -1.3, -2.1, -3.19, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
[_campPos, _unit, _grpCamp, "NONE", 1, 1, 1.3, -1.6, -3.19, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
[_campPos, _unit, _grpCamp, "NONE", 1, 1, 1.7, 1, -3.19, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
[_campPos, _unit, _grpCamp, "NONE", 1, 1, -1.3, 2.2, -3.19, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
[_campPos, _unit, _grpCamp, "NONE", 1, 1, -1.8, 0.9, -3.19, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");
[_campPos, _unit, _grpCamp, "NONE", 1, 1, -2, -1.2, -3.19, 0.5, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _side, _sfOverride] call (missionNamespace getVariable "FN_spawnAI_Fortifications");

[_campPos, "Campfire_burning_F", 0, 1, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

[_campPos, _buildingMain, 0, 1, 0, 0, 0, 0] call (missionNamespace getVariable "FN_createObject_Fortifications");

[_campPos, "Land_TentDome_F", 0.922161, 0.386806, 1.6, -3.8, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
[_campPos, "Land_TentDome_F", 0.308053, 0.951369, 3.8, -1.3, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
[_campPos, "Land_TentDome_F", 0.800595, -0.599207, -2.2, -3.3, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
[_campPos, "Land_TentDome_F", -0.570092, 0.821581, 3.8, 2.3, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
[_campPos, "Land_TentDome_F", 0.0682202, -0.99767, -3.8, 0, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
[_campPos, "Land_TentDome_F", -0.81976, -0.572708, -2.4, 3.1, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");
[_campPos, "Land_TentDome_F", -0.970117, 0.242637, 1, 4.3, 0, 0.5] call (missionNamespace getVariable "FN_createObject_Fortifications");