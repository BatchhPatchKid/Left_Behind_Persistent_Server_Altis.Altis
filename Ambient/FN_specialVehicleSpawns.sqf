params ["_trigger", "_type"];

_activate = true;

{ //checking to see if a player see if any players are too close to the spawn area of the trigger
	if ((getPos _x) distance (getPos _trigger) < (((triggerArea _trigger) select 0) - 50)) then { 
		activate = false;
		break;
	};
} forEach allPlayers;

if (_activate and isServer) then {
	switch (_type) do {
		case "sea": {
			if (random 1 > 0.25) then {
			
				_boat = "";
				
				_boatArray = ["B_G_Boat_Transport_01_F", .75,
					"C_Boat_Civil_01_F", .65,
					"C_Boat_Transport_02_F", .25,
					"C_Scooter_Transport_01_F", .90,
					"C_Rubberboat", .60,
					"I_Boat_Armed_01_minigun_F", .01,
					"I_Boat_Transport_01_F", .15,
					"I_C_Boat_Transport_02_F", .15,
					"O_Boat_Armed_01_hmg_F", .01];
				
				_boat = (_boatArray call BIS_fnc_selectRandomWeighted) createVehicle (getPos _trigger);
				
				_boat setDir (random 360);
			
				clearWeaponCargoGlobal _boat;
				clearMagazineCargoGlobal _boat;
				clearItemCargoGlobal _boat;
				
				_boat setFuel (random [.05, .15, .35]);
			};
		};
		case "air": {
			if (random 1 > 0.98) then {
				_airArray = ["B_CTRG_Heli_Transport_01_sand_F", .001,
					"B_Heli_Light_01_dynamicLoadout_F", .001,
					"B_Heli_Transport_03_F", .001,
					"B_Heli_Transport_03_unarmed_F", .005,
					"B_Heli_Light_01_F", .005,
					"B_Heli_Attack_01_dynamicLoadout_F", .001,
					"B_Heli_Transport_01_F", .001,
					"O_Heli_Light_02_dynamicLoadout_F", .001,
					"O_Heli_Light_02_unarmed_F", .01,
					"O_Heli_Transport_04_F", .001,
					"O_Heli_Transport_04_bench_F", .005,
					"O_Heli_Transport_04_fuel_F", .001,
					"O_Heli_Transport_04_covered_F", .001,
					"O_Heli_Attack_02_dynamicLoadout_F", .001,
					"I_Heli_Transport_02_F", .01,
					"I_Heli_light_03_dynamicLoadout_F", .001,
					"I_Heli_light_03_unarmed_F", .005,
					"I_E_Heli_light_03_dynamicLoadout_F", .001,
					"I_E_Heli_light_03_unarmed_F", .005,
					"I_C_Heli_Light_01_civil_F", .001,
					"C_Heli_Light_01_civil_F", .05,
					"C_IDAP_Heli_Transport_02_F", .15];
				
				_air = (_airArray call BIS_fnc_selectRandomWeighted) createVehicle (getPos _trigger);
				
				_air setDir (random 360);
			
				clearWeaponCargoGlobal _air;
				clearMagazineCargoGlobal _air;
				clearItemCargoGlobal _air;
				
				{
					_air setHitPointDamage [_x, (random [.5, .65, .85])];
				} forEach ["HitEngine","HitFuel","HitHRotor","HitVRotor","HitHull"];
				
				_air setFuel (random [.01, .05, .25]);
				
				["Leaper", 3, 100, (getPos _trigger)] execVM "AISpawners\aiSubScripts\factionSelector.sqf";
			};
		};
		case "plane": {
			if (random 1 > 0.95) then {
				_planeArray = ["C_Plane_Civil_01_F", .55,
					"C_Plane_Civil_01_racing_F", .50,
					"I_Plane_Fighter_04_F", .001,
					"I_Plane_Fighter_03_dynamicLoadout_F", .001,
					"O_Plane_Fighter_02_F", .001,
					"O_Plane_Fighter_02_Stealth_F", .001,
					"O_Plane_CAS_02_dynamicLoadout_F", .001,
					"B_Plane_CAS_01_dynamicLoadout_F", .001,
					"B_Plane_Fighter_01_F", .001,
					"B_Plane_Fighter_01_Stealth_F", .001,
					"B_T_VTOL_01_armed_F", .001,
					"B_T_VTOL_01_infantry_F", .005,
					"B_T_VTOL_01_vehicle_F", .001];
				
				_plane = (_planeArray call BIS_fnc_selectRandomWeighted) createVehicle (getPos _trigger);
				
				_plane setDir (random 360);
			
				clearWeaponCargoGlobal _plane;
				clearMagazineCargoGlobal _plane;
				clearItemCargoGlobal _plane;
				
				{
					_plane setHitPointDamage [_x, (random [.5, .65, .85])];
				} forEach ["HitEngine","HitFuel","HitHRotor","HitVRotor","HitHull"];
				
				_plane setFuel (random [.01, .05, .25]);
				
				["Leaper", 5, 100, _pos] execVM "AISpawners\aiSubScripts\factionSelector.sqf";
			};
		};			
	};
};