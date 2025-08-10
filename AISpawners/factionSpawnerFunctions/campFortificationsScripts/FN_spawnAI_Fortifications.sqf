params ["_pos", "_unit", "_grpCamp", "_ANIM", "_xDir", "_yDir", "_xDis", "_yDis", "_zDis", "_prob", "_aim", "_aimSpeed", "_spot", "_courage", "_aimShake", "_command", "_spotDist", "_reload", "_side", "_sfOverride"];
private _newAI = "";
if (random 1 > _prob) then {
    _newAI = _grpCamp createUnit [_unit, _pos, [], 1, "NONE"];
    [_faction, _newAI, false, false, _sfOverride]  call (missionNamespace getVariable "FN_equipAI");
    // Call the setUnitSkills function (already compiled in missionNamespace under FN_setUnitSkills)
    [_newAI, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload] call (missionNamespace getVariable "FN_setUnitSkills");
    _newAI setVectorDirAndUp [[_xDir, _yDir, 0], (vectorUp _newAI)];
    _newAI setPosATL [(_pos select 0) + _xDis, (_pos select 1) + _yDis, _zDis];
    if (_ANIM == "CROUCH") then {
        _newAI setUnitPos "MIDDLE";
    };
    _newAI disableAI "PATH";
    if (_side == WEST && (random 1) > 0.70) then {
        [_newAI] execVM "Economy System\economySystem.sqf";
    };
};
_newAI