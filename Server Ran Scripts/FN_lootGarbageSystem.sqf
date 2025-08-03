[] spawn {
    if (!hasInterface) exitWith {};

    private _classesToScan = ["garbage", "garbagewashingmachine_f", "garbagebags_f"];

    while { true } do {
        // 1) Gather nearby terrain clutter within 2 meters
        private _objs = nearestTerrainObjects [player, [], 2];

        // 2) Filter & attach actions inline
        {
            private _fullPath = (getModelInfo _x) select 0;
            private _class = _fullPath splitString "." select 0;

            if (_class in _classesToScan && !(_x getVariable ["garbageActionAdded", false])) then {
                _x setVariable ["garbageActionAdded", true];
                _x addAction [
                    "Search the garbage pile",
                    {
                        params ["_target", "", "_actionId", ""];
                        private _pos = getPosWorld _target;
                        [_pos] remoteExec ["FN_spawnLootCrate", 2];
                        _target removeAction _actionId;
                    }
                ];
            };
        } forEach _objs;

        sleep 5;
    };
};