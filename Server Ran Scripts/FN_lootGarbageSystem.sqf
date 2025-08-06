/*
    FN_lootGarbageSystem.sqf
    --------------------------
    Server-only! Ensures every valid garbage pile has a single Land_HelipadEmpty_F helper.
    Run periodically for persistence, or once at mission start if piles don’t move.
*/

private _classesToScan = ["cashdesk_f",
"garbageheap_01_f",
"rowboat_v1_f",
"icebox_f",
"wreck_bmp2_f",
"garbageheap_02_f",
"wreck_afv_wheeled_01_f",
"garbageheap_03_f",
"luggageheap_04_f",
"wreck_truck_f",
"wreck_hmmwv_f",
"wreck_brdm2_f",
"wreck_skodovka_f",
"luggageheap_05_f",
"garbagepallet_f",
"garbageheap_04_f",
"woodencrate_01_stack_x5_f",
"sack_f",
"sacks_heap_f",
"luggageheap_02_f",
"wreck_car2_f",
"garbagewashingmachine_f", 
"sacks_goods_f",
"luggageheap_01_f",
"v3s_wreck_f",
"garbagebags_f",
"tabledesk_f",
"woodencrate_01_stack_x3_f",
"wreck_uaz_f",
"officetable_01_f",
"crateswooden_f",
"wreck_slammer_f",
"officetable_01_f",
"wreck_car_f",
"officecabinet_02_f",
"luggageheap_03_f",
"wreck_car3_f",
"wreck_t72_hull_f",
"officecabinet_01_f"];

while {true} do {
    {
        private _player = _x;
        // Find all garbage piles within 3000 meters of this player
        private _garbagePiles = nearestObjects [_player, [], 300];

        {
            private _obj = _x;
            private _dist = _player distance _obj;
            // Only process if pile is within 5-100 meters of the player
            private _closePlayers = allPlayers select { (_x distance _obj) < 5 };
            if (count _closePlayers > 0 || _dist > 100) then { continue; };

            private _info = getModelInfo _obj;
            if (count _info == 0) then { continue; };

            private _fullPath = _info select 0;
            private _parts = _fullPath splitString ".";
            if (count _parts == 0) then { continue; };

            private _class = _parts select 0;
            if (!(_class in _classesToScan)) then { continue; };

            // Is there already a helper helipad within 2 meters of this pile?
            private _helpers = nearestObjects [_obj, ["Sign_Sphere200cm_F"], 0.5];
            if (count _helpers == 0) then {
                // Spawn the helper (ACE interaction will be attached client-side)
                
                // Get model-space bounding box corners
                private _bb   = boundingBox _obj;
                private _min  = _bb select 0;
                private _max  = _bb select 1;

                // Compute top-middle point in model-space and convert to world-space
                private _topPos = _obj modelToWorld [
                    ((_min select 0) + (_max select 0)) / 2,  // mid X
                    ((_min select 1) + (_max select 1)) / 2,  // mid Y
                    (_max select 2)                           // top Z
                ];

                _lootPoint = createVehicle ["Sign_Sphere200cm_F", _topPos, [], 0, "CAN_COLLIDE"];
                sleep 0.05;
                _lootPoint setObjectTextureGlobal [0, "#(argb,8,8,3)color(1,1,1,0)"];
            };
            sleep 0.05;
        } forEach _garbagePiles;
        sleep 5;
    } forEach allPlayers;

    sleep 15;
};