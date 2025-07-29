params ["_unit", "_aim", "_aimSpeed", "_spot", "_courage", "_aimShake", "_command", "_spotDist", "_reload"];

// Set unit skills
_unit setSkill ["aimingAccuracy", _aim];
_unit setSkill ["aimingShake", _aimShake];
_unit setSkill ["aimingSpeed", _aimSpeed];
_unit setSkill ["spotDistance", _spotDist];
_unit setSkill ["spotTime", _spot];
_unit setSkill ["courage", _courage];
_unit setSkill ["commanding", _command];
_unit setSkill ["reloadSpeed", _reload];