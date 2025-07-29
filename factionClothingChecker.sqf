params ["_unit"];

if (!local _unit) exitWith {
    diag_log format ["[FactionCheck] Ignored non-local unit: %1", name _unit];
};

// Function to evaluate a single player's clothing and update faction relations
missionNamespace setVariable ["FN_factionClothingCheck", {
    params ["_unit"];

	// Weighted arrays setup
	headgearArraySelectionBB = [["headgearBB"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	headgearArraySelectionDT = [["headgearDT"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	facewearArraySelectionDT = [["facewearDT"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	headgearArraySelectionNH = [["headgearNH"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	headgearArraySelectionPF = [["headgearPF"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	uniformArraySelectionPF = [["uniformPF"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	facewearArraySelectionRC = [["facewearRC"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	uniformArraySelectionRC = [["uniformRC"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	facewearArraySelectionTRB = [["facewearTRB"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	uniformArraySelectionTRB = [["uniformTRB"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	headgearArraySelectionUS = [["headgearUS"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	facewearArraySelectionUS = [["facewearUS"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	uniformArraySelectionUS = [["uniformUS"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	headgearArraySelectionRU = [["headgearRU"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	uniformArraySelectionRU = [["uniformRU"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	uniformArraySelectionROA = [["uniformROA"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	headgearArraySelectionROA = [["headgearROA"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	uniformArraySelectionPMC = [["uniformPMC"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	facewearArraySelectionPMC = [["facewearPMC"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	headgearArraySelectionWO = [["headgearWO"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	uniformArraySelectionWO = [["uniformWO"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	uniformArraySelectionALF = [["uniformALF"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	facewearArraySelectionALF = [["facewearALF"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");
	facewearArraySelectionBandit = [["facewearBandit"] call (missionNamespace getVariable "FN_arrayReturn")] call (missionNamespace getVariable "FN_convertWeightedArray");

    private _sanity = _unit getVariable ["sanityLevel", 100];
    if (!(_unit getVariable ["Renegade_Relation", false])) then {
        if (_sanity > 10) then {
            private _playerUniform = uniform _unit;
            private _playerHeadgear = headgear _unit;
            private _playerGoggles = goggles _unit;
            switch true do {
                case (_playerHeadgear in headgearArraySelectionBB): {
                    _unit setVariable ["SU_Relation",true,true];
                    _unit setVariable ["BB_Relation",true,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerHeadgear in headgearArraySelectionDT && _playerGoggles in facewearArraySelectionDT): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",true,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",true,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerHeadgear in headgearArraySelectionNH): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",true,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",true,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerHeadgear in headgearArraySelectionPF && _playerUniform in uniformArraySelectionPF): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",true,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerGoggles in facewearArraySelectionRC && _playerUniform in uniformArraySelectionRC): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",true,true];
                    _unit setVariable ["RC_Relation",true,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerUniform in uniformArraySelectionTRB && _playerGoggles in facewearArraySelectionTRB): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",true,true];
                    _unit setVariable ["RC_Relation",true,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerHeadgear in headgearArraySelectionUS && _playerUniform in uniformArraySelectionUS && _playerGoggles in facewearArraySelectionUS): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",true,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerHeadgear in headgearArraySelectionRU && _playerUniform in uniformArraySelectionRU): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",true,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerHeadgear in headgearArraySelectionROA && _playerUniform in uniformArraySelectionROA): {
                    _unit setVariable ["SU_Relation",true,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",true,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerUniform in uniformArraySelectionPMC && _playerGoggles in facewearArraySelectionPMC): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",true,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerHeadgear in headgearArraySelectionWO && _playerUniform in uniformArraySelectionWO): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",true,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerUniform in uniformArraySelectionALF && _playerGoggles in facewearArraySelectionALF): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",true,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                case (_playerGoggles in facewearArraySelectionBandit): {
                    _unit setVariable ["SU_Relation",false,true];
                    _unit setVariable ["BB_Relation",false,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",true,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
                default {
                    _unit setVariable ["SU_Relation",true,true];
                    _unit setVariable ["BB_Relation",true,true];
                    _unit setVariable ["PF_Relation",false,true];
                    _unit setVariable ["ALF_Relation",false,true];
                    _unit setVariable ["WO_Relation",false,true];
                    _unit setVariable ["RU_Relation",false,true];
                    _unit setVariable ["US_Relation",false,true];
                    _unit setVariable ["NH_Relation",false,true];
                    _unit setVariable ["TRB_Relation",false,true];
                    _unit setVariable ["RC_Relation",false,true];
                    _unit setVariable ["DT_Relation",false,true];
                    _unit setVariable ["ROA_Relation",false,true];
                    _unit setVariable ["PMC_Relation",false,true];
                    _unit setVariable ["Bandit_Relation",false,true];
                    _unit setVariable ["Renegade_Relation",false,true];
                };
            };
        } else {
            _unit setVariable ["SU_Relation",false,true];
            _unit setVariable ["BB_Relation",false,true];
            _unit setVariable ["PF_Relation",true,true];
            _unit setVariable ["ALF_Relation",false,true];
            _unit setVariable ["WO_Relation",false,true];
            _unit setVariable ["RU_Relation",false,true];
            _unit setVariable ["US_Relation",false,true];
            _unit setVariable ["NH_Relation",false,true];
            _unit setVariable ["TRB_Relation",false,true];
            _unit setVariable ["RC_Relation",false,true];
            _unit setVariable ["DT_Relation",false,true];
            _unit setVariable ["ROA_Relation",false,true];
            _unit setVariable ["PMC_Relation",false,true];
            _unit setVariable ["Bandit_Relation",false,true];
        };
    };

	sleep 3;
}];

// Helper function to attach event handlers to a player
LB_fnc_attachClothingEH = {
    params ["_unit"];

    _unit addEventHandler ["Take", {
        private _unit = _this select 0;
        [_unit] remoteExec ["FN_factionClothingCheck", _unit];
    }];

    _unit addEventHandler ["Put", {
        private _unit = _this select 0;
        [_unit] remoteExec ["FN_factionClothingCheck", _unit];
    }];

    // Initial call must also be local
    [_unit] remoteExec ["FN_factionClothingCheck", _unit];
};


// Attach handlers to all current players
{
    [_x] call LB_fnc_attachClothingEH;
} forEach allPlayers;

// Reattach handlers when a player respawns
addMissionEventHandler ["EntityRespawned", {
    params ["_new", "_old"];
    if (isPlayer _new) then {
        [_new] call LB_fnc_attachClothingEH;
    };
}];