[] spawn {
    if !hasInterface exitWith {};
    waitUntil { !isNil { uiNamespace getVariable ["ace_interact_menu_fnc_addActionToObject", nil] } };

    private _classesToScan = ["garbage","garbagewashingmachine_f","garbagebags_f"];

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
        // 1) Gather nearby terrain clutter
        private _objs = nearestTerrainObjects [player, [], 5];

        // 2) Filter & attach actions inline
        {
            private _fullPath = (getModelInfo _x) select 0;
            private _class = _fullPath splitString "." select 0;

            if (_class in _classesToScan) then {
                [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
                hintSilent format ["Found garbage pile: %1", _class];
            };
        } forEach _objs;

        sleep 5;
    };
};