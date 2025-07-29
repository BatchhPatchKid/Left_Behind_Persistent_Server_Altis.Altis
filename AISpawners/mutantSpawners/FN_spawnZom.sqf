params ["_zombieGrp", "_zombieArray", "_numZombie", "_pos", "_spread"];

for "_i" from 1 to _numZombie do {
	private _ZedType = selectRandomWeighted _zombieArray; 
	private _hordeUnit = _zombieGrp createUnit [_ZedType, [_pos, 5, _spread, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos, [], 20, "NONE"];
};

private _randomStuff = ["randomCommon"] call (missionNamespace getVariable "FN_arrayReturn");

[_randomStuff, _zombieGrp] spawn {
	params ["_randomStuff", "_zombieGrp"];
	sleep .5;
	{
		if (random 1 > .8) then {
			_x addItemToUniform (selectRandomWeighted _randomStuff);
		};
	} forEach (units _zombieGrp);
};