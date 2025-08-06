params ["_group", "_unitType", "_pos", "_faction", "_sfOverride", "_creepGroup"];

// Create the unit
private _unit = _group createUnit [_unitType, _pos, [], 1, "NONE"];

// Equip the unit (using execVM)
[_faction, _unit, false, false, _sfOverride] call (missionNamespace getVariable "FN_equipAI");

// Set unit skills (using the new setUnitSkills function)
private _unitSkillsArray = [_faction, _pos] call FN_getFactionSkills;
[_unit, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call FN_setUnitSkills;
[_unit, _faction] call FN_ambientChatter;


// Set unit position (crouching if required)
if (_creepGroup) then {
	_unit setUnitPos "MIDDLE";
};

// Return the created unit
_unit