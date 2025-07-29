while {true} do {
    private _players = call BIS_fnc_listPlayers;
    private _playersCount = count _players;
    
    // Filter players who want to sleep
    private _sleepers = _players select { _x getVariable "wants_to_sleep" };
    private _sleepersCount = count _sleepers;
    
    // Only proceed if all players want to sleep
    if (_sleepersCount == _playersCount) then {
        private _allNearBags = true;
        
        {
            private _nearBags = nearestObjects [_x, ["Land_Sleeping_bag_F"], 5];
            if (count _nearBags == 0) then {
                _allNearBags = false;
                _x setVariable ["wants_to_sleep", false, true];
                // You could exit the forEach here if desired:
                // exitWith {};
            };
        } forEach _sleepers;
        
        if (_allNearBags) then {
            cutText ["", "BLACK OUT", 2.5]; // Fade to black
            sleep 5;
            [[2039,3,22,6,0]] remoteExec ["setDate"];
            
            {
                _x switchMove "AmovPpneMstpSrasWrflDnon";
                _x setVariable ["wants_to_sleep", false, true];
            } forEach _players;
            
            sleep 1;
            cutText ["", "BLACK IN", 5]; // Fade back in
        } else {
            hintSilent "Not all players are near their sleeping bags; however, all players are trying to sleep";
            sleep 5;
            hintSilent "";
        };
    };
    sleep 10;
};
