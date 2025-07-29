params ["_container", "_caller", "_actionId"];
removeAllActions _container;
//Tasks
[_container, ["ACCESS TASK CATALOGUE", "Economy System\traderTasks.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];

//Selling
[_container, ["Sell Items to Trader", "Economy System\functions\FN_SellAction.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];

//Purchasing
[_container, ["--------------PURCHASING MENU--------------",{},[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS CLOTHING CATALOGUE", "Economy System\functions\actionFunctions\FN_clothing.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS CHEST RIG CATALOGUE", "Economy System\functions\actionFunctions\FN_chestRig.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS BACKPACK CATALOGUE", "Economy System\functions\actionFunctions\FN_backPack.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS PRIMARY WEAPON CATALOGUE", "Economy System\functions\actionFunctions\FN_primary.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS SIDEARM CATALOGUE", "Economy System\functions\actionFunctions\FN_sidearms.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS LAUNCHER CATALOGUE", "Economy System\functions\actionFunctions\FN_launchers.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS AMMO CATALOGUE", "Economy System\functions\actionFunctions\FN_mags.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS OPTIC CATALOGUE", "Economy System\functions\actionFunctions\FN_optics.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS RAIL ATTACHMENT CATALOGUE", "Economy System\functions\actionFunctions\FN_rail.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS MUZZLE ATTACHMENT CATALOGUE", "Economy System\functions\actionFunctions\FN_muzzle.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS UNDERRAIL ATTACHMENT CATALOGUE", "Economy System\functions\actionFunctions\FN_UNDERRAIL.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS GRENADES CATALOGUE", "Economy System\functions\actionFunctions\FN_GRENADES.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS EXPLOSIVES CATALOGUE", "Economy System\functions\actionFunctions\FN_EXPLOSIVE.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS NVG CATALOGUE", "Economy System\functions\actionFunctions\FN_NVG.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS BINO CATALOGUE", "Economy System\functions\actionFunctions\FN_BINO.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["ACCESS MISC. CATALOGUE", "Economy System\functions\actionFunctions\FN_MISC.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];

//Reset Menu
[_container, ["RESET CATALOGUES", "Economy System\functions\actionFunctions\FN_ResetMenu.sqf",[],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];