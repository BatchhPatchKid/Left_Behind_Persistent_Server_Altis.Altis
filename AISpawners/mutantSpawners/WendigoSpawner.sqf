params ["_pos", "_triggerRadius", "_maxUnits"];
	
	[_pos, _triggerRadius, _maxUnits] spawn {
        params ["_pos", "_triggerRadius", "_maxUnits"];
	
	[_pos, 1] call (missionNamespace getVariable "FN_lootSpawner");
	private _horde = createGroup east;
	
	for "_i" from 1 to _maxUnits do {
		hordeUnit = _horde createUnit ["DSA_Wendigo", [_pos, 10, (_triggerRadius-50), 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos, [], 1, "NONE"];
		_hordeUnit setSpeaker "NoVoice"
		_hordeUnit disableConversation true;
	};
	[_horde, [], []] call (missionNamespace getVariable 'FN_enableDynamicSim');
};