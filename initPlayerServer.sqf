params ["_player", "_didJIP"];

_player setVariable ["SU_Relation",true,true];
_player setVariable ["BB_Relation",true,true];
_player setVariable ["PF_Relation",false,true];
_player setVariable ["ALF_Relation",false,true];
_player setVariable ["WO_Relation",false,true];
_player setVariable ["RU_Relation",false,true];
_player setVariable ["US_Relation",false,true];
_player setVariable ["NH_Relation",false,true];
_player setVariable ["TRB_Relation",false,true];
_player setVariable ["RC_Relation",false,true];
_player setVariable ["DT_Relation",false,true];
_player setVariable ["ROA_Relation",false,true];
_player setVariable ["PMC_Relation",false,true];
_player setVariable ["Bandit_Relation",false,true];
_player setVariable ["Renegade_Relation",false,true];
_player setVariable ["wants_to_sleep", false, true];

sleepRequestUpdate = time;
publicVariableServer "sleepRequestUpdate";

_player setVariable ["ritualStatusPig", 0, true];
_player setVariable ["ritualStatusZeus", 0, true];
_player setVariable ["ritualStatusWanderer", 0, true];