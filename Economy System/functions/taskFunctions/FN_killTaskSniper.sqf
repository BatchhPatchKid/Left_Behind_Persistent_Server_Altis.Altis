params ["_container", "_caller", "_actionId"];
if (isNull (currentTask _caller)) then {
	hintSilent format ["The rogue sniper has a bounty put on them. Eliminate them for a reward, %1", (name _caller)];
	_minDist = 1000;
	_maxDist = 2500;
	_pos = [getPos _caller, _minDist, _maxDist, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	
	//keeps everything within 500 meters from despawning
	_stoneSaver = "Land_BluntStone_01" createVehicle _pos;
	
	_sniperGrp = createGroup independent;
	_newAI = _sniperGrp createUnit ["I_G_Survivor_F",_pos,[],15,"NONE"];
	
	_newAI addGoggles (selectRandom ["G_Balaclava_oli","G_Balaclava_TI_blk_F","G_Balaclava_TI_G_blk_F","G_Balaclava_TI_tna_F","G_Balaclava_TI_G_tna_F","G_Balaclava_blk","G_Balaclava_lowprofile"]);
	_newAI addUniform (selectRandom ["U_FRITH_RUIN_SDR_snip_crow","U_FRITH_RUIN_SDR_snip_hawk","U_FRITH_RUIN_SDR_snip_bld","U_FRITH_RUIN_SDR_snip_crow","U_FRITH_RUIN_SDR_snip_hawk","U_FRITH_RUIN_SDR_snip_bld","U_FRITH_RUIN_SDR_snip_crow","U_FRITH_RUIN_SDR_snip_hawk","U_FRITH_RUIN_SDR_snip_bld","U_FRITH_RUIN_SDR_snip_crow","U_FRITH_RUIN_SDR_snip_hawk","U_FRITH_RUIN_SDR_snip_bld","U_FRITH_RUIN_SDR_snip_crow","U_FRITH_RUIN_SDR_snip_hawk","U_FRITH_RUIN_SDR_snip_bld","U_FRITH_RUIN_SDR_snip_crow","U_FRITH_RUIN_SDR_snip_hawk","U_FRITH_RUIN_SDR_snip_bld","U_FRITH_RUIN_SDR_snip_crow","U_FRITH_RUIN_SDR_snip_hawk","U_FRITH_RUIN_SDR_snip_bld","U_I_FullGhillie_ard","U_O_FullGhillie_ard","U_B_FullGhillie_ard","U_O_T_FullGhillie_tna_F","U_B_T_FullGhillie_tna_F","U_I_FullGhillie_lsh","U_O_FullGhillie_lsh","U_B_FullGhillie_lsh","U_I_FullGhillie_sard","U_O_FullGhillie_sard","U_B_FullGhillie_sard"]);
	_newAI addVest (selectRandom ["V_SmershVest_01_radio_F","V_SmershVest_01_F"]);
	_rifle = selectRandom (["rhs_weap_svds_npz","rhs_weap_svdp_wd_npz","srifle_DMR_07_ghex_F","arifle_MXM_Black_F","arifle_MSBS65_Mark_camo_F","rhs_weap_mk17_LB","rhs_weap_sr25_ec_wd","rhs_weap_m40a5_wd","rhs_weap_m24sws_wd","rhs_weap_XM2010_sa","rhs_weap_m14_wd","rhs_weap_m14ebrri","arifle_SPAR_03_khk_F","arifle_SPAR_03_blk_F"]);
	_scope = selectRandom (["optic_MRCO","optic_MRCO","optic_MRCO","optic_MRCO","optic_DMS","optic_KHS_blk","optic_SOS","optic_AMS","rhsusf_acc_ACOG3_USMC","optic_DMS_weathered_F","optic_KHS_old","rhsusf_acc_ACOG3","rhsusf_acc_M8541_low","rhsusf_acc_ACOG_RMR"]);
	
	if (round (random 10) == 5) then { _newAI linkItem "ACE_NVG_Gen1"; };
	
	[_newAI, _rifle, 5] call BIS_fnc_addWeapon;
	_newAI addPrimaryWeaponItem _scope;
	
	[_newAI, 1, 1, 1, 1, 1, 1, 1, 1] call FN_setUnitSkills;
	
	_waypoint1 = _sniperGrp addWaypoint [([_pos, 200, 400, 5, 0, 20, 0] call BIS_fnc_findSafePos), 0];
	_waypoint1 setWaypointType "MOVE";
	_waypoint1 setWaypointBehaviour "COMBAT";
	
	_newAI setUnitPos "MIDDLE";
	
	_rndDouble = random 100;
	_rndTaskID = str (_rndDouble);

	[_caller, _rndTaskID, [format ["Eliminate the target to earn $100. The sniper will be within 500 meters of the objective marker. It does not matter if you or someone else kills him, just make sure the job gets done."], "Eliminate the Rogue Sniper", ""], _pos, "ASSIGNED", 0, true, "kill", false] call BIS_fnc_taskCreate;
	sleep 5;
	while {true} do { // Checking to see if the task has been complete
		if ((isNull (currentTask _caller))) exitWith {
			//simply leaving the loop if the player has canceled the task
			deleteVehicle _stoneSaver;
		};
		if (not alive _newAI) exitWith {
			if (isNull _newAI) then {
				[_rndTaskID,"CANCELED"] call BIS_fnc_taskSetState; 
				[_rndTaskID, true] call BIS_fnc_deleteTask;
				hintSilent "We have lost the postion of the target. Thus, the contract has been canceled.";
				sleep 5;
				hintSilent "";
			} else {
				[_rndTaskID,"SUCCEEDED"] call BIS_fnc_taskSetState; 
				[_rndTaskID, true] call BIS_fnc_deleteTask;
				hintSilent "Task has been completed, receive your reward at the contractor's office";
				for "_i" from 1 to 100 do {
					if (_caller canAddItemToBackpack "rvg_money") then {
						_caller addItemToBackpack "rvg_money"; 
						hintSilent format ["All of the amount owed to you ($%2) has been put in your backpack, %1. Good work out there.", (name _caller), 150];
					} else {
						[_container, _caller, _actionId, "rvg_money", 1, 1] call LB_fnc_ammoBoxCheck;
						hintSilent format ["It seems your backpack was full or missing %1. The remaining or full amount has been put into a ammo box at the original assigning contractors location", (name _caller)];
					};
				};
				sleep 5;
				hintSilent "";
			};
		};
		if (not alive _caller) exitWith {
			[_rndTaskID,"CANCELED"] call BIS_fnc_taskSetState; 
			[_rndTaskID, true] call BIS_fnc_deleteTask;
			hintSilent "We have lost the postion of the target. Thus, the contract has been canceled.";
			sleep 5;
			hintSilent "";
		};
		sleep 10;
		
		private _closestPlayer = objNull;
		private _minDistance = 99999; // Set a high initial value

		// Loop through all players to find the closest one
		{
			private _distance = _newAI distance _x;
			if (_distance < _minDistance) then {
				_minDistance = _distance;
				_closestPlayer = _x;
			};
		} forEach allPlayers;
		
		for "_i" from 0 to (count waypoints _sniperGrp - 1) do
		{
			deleteWaypoint [_sniperGrp, 0];
		};
		
		if (_closestPlayer distance _newAI < 300) then {
			_waypoint4 = _sniperGrp addWaypoint [(getPos _closestPlayer), 0];
			_waypoint4 setWaypointType "MOVE";
			_waypoint4 setWaypointBehaviour "COMBAT";
		} else {
			_waypoint1 = _sniperGrp addWaypoint [([_pos, 200, 400, 5, 0, 20, 0] call BIS_fnc_findSafePos), 0];
			_waypoint1 setWaypointType "MOVE";
			_waypoint1 setWaypointBehaviour "COMBAT";
		};
	};
	deleteVehicle _stoneSaver;
} else {
	hintSilent "Sorry, but it seems you already have a task assigned. Finish that one before accepting another.";
};