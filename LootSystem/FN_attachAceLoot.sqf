/*
  Client-only. Scans for helpers and attaches an ACE action that:
    - Calls LB_fnc_spawnLootGround on the server
    - Marks the helper as searched (replicated)
    - Removes the action globally
*/
if (!hasInterface) exitWith {};

// Build the ACE action once per client
private _aceAction = [
  "ace_garbage_search",
  "Search the garbage pile",
  "",
  {
    params ["_target","_player","_params"];

    // Server: spawn loot at the helper
    [_player] remoteExec ["LB_fnc_spawnLootGround", 2];  // 2 = server only
    //[_player] execVM "LootSystem\FN_spawnLootGround.sqf";

    // Replicate searched-state so all clients hide the action (JIP-safe)
    _target setVariable ["lootSearched", true, true];

    // Remove the action from all clients (pass the object!)
    [
      {
        params ["_obj"];
        [_obj, 0, ["ACE_MainActions"], "ace_garbage_search"]
          call ace_interact_menu_fnc_removeActionFromObject;
      },
      _target
    ] remoteExecCall ["call", -2]; // -2 = all clients
  },
  { isNil { _target getVariable "lootSearched" } }, // condition
  nil,
  3
] call ace_interact_menu_fnc_createAction;

// Attach ACE action to helpers in range
private _attach = {
  params ["_h"];
  if (
    isNil { _h getVariable "hasAceGarbageSearch" } &&
    isNil { _h getVariable "lootSearched" }
  ) then {
    [_h, 0, ["ACE_MainActions"], _aceAction] call ace_interact_menu_fnc_addActionToObject;
    _h setVariable ["hasAceGarbageSearch", true, false]; // local flag to avoid re-adding
  };
};

while {true} do {
  private _helpers = nearestObjects [player, ["Land_HelipadEmpty_F"], 300];
  { [_x] call _attach; uiSleep 0.01; } forEach _helpers;
  uiSleep 15;
};