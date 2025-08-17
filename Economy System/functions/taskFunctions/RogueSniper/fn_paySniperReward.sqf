params ["_container","_actionId"];
private _paid = 0;
for "_i" from 1 to 100 do {
  if (player canAddItemToBackpack "rvg_money") then {
    player addItemToBackpack "rvg_money";
    _paid = _paid + 1;
  } else {
    [_container, player, _actionId, "rvg_money", 1, 1] remoteExec ["LB_fnc_ammoBoxCheckBridge", 2];
    break;
  };
};
hintSilent format ["All of the amount owed to you ($%1) has been delivered, %2.", 150, name player];