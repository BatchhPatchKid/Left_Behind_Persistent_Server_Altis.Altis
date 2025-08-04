/*
    FN_lootGarbageSystem.sqf
    --------------------------
    Server-only! Ensures every valid garbage pile has a single Land_HelipadEmpty_F helper.
    Run periodically for persistence, or once at mission start if piles don’t move.
*/

private _classesToScan = ["garbage", 
"garbagewashingmachine_f", 
"garbagebags_f",
"officecabinet_01_f",
"cashdesk_f",
"luggageheap_04_f",
"luggageheap_03_f",
"icebox_f",
"luggageheap_05_f",
"officecabinet_02_f",
"luggageheap_03_f",
"sack_f",
"paperbox_01_small_closed_f",
"tooltrolley_02_f",
"garbageheap_01_f",
"woodencrate_01_f",
"crateswooden_f",
"sacks_heap_f",
"garbageheap_02_f",
"sacks_goods_f",
"garbageheap_03_f",
"woodencrate_01_stack_x3_f",
"woodencrate_01_stack_x5_f",
"garbageheap_04_f"];

while {true} do {
    {
        private _player = _x;
        // Find all garbage piles within 3000 meters of this player
        private _garbagePiles = nearestObjects [_player, [], 100];

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
            private _helpers = nearestObjects [_obj, ["Helipad_Base_F"], 2];
            if (count _helpers == 0) then {
                // Spawn the helper (ACE interaction will be attached client-side)
                createVehicle ["Land_HelipadEmpty_F", getPos _obj, [], 0, "CAN_COLLIDE"];
            };
            sleep 1;
        } forEach _garbagePiles;
        sleep 5;
    } forEach allPlayers;

    sleep 30;
};