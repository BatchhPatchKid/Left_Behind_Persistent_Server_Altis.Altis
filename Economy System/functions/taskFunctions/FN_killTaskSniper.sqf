params ["_target", "_caller", "_actionId", "_args"];
private _container = _args select 0;

if (isNull (currentTask _caller)) then {
    hintSilent format ["The rogue sniper has a bounty put on them. Eliminate them for a reward, %1", name _caller];

    _minDist = 1000;
    _maxDist = 2500;
    _pos = [getPos _caller, _minDist, _maxDist, 5, 0, 20, 0] call BIS_fnc_findSafePos;

    _stoneSaver = "Land_BluntStone_01" createVehicle _pos;
    _sniperGrp = createGroup independent;
    _newAI = _sniperGrp createUnit ["I_G_Survivor_F", _pos, [], 15, "NONE"];

    _newAI addGoggles (selectRandom ["G_Balaclava_oli", "G_Balaclava_TI_blk_F", "G_Balaclava_TI_G_blk_F", "G_Balaclava_TI_tna_F", "G_Balaclava_TI_G_tna_F", "G_Balaclava_blk", "G_Balaclava_lowprofile"]);
    _newAI addUniform (selectRandom ["U_FRITH_RUIN_SDR_snip_crow", "U_FRITH_RUIN_SDR_snip_hawk", "U_FRITH_RUIN_SDR_snip_bld", "U_FRITH_RUIN_SDR_snip_crow", "U_FRITH_RUIN_SDR_snip_hawk", "U_FRITH_RUIN_SDR_snip_bld", "U_FRITH_RUIN_SDR_snip_crow", "U_FRITH_RUIN_SDR_snip_hawk", "U_FRITH_RUIN_SDR_snip_bld", "U_FRITH_RUIN_SDR_snip_crow", "U_FRITH_RUIN_SDR_snip_hawk", "U_FRITH_RUIN_SDR_snip_bld", "U_FRITH_RUIN_SDR_snip_crow", "U_FRITH_RUIN_SDR_snip_hawk", "U_FRITH_RUIN_SDR_snip_bld", "U_FRITH_RUIN_SDR_snip_crow", "U_FRITH_RUIN_SDR_snip_hawk", "U_FRITH_RUIN_SDR_snip_bld", "U_FRITH_RUIN_SDR_snip_crow", "U_FRITH_RUIN_SDR_snip_hawk", "U_FRITH_RUIN_SDR_snip_bld", "U_I_FullGhillie_ard", "U_O_FullGhillie_ard", "U_B_FullGhillie_ard", "U_O_T_FullGhillie_tna_F", "U_B_T_FullGhillie_tna_F", "U_I_FullGhillie_lsh", "U_O_FullGhillie_lsh", "U_B_FullGhillie_lsh", "U_I_FullGhillie_sard", "U_O_FullGhillie_sard", "U_B_FullGhillie_sard"]);
    _newAI addVest (selectRandom ["V_SmershVest_01_radio_F", "V_SmershVest_01_F"]);

    _rifle = selectRandom ["rhs_weap_svds_npz", "rhs_weap_svdp_wd_npz", "srifle_DMR_07_ghex_F", "arifle_MXM_Black_F", "arifle_MSBS65_Mark_camo_F", "rhs_weap_mk17_LB", "rhs_weap_sr25_ec_wd", "rhs_weap_m40a5_wd", "rhs_weap_m24sws_wd", "rhs_weap_XM2010_sa", "rhs_weap_m14_wd", "rhs_weap_m14ebrri", "arifle_SPAR_03_khk_F", "arifle_SPAR_03_blk_F"];
    _scope = selectRandom ["optic_MRCO", "optic_MRCO", "optic_MRCO", "optic_MRCO", "optic_DMS", "optic_KHS_blk", "optic_SOS", "optic_AMS", "rhsusf_acc_ACOG3_USMC", "optic_DMS_weathered_F", "optic_KHS_old", "rhsusf_acc_ACOG3", "rhsusf_acc_M8541_low", "rhsusf_acc_ACOG_RMR"];

    if (round (random 10) == 5) then { _newAI linkItem "ACE_NVG_Gen1"; };

    [_newAI, _rifle, 5] call BIS_fnc_addWeapon;
    _newAI addPrimaryWeaponItem _scope;
    [_newAI, 1, 1, 1, 1, 1, 1, 1, 1] call FN_setUnitSkills;

    _waypoint1 = _sniperGrp addWaypoint [[_pos, 200, 400, 5, 0, 20, 0] call BIS_fnc_findSafePos, 0];
    _waypoint1 setWaypointType "MOVE";
    _waypoint1 setWaypointBehaviour "COMBAT";
    _newAI setUnitPos "MIDDLE";

    _rndDouble = random 100;
    _rndTaskID = str _rndDouble;

    [_caller, _rndTaskID, [["Eliminate the target to earn $100. The sniper will be within 500 meters of the objective marker. It does not matter if you or someone else kills him, just make sure the job gets done."], "Eliminate the Rogue Sniper", ""], _pos, "ASSIGNED", 0, true, "kill", false] call BIS_fnc_taskCreate;

    _newAI setVariable ["LB_taskId", _rndTaskID];
    _newAI setVariable ["LB_container", _container];
    _newAI setVariable ["LB_actionId", _actionId];
    _newAI setVariable ["LB_stoneSaver", _stoneSaver];
    _newAI setVariable ["LB_caller", _caller];

    _newAI addEventHandler ["Killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        private _taskId = _unit getVariable ["LB_taskId", ""];
        private _container = _unit getVariable ["LB_container", objNull];
        private _actionId = _unit getVariable ["LB_actionId", -1];
        private _stoneSaver = _unit getVariable ["LB_stoneSaver", objNull];
        private _caller = _unit getVariable ["LB_caller", objNull];

        [_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
        [_taskId, true] call BIS_fnc_deleteTask;
        hintSilent "Task has been completed, receive your reward at the contractor's office";

        for "_i" from 1 to 100 do {
            if (!isNull _caller && {_caller canAddItemToBackpack "rvg_money"}) then {
                _caller addItemToBackpack "rvg_money";
                hintSilent format ["All of the amount owed to you ($%2) has been put in your backpack, %1. Good work out there.", name _caller, 150];
            } else {
                if (!isNull _container && !isNull _caller) then {
                    [_container, _caller, _actionId, "rvg_money", 1, 1] execVM "Economy System\functions\FN_ammoBoxCheck.sqf";
                    hintSilent format ["It seems your backpack was full or missing %1. The remaining or full amount has been put into a ammo box at the original assigning contractors location", name _caller];
                };
            };
        };

        if (!isNull _stoneSaver) then { deleteVehicle _stoneSaver; };
    }];

    _newAI addEventHandler ["Deleted", {
        params ["_entity"];
        private _taskId = _entity getVariable ["LB_taskId", ""];
        private _stoneSaver = _entity getVariable ["LB_stoneSaver", objNull];
        [_taskId, "CANCELED"] call BIS_fnc_taskSetState;
        [_taskId, true] call BIS_fnc_deleteTask;
        hintSilent "We have lost the position of the target. Thus, the contract has been canceled.";
        if (!isNull _stoneSaver) then { deleteVehicle _stoneSaver; };
    }];

    _caller addEventHandler ["Killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        private _groupUnits = allUnits select {(_x getVariable ["LB_caller", objNull]) isEqualTo _unit};
        {
            private _taskId = _x getVariable ["LB_taskId", ""];
            private _stoneSaver = _x getVariable ["LB_stoneSaver", objNull];
            [_taskId, "CANCELED"] call BIS_fnc_taskSetState;
            [_taskId, true] call BIS_fnc_deleteTask;
            hintSilent "We have lost the position of the target. Thus, the contract has been canceled.";
            if (!isNull _stoneSaver) then { deleteVehicle _stoneSaver; };
        } forEach _groupUnits;
    }];
} else {
    hintSilent "Sorry, but it seems you already have a task assigned. Finish that one before accepting another.";
};