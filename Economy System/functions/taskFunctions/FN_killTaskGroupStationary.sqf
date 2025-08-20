params ["_container", "_caller", "_actionId"];

if (isNull (currentTask _caller)) then {
    hintSilent format ["The following group has had a bounty put on their leader. Eliminate them for a reward, %1", name _caller];

    private _factionArray = ["taskFactionWeights"] call (missionNamespace getVariable "FN_arrayReturn");
    private _faction = _factionArray call BIS_fnc_selectRandomWeighted;

    private _numUnits = ceil (random 7) + 6;
    private _minDist = 700;
    private _maxDist = 2500;

    private _pos = [getPos _caller, _minDist, _maxDist, 10, 0, 20, 0] call BIS_fnc_findSafePos;
    private _posMarker = [_pos, 0, 300, 0, 0, 20, 0] call BIS_fnc_findSafePos;

    private _flag = "Flag_Red_F" createVehicle _pos;

    [_faction, _numUnits, _pos, "Camp", RESISTANCE] call (missionNamespace getVariable "FN_spawnAI");

    private _unitSkillsArray = [_faction, _pos] call FN_getFactionSkills;
    private _side = RESISTANCE;
    private _unit = _unitSkillsArray select 1;

    private _sfOverride = false;
    private _sfProb = 0.0;
    if (random 1 < _sfProb) then { _sfOverride = true; };

    private _groupBandit = createGroup [_side, true];

    private ["_newAI"];
    _newAI = _groupBandit createUnit [_unit, _pos, [], 15, "NONE"];
    [_faction, _newAI, false, true, _sfOverride] call (missionNamespace getVariable "FN_equipAI");
    [_newAI, _unitSkillsArray select 2, _unitSkillsArray select 3, _unitSkillsArray select 4, _unitSkillsArray select 5, _unitSkillsArray select 6, _unitSkillsArray select 7, _unitSkillsArray select 8, _unitSkillsArray select 9] call FN_setUnitSkills;

    private _rndTaskID = str (random 100);

    [_caller, _rndTaskID, [format ["Eliminate the target to earn $120. The group is held up within 300 meters of the marker. It does not matter if you or someone else kills him, just make sure the job gets done. The faction the target is a part of is %1", _faction], "Eliminate the Stationary Target"], _posMarker, "ASSIGNED", 0, true, "kill", false] call BIS_fnc_taskCreate;

    _newAI setVariable ["LB_taskId", _rndTaskID];
    _newAI setVariable ["LB_container", _container];
    _newAI setVariable ["LB_actionId", _actionId];
    _newAI setVariable ["LB_caller", _caller];
    _newAI setVariable ["LB_flag", _flag];

    _newAI addEventHandler ["Killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        private _taskId = _unit getVariable ["LB_taskId", ""];
        private _container = _unit getVariable ["LB_container", objNull];
        private _actionId = _unit getVariable ["LB_actionId", -1];
        private _caller = _unit getVariable ["LB_caller", objNull];
        private _flag = _unit getVariable ["LB_flag", objNull];

        [_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
        [_taskId, true] call BIS_fnc_deleteTask;
        hintSilent "Task has been completed, receive your reward at the contractor's office";

        for "_i" from 1 to 120 do {
            if (!isNull _caller && {_caller canAddItemToBackpack "rvg_money"}) then {
                _caller addItemToBackpack "rvg_money";
                hintSilent format ["All of the amount owed to you ($%2) has been put in your backpack, %1. Good work out there.", name _caller, 120];
            } else {
                if (!isNull _container && !isNull _caller) then {
                    [_container, _caller, _actionId, "rvg_money", 1, 1] execVM "Economy System\functions\FN_ammoBoxCheck.sqf";
                    hintSilent format ["It seems your backpack was full or missing %1. The remaining or full amount has been put into a ammo box at the original assigning contractors location", name _caller];
                };
            };
        };

        if (!isNull _flag) then { deleteVehicle _flag; };
    }];

    _newAI addEventHandler ["Deleted", {
        params ["_entity"];
        private _taskId = _entity getVariable ["LB_taskId", ""];
        private _flag = _entity getVariable ["LB_flag", objNull];

        [_taskId, "CANCELED"] call BIS_fnc_taskSetState;
        [_taskId, true] call BIS_fnc_deleteTask;
        hintSilent "We have lost the position of the target. Thus, the contract has been canceled.";
        uiSleep 5;
        hintSilent "";

        if (!isNull _flag) then { deleteVehicle _flag; };
    }];

    _caller addEventHandler ["Killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        private _targets = allUnits select {(_x getVariable ["LB_caller", objNull]) isEqualTo _unit};
        {
            private _taskId = _x getVariable ["LB_taskId", ""];
            private _flag = _x getVariable ["LB_flag", objNull];
            [_taskId, "CANCELED"] call BIS_fnc_taskSetState;
            [_taskId, true] call BIS_fnc_deleteTask;
            if (!isNull _flag) then { deleteVehicle _flag; };
        } forEach _targets;

        hintSilent "We have lost the position of the target. Thus, the contract has been canceled.";
    }];
} else {
    hintSilent "Sorry, but it seems you already have a task assigned. Finish that one before accepting another.";
};