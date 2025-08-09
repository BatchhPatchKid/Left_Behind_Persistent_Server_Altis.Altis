/*
    FN_lootGarbageSystem.sqf
    --------------------------
    Server-only! Ensures every valid garbage pile has a single Land_HelipadEmpty_F helper.

    Tuning:
      - _scanRadius: how far ahead of each player to prepare loot helpers.
        For 30s scan cadence and on-foot players, ~200–225m is ideal.
      - _noPopInRadius: skip spawning if someone is right on top of the pile
        to avoid visible pop-in.

    NOTE: The comment previously said 3000m; keep this aligned with _scanRadius.
*/

private _scanRadius = 200;  // 200–225 recommended for 30s cadence on foot
private _noPopInRadius = 8;    // don’t spawn helpers if a player is within 8m

private _classesToScan = [
    "cashdesk_f","garbageheap_01_f","rowboat_v1_f","icebox_f","wreck_bmp2_f",
    "garbageheap_02_f","wreck_afv_wheeled_01_f","garbageheap_03_f","luggageheap_04_f",
    "wreck_truck_f","wreck_hmmwv_f","wreck_brdm2_f","wreck_skodovka_f","luggageheap_05_f",
    "garbagepallet_f","garbageheap_04_f","woodencrate_01_stack_x5_f","sack_f","sacks_heap_f",
    "luggageheap_02_f","wreck_car2_f","garbagewashingmachine_f","sacks_goods_f","luggageheap_01_f",
    "v3s_wreck_f","garbagebags_f","tabledesk_f","woodencrate_01_stack_x3_f","wreck_uaz_f",
    "officetable_01_f","crateswooden_f","wreck_slammer_f","wreck_car_f","officecabinet_02_f",
    "luggageheap_03_f","wreck_car3_f","wreck_t72_hull_f","officecabinet_01_f"
];

while {true} do {
    {
        private _player = _x;

        // Find all candidate objects within _scanRadius of this player
        private _garbagePiles = nearestObjects [_player, [], _scanRadius];

        {
            private _obj = _x;
            private _dist = _player distance _obj;

            // Skip if someone is standing on it, or it’s outside our scan window
            if ( { _x distance _obj < _noPopInRadius } count allPlayers > 0 ) then { continue; };
            if (_dist > _scanRadius) then { continue; };

            // Identify by model path -> classname stem before ".p3d"
            private _info = getModelInfo _obj;
            if (_info isEqualTo []) then { continue; };
            private _fullPath = _info select 0;

            private _parts = _fullPath splitString ".";
            if (_parts isEqualTo []) then { continue; };

            private _class = _parts select 0;
            if (!(_class in _classesToScan)) then { continue; };

            private _helpers = nearestObjects [_obj, ["Land_HelipadEmpty_F"], 5];
            if (_helpers isEqualTo []) then {
                // Place helper at top-center of the model
                private _bb  = boundingBox _obj;
                private _min = _bb select 0;
                private _max = _bb select 1;

                private _topPos = _obj modelToWorld [
                    ((_min select 0) + (_max select 0)) / 2,
                    ((_min select 1) + (_max select 1)) / 2,
                    (_max select 2)
                ];

                private _lootPoint = createVehicle ["Land_HelipadEmpty_F", _topPos, [], 0, "CAN_COLLIDE"];
                private _chem = createVehicle ["Chemlight_green", _topPos, [], 0, "CAN_COLLIDE"];
                uiSleep 0.05;
            };

            uiSleep 0.05;
        } forEach _garbagePiles;

        uiSleep 5;
    } forEach allPlayers;

    // If your outer loop runs roughly every 30s total, _scanRadius=200 is sufficient for on-foot play.
    uiSleep 15;
};