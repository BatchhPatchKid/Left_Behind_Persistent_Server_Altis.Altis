[] spawn {
	if !hasInterface exitWith {};
    waitUntil { !isNil { uiNamespace getVariable ["ace_interact_menu_fnc_addActionToObject", nil] } };

    private _classesToScan = ["Land_GarbageBags_F","Land_GarbageBarrel_01_english_F","Land_GarbageBarrel_01_F","Land_GarbagePallet_F","Land_GarbageWashingMachine_F","Land_GarbageHeap_01_F","Land_GarbageHeap_02_F","Land_GarbageHeap_03_F","Land_GarbageHeap_04_F","Land_OfficeCabinet_01_F"];

    private _action = [
        "searchGarbage",
        "Search the garbage pile",
        "",
        {
            params ["_target","_player","_params"];
            hint format ["%1 searched by %2", _target, name _player];
        },
        { true }
    ] call ace_interact_menu_fnc_createAction;

    while { true } do {
        private _targets = [];
		private _objs = nearestObjects [middleOfMap, [], 10000];
		
		{
			private _obj = _x;
			{
				if (_obj isKindOf _x) then {
					_targets pushBackUnique _obj;
				};
			} forEach _classesToScan;
		} forEach _objs;

		hint format ["Found %1 garbage piles | All mission objects found: %2", count _targets, count _objs];

        {
            [_x, 0, ["ACE_Actions"], _action] call ace_interact_menu_fnc_addActionToObject;
        } forEach _targets;

        sleep 5;
    };
};