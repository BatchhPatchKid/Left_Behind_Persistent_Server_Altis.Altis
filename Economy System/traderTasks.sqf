params ["_container", "_caller", "_actionId", "_arguments"];

[_container, ["Accept Assassination Task on a Wandering Bounty: $80", "Economy System\functions\taskFunctions\FN_killTaskGroup.sqf", [], 1.5, true, false, "", "true", 3]] remoteExec ['addAction', 0, _container];
[_container, ["Accept Assassination Task on a Stationary Bounty: $120", "Economy System\functions\taskFunctions\FN_killTaskGroupStationary.sqf", [], 1.5, true, false, "", "true", 3]] remoteExec ['addAction', 0, _container];
[_container, ["Accept Assassination Task on a Player Survivor: $200", "Economy System\functions\taskFunctions\FN_killTaskPlayer.sqf", [], 1.5, true, false, "", "true", 3]] remoteExec ['addAction', 0, _container];
[_container, ["Accept Assassination Task for a Rogue Sniper: $100", "Economy System\functions\taskFunctions\FN_killTaskSniper.sqf", [_container], 1.5, true, false, "", "true", 3]] remoteExec ["addAction", 0, _container];
[_container, ["Accept Assassination Task on a Leaper Mutant Bounty: $200", "Economy System\functions\taskFunctions\FN_killTaskLeapers.sqf", [], 1.5, true, false, "", "true", 3]] remoteExec ['addAction', 0, _container];
[_container, ["Cancel Current Task", "Economy System\functions\taskFunctions\FN_deleteCurrentTask.sqf", [], 1.5, true, false, "", "true", 3]] remoteExec ['addAction', 0, _container];