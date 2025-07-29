params ["_container", "_caller", "_actionId"];
[_container, ["Purchase CHEMLIGHT HI GREEN: $3", "Economy System\functions\FN_PurchaseItem.sqf", ["ACE_Chemlight_HiGreen",3],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase HAND HELD SIGNAL (RED): $5", "Economy System\functions\FN_PurchaseItem.sqf", ["ACE_HandFlare_Red",5],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase M18 BLUE SMOKE: $10", "Economy System\functions\FN_PurchaseItem.sqf", ["SmokeShellBlue",10],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase M67 FRAG GRENADE: $20", "Economy System\functions\FN_PurchaseItem.sqf", ["HandGrenade",20],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase V40 MINI GRENADE: $15", "Economy System\functions\FN_PurchaseItem.sqf", ["MiniGrenade",15],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];