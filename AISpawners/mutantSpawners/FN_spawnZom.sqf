params ["_zombieGrp", "_zombieArray", "_numZombie", "_pos", "_spread"];

for "_i" from 1 to _numZombie do {
	private _ZedType = selectRandomWeighted _zombieArray; 
	private _hordeUnit = _zombieGrp createUnit [_ZedType, [_pos, 15, _spread, 150] call FN_findSafePosition, [], 20, "NONE"];
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
	[_zombieGrp, [], []] call (missionNamespace getVariable 'FN_enableDynamicSim');
};