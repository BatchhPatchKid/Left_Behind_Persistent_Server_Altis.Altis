/*
  Client-only. Scans for helpers and attaches an ACE action that:
    - Calls LB_fnc_spawnLootGround on the server
    - Marks the helper as looted by setting interactionPoint = 4 (replicated)
    - Removes the action globally
*/
if (!hasInterface) exitWith {};

// Loot location action
private _aceActionLoot = [
  "ace_garbage_search",
  "Search the garbage pile",
  "",
  {
    params ["_target","_player","_params"];

    [_player] remoteExec ["LB_fnc_spawnLootGround", 2];

    [_target, 0, ["ACE_MainActions", "ace_garbage_search"]] call ace_interact_menu_fnc_removeActionFromObject;
    [_target, 0, ["ACE_MainActions", "ace_garbage_search"]] remoteExec ["ace_interact_menu_fnc_removeActionFromObject", 0, true];
    
  },
  { (_target getVariable ["interactionPoint", -1]) isEqualTo 4 },
  nil,
  3
] call ace_interact_menu_fnc_createAction;

// Refill water container action
private _aceActionRefill = [
  "ace_water_refill",
  "Refill Water Source",
  "",
  {
    params ["_target","_player","_params"];

    [_player] remoteExec ["LB_fnc_refillCanteen", 2];

  },
  { (_target getVariable ["interactionPoint", -1]) isEqualTo 5 },
  nil,
  3
] call ace_interact_menu_fnc_createAction;

// Drink water action
private _aceActionDrink = [
  "ace_water_drink",
  "Drink From Water Source",
  "",
  {
    params ["_target","_player","_params"];

    [_player] remoteExec ["LB_fnc_drinkFromWaterSource", 2];

  },
  { (_target getVariable ["interactionPoint", -1]) isEqualTo 5 },
  nil,
  3
] call ace_interact_menu_fnc_createAction;

// Attach ACE action to helpers in range
private _attach = {
  params ["_h"];

  //adding loot interaction
  if ((_h getVariable ["interactionPoint", -1]) isEqualTo 0) then {
    [_h, 0, ["ACE_MainActions"], _aceActionLoot] call ace_interact_menu_fnc_addActionToObject;
    _h setVariable ["interactionPoint", 4, true];
  };

  //adding water interaction's
  if ((_h getVariable ["interactionPoint", -1]) isEqualTo 1) then {
    [_h, 0, ["ACE_MainActions"], _aceActionRefill] call ace_interact_menu_fnc_addActionToObject;
    [_h, 0, ["ACE_MainActions"], _aceActionDrink] call ace_interact_menu_fnc_addActionToObject;
    _h setVariable ["interactionPoint", 5, true];
  };
};

while {true} do {
  private _helpers = nearestObjects [player, ["Land_HelipadEmpty_F"], 300];
  { [_x] call _attach; uiSleep 0.01; } forEach _helpers;
  uiSleep 15;
};