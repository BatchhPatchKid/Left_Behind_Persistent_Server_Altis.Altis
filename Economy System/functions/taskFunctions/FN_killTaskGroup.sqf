params ["_container", "_caller", "_actionId"];
if (isNull (currentTask _caller)) then {
    hintSilent format ["The following group has had a bounty put on their leader. Eliminate them for a reward, %1", name _caller];

    private _factionArray = ["taskFactionWeights"] call (missionNamespace getVariable "FN_arrayReturn");
    private _faction = _factionArray call BIS_fnc_selectRandomWeighted;
    private _minDist = 750;
    private _maxDist = 1500;
    private _pos = [getPos _caller, _minDist, _maxDist, 5, 0, 20, 0] call BIS_fnc_findSafePos;

    private _stoneSaver = "Land_BluntStone_01" createVehicle _pos;

    private _unitSkillsArray = [_faction, _pos] call FN_getFactionSkills;
    private _side = RESISTANCE;
    private _unit = "I_G_Survivor_F";

    private _sfOverride = false;
    private _sfProb = 0;
    if (random 1 < _sfProb) then { _sfOverride = true; };

    private _meleeChance = [_faction] call (missionNamespace getVariable "FN_meleeChance");

    private _groupBandit = createGroup [_side, true];

    private _newAI = _groupBandit createUnit [_unit, _pos, [], 15, "NONE"];
    [_faction, _newAI, false, true, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
    [_newAI, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call FN_setUnitSkills;

    private _maxBandits = ceil (random 5) + 4;
    for "_i" from 0 to _maxBandits do {
        if (random 1 > _meleeChance) then {
            private _banditUnit = _groupBandit createUnit [_unit, _pos, [], 15, "NONE"];
            [_faction, _banditUnit, false, true, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
            [_banditUnit, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call FN_setUnitSkills;
        } else {
            private _grpTemp = createGroup east;
            private _banditUnit = _grpTemp createUnit ["O_soldier_Melee_RUSH", ([_pos, 0, 10, 3, 0, 20, 0, [], []] call BIS_fnc_findSafePos), [], 1, "NONE"];
            [_faction, _banditUnit, true, false, false] call (missionNamespace getVariable "FN_equipAI");
            [_banditUnit, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call FN_setUnitSkills;
        };
        sleep 0.01;
    };

    private _waypointPos = [_pos, 150, 300, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    private _wp1 = _groupBandit addWaypoint [_waypointPos, 0];
    _wp1 setWaypointType "MOVE";

    _waypointPos = [_pos, 100, 300, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    private _wp2 = _groupBandit addWaypoint [_waypointPos, 1];
    _wp2 setWaypointType "MOVE";

    _waypointPos = [_pos, 50, 300, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    private _wp3 = _groupBandit addWaypoint [_waypointPos, 2];
    _wp3 setWaypointType "MOVE";

    _waypointPos = [_pos, 100, 300, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    private _wp4 = _groupBandit addWaypoint [_waypointPos, 3];
    _wp4 setWaypointType "CYCLE";

    sleep 3;
    hintSilent "";

    private _rndTaskID = str (random 100);

    [_caller, _rndTaskID, [format ["Eliminate the target to earn $80. The target will be within 300 meters of the mark on your map. It does not matter if you or someone else kills him, just make sure the job gets done. The faction the target is a part of is %1", _faction], "Eliminate the Wandering Target"], _pos, "ASSIGNED", 0, true, "kill", false] call BIS_fnc_taskCreate;

    _newAI setVariable ["LB_taskId", _rndTaskID];
    _newAI setVariable ["LB_container", _container];
    _newAI setVariable ["LB_actionId", _actionId];
    _newAI setVariable ["LB_caller", _caller];
    _newAI setVariable ["LB_stoneSaver", _stoneSaver];

    _newAI addEventHandler ["Killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        private _taskId = _unit getVariable ["LB_taskId", ""];
        private _container = _unit getVariable ["LB_container", objNull];
        private _actionId = _unit getVariable ["LB_actionId", -1];
        private _caller = _unit getVariable ["LB_caller", objNull];
        private _stoneSaver = _unit getVariable ["LB_stoneSaver", objNull];

        [_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
        [_taskId, true] call BIS_fnc_deleteTask;
        hintSilent "Task has been completed, receive your reward at the contractor's office";

        for "_i" from 1 to 80 do {
            if (!isNull _caller && {_caller canAddItemToBackpack "rvg_money"}) then {
                _caller addItemToBackpack "rvg_money";
                hintSilent format ["All of the amount owed to you ($%2) has been put in your backpack, %1. Good work out there.", name _caller, 80];
            } else {
                if (!isNull _container && !isNull _caller) then {
                    [_container, _caller, _actionId, "rvg_money", 1, 1] execVM "Economy System\functions\FN_ammoBoxCheck.sqf";
                    hintSilent format ["It seems your backpack was full or missing %1. The remaining or full amount has been put into a ammo box at the original assigning contractors location", name _caller];
                };
            };
        };

        [] spawn { uiSleep 5; hintSilent ""; };
        if (!isNull _stoneSaver) then { deleteVehicle _stoneSaver; };
    }];

    _newAI addEventHandler ["Deleted", {
        params ["_entity"];
        private _taskId = _entity getVariable ["LB_taskId", ""];
        private _stoneSaver = _entity getVariable ["LB_stoneSaver", objNull];
        [_taskId, "CANCELED"] call BIS_fnc_taskSetState;
        [_taskId, true] call BIS_fnc_deleteTask;
        hintSilent "We have lost the position of the target. Thus, the contract has been canceled.";
        [] spawn { uiSleep 5; hintSilent ""; };
        if (!isNull _stoneSaver) then { deleteVehicle _stoneSaver; };
    }];

    _caller addEventHandler ["Killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        private _targets = allUnits select {(_x getVariable ["LB_caller", objNull]) isEqualTo _unit};
        {
            private _taskId = _x getVariable ["LB_taskId", ""];
            private _stoneSaver = _x getVariable ["LB_stoneSaver", objNull];
            [_taskId, "CANCELED"] call BIS_fnc_taskSetState;
            [_taskId, true] call BIS_fnc_deleteTask;
            if (!isNull _stoneSaver) then { deleteVehicle _stoneSaver; };
        } forEach _targets;
        hintSilent "We have lost the position of the target. Thus, the contract has been canceled.";
        [] spawn { uiSleep 5; hintSilent ""; };
    }];
} else {
    hintSilent "Sorry, but it seems you already have a task assigned. Finish that one before accepting another.";
};