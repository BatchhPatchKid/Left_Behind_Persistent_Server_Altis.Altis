params ["_pos", "_triggerRadius"];

[_pos, _triggerRadius] spawn {
    params ["_pos", "_triggerRadius"];

    //–– Configuration ––
    private _vehArray         = ["defaultVeh"] call (missionNamespace getVariable "FN_arrayReturn");
    private _emptyVehArray    = ["emptyVeh"] call (missionNamespace getVariable "FN_arrayReturn");
    private _collisionClasses = ["car"];
    private _safeParams       = [_pos, 15, 200, 2, 0, 20, 0, [], []];
    private _maxAttempts      = 20;
    private _spawnRadius = _triggerRadius * 0.5;

    //–– Precompute spawn counts ––
    private _spawnCountVeh   = round(random [1,2,3]);
    private _spawnCountEmpty = round(random [6,12,18]);

    //–– Helper: find a valid road‐side position ––
    private _findSpawnPos = {
        params ["_pos", "_spawnRadius", "_safeParams", "_collisionClasses"];
        private _attempt = 0;
        private _spawnPos = [0, 0, 0];

        while { _attempt < _maxAttempts } do {
            _attempt = _attempt + 1;

            // 1) Try road network first
            private _roads = _pos nearRoads _spawnRadius;
            if (count _roads > 0) then {
                _spawnPos = getPos (selectRandom _roads);
            } else {
                // 2) Fallback to safePos
                _spawnPos = _safeParams call BIS_fnc_findSafePos;
            };

            // 3) Check for other vehicles nearby
            private _nearbyCars = nearestObjects [_spawnPos, _collisionClasses, 15];
            if (count _nearbyCars > 0) then { 
                sleep 0.1; 
                continue; 
            };

            // returns true if any player is within 200 m of _pos
            private _anyClose = count (allPlayers select { _x distance _spawnPos < 200 }) > 0;
            if (_anyClose) then {
                continue;
            } else {
                break;
            };
        };

        _spawnPos
    };

    //–– Spawn “loaded” vehicles ––
    for "_i" from 1 to _spawnCountVeh do {
        private _posSpawn = [_pos, _spawnRadius, _safeParams, _collisionClasses] call _findSpawnPos;
        private _type     = _vehArray call BIS_fnc_selectRandomWeighted;
        private _veh      = createVehicle [_type, _posSpawn, [], 0, "NONE"];

        _veh setDir (random 360);
        clearWeaponCargoGlobal   _veh;
        clearMagazineCargoGlobal _veh;
        clearItemCargoGlobal     _veh;

        {
            _veh setHitPointDamage [_x, selectRandom [0.65, 0.75, 0.8]];
        } forEach [
            "HitEngine","HitFuel","HitHRotor","HitVRotor","HitHull",
            "wheel_1_1_steering","wheel_1_2_steering","wheel_2_1_steering",
            "wheel_2_2_steering","wheel_1_3_steering","wheel_2_3_steering",
            "wheel_1_4_steering","wheel_2_4_steering"
        ];

        _veh setFuel (selectRandom [0, 0.015, 0.03]);
        _veh setHitPointDamage ["HitL", 0];
        _veh setHitPointDamage ["HitR", 0];
        _veh setLightBrightness 10;
        _veh setLightDayLight  true;
    };

    //–– Spawn “empty” vehicles ––
    for "_i" from 1 to _spawnCountEmpty do {
        private _posSpawn = [_pos, _spawnRadius, _safeParams, _collisionClasses] call _findSpawnPos;
        private _type     = _emptyVehArray call BIS_fnc_selectRandomWeighted;
        private _veh      = createVehicle [_type, _posSpawn, [], 0, "NONE"];

        _veh setDir (random 360);
        sleep 0.1;
    };
};