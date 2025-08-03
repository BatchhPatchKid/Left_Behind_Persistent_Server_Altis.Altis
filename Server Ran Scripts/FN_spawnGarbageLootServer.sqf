[] spawn {
    private _classesToScan = [
        "Land_GarbageBags_F",
        "Land_GarbageBarrel_01_english_F",
        "Land_GarbageBarrel_01_F",
        "Land_GarbagePallet_F",
        "Land_GarbageWashingMachine_F",
        "Land_GarbageHeap_01_F",
        "Land_GarbageHeap_02_F",
        "Land_GarbageHeap_03_F",
        "Land_GarbageHeap_04_F",
        "Land_OfficeCabinet_01_F"
    ];

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
        private _allObjs = allMissionObjects "all";
        private _targets = _allObjs select { typeOf _x in _classesToScan };

        {
            hintSilent format ["Found garbage pile: %1", _x];
            [_x, 0, ["ACE_Actions"], _action] call ace_interact_menu_fnc_addActionToObject;
        } forEach _targets;

        sleep 1800;  // wait 30 minutes before re-scanning
    };
};