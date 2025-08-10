params ["_zombieGrp", "_zombieArray", "_numZombie", "_pos", "_spread", "_spawnSleep"];

if (isNil "_spawnSleep") then {
	_spawnSleep = 0.5;
};

[_zombieGrp, _zombieArray, _numZombie, _pos, _spread, _spawnSleep] spawn {
	params ["_zombieGrp", "_zombieArray", "_numZombie", "_pos", "_spread", "_spawnSleep"];

	private _arrayReturn = LB_fnc_arrayReturn;

	private _randomStuff = ["randomCommon"] call _arrayReturn;
	private _backpackArraySelection = ["backpackCommon"] call _arrayReturn;
	private _vestArraySelection = ["vestCommon"] call _arrayReturn;
	private _uniformArraySelection = ["uniformCommon"] call _arrayReturn;

	// before the loop: collect all interior points around _pos
	private _buildings    = nearestObjects [_pos, ["House","Land_Building"], _spread];
	private _insidePoints = [];

	if (count _buildings > 0) then {
		{
			private _pts = [_x] call BIS_fnc_buildingPositions;
			// concatenate any points found
			_insidePoints = _insidePoints + _pts;
			sleep 0.1;
		} forEach _buildings;
	};

	// now spawn your zombies
	for "_i" from 1 to _numZombie do {
		private _ZedType = selectRandomWeighted _zombieArray;
		
		// pick spawn position: inside if possible, otherwise safe
		private _spawnPos = [];
		if (count _insidePoints > 0) then {
			_spawnPos = selectRandom _insidePoints;
		} else {
			_spawnPos = [_pos, 15, _spread, 150] call FN_findSafePosition;
		};
		
		private _hordeUnit = _zombieGrp createUnit [_ZedType,_spawnPos,[],20,"NONE"];

		private _bpObj = unitBackpack _hordeUnit;
		private _vestObj = vest _hordeUnit;

		if (isNull _bpObj && random 1 > .5) then {
			_hordeUnit addBackpack (selectRandomWeighted _backpackArraySelection);

			if (random 1 > .25) then {
				_hordeUnit addItemToBackpack (selectRandomWeighted _randomStuff);
			};
		};

		if (_vestObj == "" && random 1 > .75) then {
			_hordeUnit addVest (selectRandomWeighted _vestArraySelection);

			if (random 1 > .25) then {
				_hordeUnit addItemToVest (selectRandomWeighted _randomStuff);
			};
		};

		if (random 1 > .75) then {
			_hordeUnit addItemToUniform (selectRandomWeighted _uniformArraySelection);
		};

		sleep _spawnSleep;
	};

	[_zombieGrp, [], []] call (missionNamespace getVariable 'FN_enableDynamicSim');
};