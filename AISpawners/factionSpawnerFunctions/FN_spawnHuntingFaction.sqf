params ["_pos", "_faction"];
private _posHuntingParty = [_pos, 100, 500, 250] call FN_findSafePosition;
private _numOfHuntingParty = selectRandom  [2, 3, 5];

private _mutantArray = ["mutantArray"] call (missionNamespace getVariable "FN_arrayReturn");
private _factionArray = ["wanderFactionWeights"] call (missionNamespace getVariable "FN_arrayReturn");
private _factionSelected = _factionArray call BIS_fnc_selectRandomWeighted;

private _unitSkillsArray = [_factionSelected, _pos] call FN_getFactionSkills;
private _side = _unitSkillsArray select 0;
private _unit = _unitSkillsArray select 1;

if (_faction == "" && _side != west) then {
	_side = independent;
    _unit = "I_G_Survivor_F";
} else {
	if ((_side == independent)  && !(_faction in _mutantArray) && (_faction != "RU")) then {
		_side = east;
		_unit = "O_G_Survivor_F";
	};
};

_meleeChance = [_factionSelected] call (missionNamespace getVariable "FN_meleeChance");

_aim = _unitSkillsArray select 2;
_aimSpeed = _unitSkillsArray select 3;
_spot = _unitSkillsArray select 4;
_courage = _unitSkillsArray select 5;
_aimShake = _unitSkillsArray select 6;
_command = _unitSkillsArray select 7;
_spotDist = _unitSkillsArray select 8;
_reload = _unitSkillsArray select 9;

_sfOverride = false;
if (random (_unitSkillsArray select 10) < 1) then { _sfOverride = true; };

private _grp = createGroup _side;

if (random 1 > _meleeChance) then {
	for "_i" from 1 to _numOfHuntingParty do {
		private _newAI = _grp createUnit [_unit, _posHuntingParty, [], 0, "FORM"];
		[_factionSelected, _newAI, false, false, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
		[_newAI, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload] call (missionNamespace getVariable "FN_setUnitSkills");	
	};
} else {			
	for "_i" from 1 to _numOfHuntingParty do {
		grpTemp = createGroup east;
		private _newAI = grpTemp createUnit ["O_soldier_Melee_RUSH", _posHuntingParty, [], 1, "NONE"];
		[_factionSelected, _newAI, true, false, false] call (missionNamespace getVariable "FN_equipAI");
		[_newAI] joinSilent _grp;
		[_newAI, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload] call (missionNamespace getVariable "FN_setUnitSkills");		
	};
};

[_grp, _pos, 50] call FN_createWaypoints;
[_grp, [], []] call (missionNamespace getVariable 'FN_enableDynamicSim');