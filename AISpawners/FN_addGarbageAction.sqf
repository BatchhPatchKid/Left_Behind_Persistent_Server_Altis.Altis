params ["_pile", "_pos"];

private _action = [
    "searchGarbage",
    "Search through the garbage",
    "",
    {
        params ["_target", "_caller", "_actionParams"];
        private _pos = _actionParams select 0;
        [_pos] remoteExec ["FN_spawnLootCrate", 2];
        [_target] remoteExec ["deleteVehicle", 0];
    },
    {true},
    {},
    [_pos]
] call ace_interact_menu_fnc_createAction;

[_pile, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;