params ["_container", "_caller", "_actionId"];
[_container, ["Purchase Primary Compatible Magazine: $10", "Economy System\functions\FN_PurchaseMag.sqf",[0, 10],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase Secondary Compatible Magazine: $5", "Economy System\functions\FN_PurchaseMag.sqf",[2, 5],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase Launcher Compatible Magazine: $30", "Economy System\functions\FN_PurchaseMag.sqf",[1, 30],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase GL ROUND: $10", "Economy System\functions\FN_PurchaseItem.sqf", ["1Rnd_HE_Grenade_shell",10],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase 3 HE GL ROUND: $15", "Economy System\functions\FN_PurchaseItem.sqf", ["3Rnd_HE_Grenade_shell",15],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase VOG-25 (RUS): $10", "Economy System\functions\FN_PurchaseItem.sqf", ["rhs_VOG25",10],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];