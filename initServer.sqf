[west, -1, [
	
["Land_Plank_01_4m_F",1],
["Land_Plank_01_8m_F",1],
["Land_SandbagBarricade_01_F",1],
["Land_SandbagBarricade_01_hole_F",1],
["Land_BagBunker_Small_F",1],
["Land_BagBunker_Large_F", 1],
["Land_BagBunker_Tower_F", 1],
["Land_BagFence_Long_F",1],
["Land_BagFence_Short_F",1],
["Land_BagFence_Round_F",1],
["Land_Cargo_Patrol_V1_F",1],
["Land_Razorwire_F",1],
["Land_TentA_F",1],
["CamoNet_OPFOR_open_F",1],
["Land_Camping_Light_F",1],
["Land_PortableLight_02_double_black_F",1],
["VirtualReammoBox_small_F", 1]

]] call acex_fortify_fnc_registerObjects;

[civilian, -1, [
	
["Land_Plank_01_4m_F",1],
["Land_Plank_01_8m_F",1],
["Land_SandbagBarricade_01_F",1],
["Land_SandbagBarricade_01_hole_F",1],
["Land_BagBunker_Small_F",1],
["Land_BagBunker_Large_F", 1],
["Land_BagBunker_Tower_F", 1],
["Land_BagFence_Long_F",1],
["Land_BagFence_Short_F",1],
["Land_BagFence_Round_F",1],
["Land_Cargo_Patrol_V1_F",1],
["Land_Razorwire_F",1],
["Land_TentA_F",1],
["CamoNet_OPFOR_open_F",1],
["Land_Camping_Light_F",1],
["Land_PortableLight_02_double_black_F",1],
["VirtualReammoBox_small_F", 1]

]] call acex_fortify_fnc_registerObjects;

waitUntil { !isNil { missionNamespace getVariable "FN_spawnGarbageLootServer" } };
waitUntil { !isNil { missionNamespace getVariable "garbageCollection" } };

// Set up event-driven sleep system
sleepRequestUpdate = 0;
"sleepRequestUpdate" addPublicVariableEventHandler { [] spawn (missionNamespace getVariable "sleepTime"); };
addMissionEventHandler ["PlayerConnected", {
    [] spawn (missionNamespace getVariable "sleepTime");
}];
addMissionEventHandler ["PlayerDisconnected", {
    [] spawn (missionNamespace getVariable "sleepTime");
}];

[] spawn (missionNamespace getVariable "FN_spawnGarbageLootServer");

// Start the garbage collection script
[false] spawn (missionNamespace getVariable "garbageCollection");

sideEmpty setFriend [west, 0];
sideEmpty setFriend [east, 0];
sideEmpty setFriend [resistance, 0];

west setFriend [civilian, 0];
east setFriend [civilian, 0];
resistance setFriend [civilian, 0];
civilian setFriend [west, 0];
civilian setFriend [east, 0];
civilian setFriend [independent, 0];
civilian setFriend [civilian, 1];


[] spawn {
	private _isNight = sunOrMoon < 1;

	while {true} do {
		waitUntil {
			sleep 1;
			private _currentIsNight = sunOrMoon < 1;
			_currentIsNight != _isNight
		};

		_isNight = !_isNight;

		if (_isNight) then {
			setTimeMultiplier 20; // Night speed
		} else {
			setTimeMultiplier 12; // Day speed
		};
	};
};