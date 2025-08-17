waitUntil {!isNull player};

player enableStamina false;
[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;

player setVariable ["SU_Relation",true,true];
player setVariable ["BB_Relation",true,true];
player setVariable ["PF_Relation",false,true];
player setVariable ["ALF_Relation",false,true];
player setVariable ["WO_Relation",false,true];
player setVariable ["RU_Relation",false,true];
player setVariable ["US_Relation",false,true];
player setVariable ["NH_Relation",false,true];
player setVariable ["TRB_Relation",false,true];
player setVariable ["RC_Relation",false,true];
player setVariable ["DT_Relation",false,true];
player setVariable ["ROA_Relation",false,true];
player setVariable ["PMC_Relation",false,true];
player setVariable ["Bandit_Relation",false,true];
player setVariable ["Renegade_Relation",false,true];
player setVariable ["wants_to_sleep", false, true];

player setVariable ["hydrationLevel", 100];
player setVariable ["nutritionLevel", 100];

sleepRequestUpdate = time;
publicVariableServer "sleepRequestUpdate";


player setVariable ["ritualStatus", 0, true];