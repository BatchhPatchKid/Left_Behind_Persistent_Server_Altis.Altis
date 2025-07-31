[] spawn {
    // Check if there's already a sleeping bag placed
    if (!isNil "sleepingBagObject") then {
        deleteVehicle sleepingBagObject; // Delete the existing sleeping bag
    };

    // Create and position the new sleeping bag
    private _sleepingBag = "Land_Sleeping_bag_F" createVehicle [
        (getPosATL player select 0),
        (getPosATL player select 1),
        (getPosATL player select 2)
    ];
    _sleepingBag setPos [
        (getPosATL player select 0),
        (getPosATL player select 1),
        (getPosATL player select 2) + 0.02
    ];
    _sleepingBag setDir (getDir player);

    // Assign the new sleeping bag object to a global variable for tracking
    sleepingBagObject = _sleepingBag;

    // Add “Try to sleep” action
    sleepingBagObject addAction [
        "Try to sleep", // title
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
            if (!(_caller getVariable "wants_to_sleep")) then {
                if (daytime < 6 || daytime > 20) then {
                    _caller setVariable ["wants_to_sleep", true, true];
                    hintSilent "You are now trying to sleep.";
                    sleep 3;
                    hintSilent "";
                } else {
                    _caller setVariable ["wants_to_sleep", false, true];
                    hintSilent "It's too early to sleep. Your bedtime is from 20:00 to 06:00.";
                    sleep 3;
                    hintSilent "";
                };
            } else {
                hintSilent "You are already trying to sleep";
            };
        },
        nil, 1.5, true, true, "", "true", 3, false, "", ""
    ];

    // Add “Stop trying to sleep” action
    sleepingBagObject addAction [
        "Stop trying to sleep", // title
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
            if (_caller getVariable "wants_to_sleep") then {
                _caller setVariable ["wants_to_sleep", false, true];
                hintSilent "You are no longer trying to sleep.";
                sleep 3;
                hintSilent "";
            } else {
                hintSilent "You weren't trying to sleep.";
                sleep 3;
                hintSilent "";
            };
        },
        nil, 1.5, true, true, "", "true", 3, false, "", ""
    ];

    // Add “Roll up sleeping bag” action
    sleepingBagObject addAction [
        "Roll up sleeping bag", // title
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
            _caller setVariable ["wants_to_sleep", false, true];
            deleteVehicle _target;
        },
        nil, 1.5, true, true, "", "true", 3, false, "", ""
    ];
};