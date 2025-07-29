params ["_container", "_caller", "_actionId"];
[_container, ["Purchase BINOCULARS: $5", "Economy System\functions\FN_PurchaseItem.sqf", ["Binocular",5],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase LAZER DESIGNATOR: $100", "Economy System\functions\FN_PurchaseItem.sqf", ["Laserdesignator_03",100],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];
[_container, ["Purchase RANGEFINDER: $100", "Economy System\functions\FN_PurchaseItem.sqf", ["Rangefinder",100],1.5,true,false,"","true",3]] remoteExec ['addAction', 0, _container];