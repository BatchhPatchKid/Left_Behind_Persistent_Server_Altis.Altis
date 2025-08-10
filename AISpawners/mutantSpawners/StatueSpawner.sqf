params ["_pos", "_triggerRadius", "_maxUnits"];

playSound3D [getMissionPath "sounds\blowout_siren_2.ogg", player, false, _pos, 5, 1, 0];
[4] spawn BIS_fnc_earthquake;

[_pos, _triggerRadius, _maxUnits] spawn {
	params ["_pos", "_triggerRadius", "_maxUnits"];
	[_pos, 2] call (LB_fnc_lootSpawner);

	private _horde = createGroup east;
	for "_i" from 1 to _maxUnits do {
		private _hordeUnit = _horde createUnit ["DSA_ActiveIdol", [_pos, 10, (_triggerRadius / 4), 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos, [], 1, "NONE"];
		sleep 0.01;
	};
	[_horde, [], []] call (missionNamespace getVariable 'FN_enableDynamicSim');
};
