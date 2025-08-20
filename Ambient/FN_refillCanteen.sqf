/*
   FN_refillCanteen.sqf
*/
params ["_player"];

if (([_player, "rvg_canteenEmpty"] call BIS_fnc_hasItem) || ([_player, "ACE_Canteen_Empty"] call BIS_fnc_hasItem)) then {
    _player removeItem "rvg_canteenEmpty";
    _player addItem "rvg_canteen";
    ["Your canteen has been refilled"] remoteExec ["hintSilent", _player];
    [_player, "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic"] remoteExec ["switchMove", 0, true];
    
    sleep 3;

    [_player, ""] remoteExec ["switchMove", 0, true];
} else {
    if (([_player, "rvg_plasticBottleEmpty"] call BIS_fnc_hasItem) || ([_player, "ACE_WaterBottle_Empty"] call BIS_fnc_hasItem)) then {
        _player removeItem "rvg_plasticBottleEmpty";
        _player addItem "rvg_plasticBottle";
        ["Your water bottle has been refilled"] remoteExec ["hintSilent", _player];
        [_player, "AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic"] remoteExec ["switchMove", 0, true];

        sleep 3;

        [_player, ""] remoteExec ["switchMove", 0, true];
    } else {
        ["You don't have an empty water container to refill"] remoteExec ["hintSilent", _player];
    };
};