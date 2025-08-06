/*
    FN_attachAceLoot.sqf
    --------------------
    Client-side. Attaches ACE interaction to all helper helipads within 3000m of player.
    The interaction can only be used once per helipad (no spamming).
*/

// Main logic: scan and attach actions
params ["_player"];

[_player] spawn {
    params ["_player"];

    // Define the ACE interaction action (do this once per client)
    private _aceAction = [
        "ace_garbage_search", // Unique action name
        "Search the garbage pile",
        "",
        {
            params ["_target", "_player", "_params"];
            [_player] remoteExec ["FN_spawnLootGround", 2];

            // Mark as searched (globally so all clients see it)
            _target setVariable ["lootSearched", true, true];

            // Remove ACE action from all clients
            [{
				params ["_obj"];
				[_obj, 0, ["ACE_MainActions"], "ace_garbage_search"] call ace_interact_menu_fnc_removeActionFromObject;
			}] remoteExec ["call", -2];

        },
        { isNil {_target getVariable "lootSearched"} },
        nil,
        3
    ] call ace_interact_menu_fnc_createAction;

    // Function to attach ACE action only if not already searched and not already attached
    private _attachAceAction = {
        params ["_helper"];
        if (
            isNil {_helper getVariable "hasAceGarbageSearch"} && // Not already attached
            isNil {_helper getVariable "lootSearched"} // Not already searched
        ) then {
            [_helper, 0, ["ACE_MainActions"], _aceAction] call ace_interact_menu_fnc_addActionToObject;
            _helper setVariable ["hasAceGarbageSearch", true, false];
        };
    };

    while {true} do {
        // Find all helpers (within 3000m of player for efficiency)
        private _helpers = nearestObjects [_player, ["Sign_Sphere200cm_F"], 300];
        {
            [_x] call _attachAceAction;
            sleep 0.01; // Very short sleep to prevent frame hitching in big loops
        } forEach _helpers;

        sleep 15;
    };
};