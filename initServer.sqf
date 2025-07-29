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

execVM "Server Ran Scripts\garbageCollection.sqf";
execVM "Server Ran Scripts\factionClothingChecker.sqf";

Civilian setFriend [WEST,0];
WEST setFriend [Civilian ,0];

Civilian setFriend [EAST,0];
EAST setFriend [Civilian ,0];

Civilian setFriend [RESISTANCE,0];
RESISTANCE setFriend [Civilian ,0];

while {true} do {
	// Wait until it gets dark
	waitUntil {
		sunOrMoon < 1;
	};
	setTimeMultiplier 20; // Change the time multiplier
    
	// Wait until the sun shines again
	waitUntil {
		sunOrMoon isEqualTo 1;
	};
	setTimeMultiplier 12; // Change the time multiplier
	uiSleep 30;
};