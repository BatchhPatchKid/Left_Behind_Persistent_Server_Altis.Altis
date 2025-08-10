// Initial variable declarations

radExposure = 0;
private _cbrnSUITS = ["cbrnSuits"] call (LB_fnc_arrayReturn);
private _gasMasks = ["gasMasks"] call (LB_fnc_arrayReturn);
private _playerCBRN = 1; // lower is better
private _playerGasMask = 1; // lower is better
private _radRain = 0; // higher is better
private _isUnderRoof = false; // in-building eliminates rad rain affects
private _radObjects = [""];
private _radMultiplier = 0;
private _radWater = 0;
player setVariable ["Rad", 0, true];

FN_addRad = {
    params ["_amount"];
    radExposure = radExposure + _amount;
};

FN_radiation = {
	_handle = 0 spawn {
		_itemsPlayer = itemsWithMagazines player;
		if ("rvg_Geiger" in _itemsPlayer) then {
			player setVariable ["Rad", radExposure, true];
			if (radExposure > 50) then {
				hintSilent parseText format["<t color='#ff0000' size='1.2'>Rad Exposure: %1</t>",radExposure];
			} else {
				hintSilent parseText format["<t color='#ffffff' size='1'>Rad Exposure: %1</t>",radExposure];
			};
		} else {
			hintSilent parseText format["<t color='#ffffff' size='1.2'>Geiger Counter Required to Check</t>"];
		};
		sleep 3;
		hintSilent "";
	};
};

FN_getRadiation = {
	params ["_player"];

	radExposure;
};

getCalculatedRadExposure = {
    params ["_radMultiplier","_radRain","_radWater", "_radMutantMultiplier"];
	
	// Getting uniform of player to decrease the cold if cold weather gear is being worn or increase the cold if hot weather clothing is being worn
    playerUniform = uniform player;
    if (playerUniform in _cbrnSUITS) then { _playerCBRN = 0.3 };
    
	playerGasMask = goggles player;
	if (playerGasMask in _gasMasks) then { _playerGasMask = .75 };
	
	if (_playerGasMask < 1 AND _playerCBRN < 1) then {
		_playerCBRN = .05;
		_playerGasMask = .2;
	};
	
	_radsTaken = ((.03*_radMultiplier) + (.01*_radMutantMultiplier) + _radRain + _radWater)*(_playerGasMask*_playerCBRN);
	radExposure = radExposure + _radsTaken;
	
	_itemsPlayer = itemsWithMagazines player;
	
	if ("rvg_Geiger" in _itemsPlayer) then {
	
		if (_radsTaken > 1) then {
			[player, ["rvg_geiger_3", 100, 1]] remoteExec ["say3D"];
		};
		if (_radsTaken > .5 && _radsTaken <= 1) then {
			[player, ["rvg_geiger_0", 100, 1]] remoteExec ["say3D"];
		};
		if (_radsTaken > .1 && _radsTaken <= .5) then {
			[player, ["rvg_geiger_2", 100, 1]] remoteExec ["say3D"];
		};
		if (_radsTaken > .05 && _radsTaken <= .1) then {
			[player, ["rvg_geiger_1", 100, 1]] remoteExec ["say3D"];
		};
		
		if (radExposure > 90) then {
			if (radExposure > 100) then { player setDamage 1; };
			addCamShake [0.5, 1, 10];
			if (radExposure > 95) then {
				[format ["<t color='#ff0000' size='.5'>RAD EXPOSURE TOO GREAT, DEATH IS IMMINENT</t>"], .8, 1, 1, .3, 0, 789] spawn BIS_fnc_dynamicText;
			} else {
				[format ["<t color='#ff0000' size='.5'>DANGEROUSLY HIGH RAD EXPOSURE</t>"], .8, 1, 1, .3, 0, 789] spawn BIS_fnc_dynamicText;
			};

			if ((random 10) == 1) then {
				[player, true, 15] call ace_medical_fnc_setUnconscious;
			};
		};
	} else {
		if (radExposure > 100) then {
			if (random 1 > .85) then { player setDamage 1; };
		};
		

		if (radExposure > 90) then {
			["<t color='#ff0000' size='.5'>Your body feels like it's being cooked alive</t>", .8, 1, 1, .3, 0, 789] spawn BIS_fnc_dynamicText;
			addCamShake [0.5, 1, 10];
			if ((random 10) == 1) then {
				[player, true, 15] call ace_medical_fnc_setUnconscious;
			};
		};
	};
	//hint format ["Rad Exposure: %1, Rad Taken %6, Wearing CBRN: %2, Wearing Mask: %3, Rain: %4, Rad Multiplier: %5", radExposure,_playerCBRN,_playerGasMask,_radRain,_radMultiplier, _radsTaken];
	_radMultiplier = 0;
	radExposure;
};

getUnderBuildingStatus = {
	
	//	GET NEAREST BUILDING
	_nbuilding = nearestObjects [player, ["house"], 10];
	
	{
		if ((typeOf _x isEqualTo "Campfire_burning_F") or (typeOf _x isEqualTo "FirePlace_burning_F") or (typeOf _x isEqualTo "MetalBarrel_burning_F")) then {
			_nbuilding = _nbuilding - [_x];
		};
		sleep .01;
	} forEach _nbuilding;
	
	if (count _nbuilding > 0) then {true;} else {false;};
	
};

getRainRads = {
	if (rain > .9) then { _radRain = 0.30; };
	if (rain > .7 && rain <= .9) then { _radRain = 0.25; };
	if (rain > .5 && rain <= .7) then { _radRain = 0.20; };
	if (rain > .3 && rain <= .7) then { _radRain = 0.15; };
	if (rain > .15 && rain <= .3) then { _radRain = 0.10; };
	if (rain > 0.1 && rain <= 0.15) then { _radRain = 0.05; };
	_radRain;
};

while {true} do {
    while {alive player} do {
		_index = 0;
		_radMultiplier = 0;
		_radMutantMultiplier = 0;
		_radObjects = nearestObjects [player, ["Land_AncientStatue_02_F", "Land_AncientStatue_01_F", "Land_PalmTotem_01_F", "Land_PalmTotem_02_F", "DSA_Idol2", "DSA_Idol"], 1500];
		_radMutants = nearestObjects [player, ["RyanZombieCrawler1Opfor","RyanZombieCrawler2Opfor","RyanZombieCrawler3Opfor","RyanZombieCrawler4Opfor","RyanZombieCrawler5Opfor","RyanZombieCrawler6Opfor","RyanZombieCrawler7Opfor","RyanZombieCrawler8Opfor","RyanZombieCrawler9Opfor","RyanZombieCrawler10Opfor","RyanZombieCrawler11Opfor","RyanZombieCrawler12Opfor","RyanZombieCrawler13Opfor","RyanZombieCrawler14Opfor","RyanZombieCrawler15Opfor","RyanZombieCrawler16Opfor","RyanZombieCrawler17Opfor","RyanZombieCrawler18Opfor","RyanZombieCrawler19Opfor","RyanZombieCrawler20Opfor","RyanZombieCrawler21Opfor","RyanZombieCrawler22Opfor","RyanZombieCrawler23Opfor","RyanZombieCrawler24Opfor","RyanZombieCrawler25Opfor","RyanZombieCrawler26Opfor","RyanZombieCrawler27Opfor","RyanZombieCrawler28Opfor","RyanZombieCrawler29Opfor","RyanZombieCrawler30Opfor","RyanZombieCrawler31Opfor","RyanZombieCrawler32Opfor","RyanZombieboss1Opfor","RyanZombieboss2Opfor","RyanZombieboss3Opfor","RyanZombieboss4Opfor","RyanZombieboss5Opfor","RyanZombieboss6Opfor","RyanZombieboss7Opfor","RyanZombieboss8Opfor","RyanZombieboss9Opfor","RyanZombieboss10Opfor","RyanZombieboss11Opfor","RyanZombieboss12Opfor","RyanZombieboss13Opfor","RyanZombieboss14Opfor","RyanZombieboss15Opfor","RyanZombieboss16Opfor","RyanZombieboss17Opfor","RyanZombieboss18Opfor","RyanZombieboss19Opfor","RyanZombieboss20Opfor","RyanZombieboss21Opfor","RyanZombieboss22Opfor","RyanZombieboss23Opfor","RyanZombieboss24Opfor","RyanZombieboss25Opfor","RyanZombieboss26Opfor","RyanZombieboss27Opfor","RyanZombieboss28Opfor","RyanZombieboss29Opfor","RyanZombieboss30Opfor","RyanZombieboss31Opfor","RyanZombieboss32Opfor","RyanZombieC_man_1Opfor","RyanZombieC_man_polo_1_FOpfor","RyanZombieC_man_polo_2_FOpfor","RyanZombieC_man_polo_4_FOpfor","RyanZombieC_man_polo_5_FOpfor","RyanZombieC_man_polo_6_FOpfor","RyanZombieC_man_p_fugitive_FOpfor","RyanZombieC_man_w_worker_FOpfor","RyanZombieC_scientist_FOpfor","RyanZombieC_man_hunter_1_FOpfor","RyanZombieC_man_pilot_FOpfor","RyanZombieC_journalist_FOpfor","RyanZombieC_OrestesOpfor","RyanZombieC_NikosOpfor","RyanZombie15Opfor","RyanZombie16Opfor","RyanZombie17Opfor","RyanZombie18Opfor","RyanZombie19Opfor","RyanZombie20Opfor","RyanZombie21Opfor","RyanZombie22Opfor","RyanZombie23Opfor","RyanZombie24Opfor","RyanZombie25Opfor","RyanZombie26Opfor","RyanZombie27Opfor","RyanZombie28Opfor","RyanZombie29Opfor","RyanZombie30Opfor","RyanZombie31Opfor","RyanZombie32Opfor","RyanZombieC_man_1mediumOpfor","RyanZombieC_man_polo_1_FmediumOpfor","RyanZombieC_man_polo_2_FmediumOpfor","RyanZombieC_man_polo_4_FmediumOpfor","RyanZombieC_man_polo_5_FmediumOpfor","RyanZombieC_man_polo_6_FmediumOpfor","RyanZombieC_man_p_fugitive_FmediumOpfor","RyanZombieC_man_w_worker_FmediumOpfor","RyanZombieC_scientist_FmediumOpfor","RyanZombieC_man_hunter_1_FmediumOpfor","RyanZombieC_man_pilot_FmediumOpfor","RyanZombieC_journalist_FmediumOpfor","RyanZombieC_OrestesmediumOpfor","RyanZombieC_NikosmediumOpfor","RyanZombie15mediumOpfor","RyanZombie16mediumOpfor","RyanZombie17mediumOpfor","RyanZombie18mediumOpfor","RyanZombie19mediumOpfor","RyanZombie20mediumOpfor","RyanZombie21mediumOpfor","RyanZombie22mediumOpfor","RyanZombie23mediumOpfor","RyanZombie24mediumOpfor","RyanZombie25mediumOpfor","RyanZombie26mediumOpfor","RyanZombie27mediumOpfor","RyanZombie28mediumOpfor","RyanZombie29mediumOpfor","RyanZombie30mediumOpfor","RyanZombie31mediumOpfor","RyanZombie32mediumOpfor","RyanZombieC_man_1slowOpfor","RyanZombieC_man_polo_1_FslowOpfor","RyanZombieC_man_polo_2_FslowOpfor","RyanZombieC_man_polo_4_FslowOpfor","RyanZombieC_man_polo_5_FslowOpfor","RyanZombieC_man_polo_6_FslowOpfor","RyanZombieC_man_p_fugitive_FslowOpfor","RyanZombieC_man_w_worker_FslowOpfor","RyanZombieC_scientist_FslowOpfor","RyanZombieC_man_hunter_1_FslowOpfor","RyanZombieC_man_pilot_FslowOpfor","RyanZombieC_journalist_FslowOpfor","RyanZombieC_OrestesslowOpfor","RyanZombieC_NikosslowOpfor","RyanZombie15slowOpfor","RyanZombie16slowOpfor","RyanZombie17slowOpfor","RyanZombie18slowOpfor","RyanZombie19slowOpfor","RyanZombie20slowOpfor","RyanZombie21slowOpfor","RyanZombie22slowOpfor","RyanZombie23slowOpfor","RyanZombie24slowOpfor","RyanZombie25slowOpfor","RyanZombie26slowOpfor","RyanZombie27slowOpfor","RyanZombie28slowOpfor","RyanZombie29slowOpfor","RyanZombie30slowOpfor","RyanZombie31slowOpfor","RyanZombie32slowOpfor","RyanZombieSpider1Opfor","RyanZombieSpider2Opfor","RyanZombieSpider3Opfor","RyanZombieSpider4Opfor","RyanZombieSpider5Opfor","RyanZombieSpider6Opfor","RyanZombieSpider7Opfor","RyanZombieSpider8Opfor","RyanZombieSpider9Opfor","RyanZombieSpider10Opfor","RyanZombieSpider11Opfor","RyanZombieSpider12Opfor","RyanZombieSpider13Opfor","RyanZombieSpider14Opfor","RyanZombieSpider15Opfor","RyanZombieSpider16Opfor","RyanZombieSpider17Opfor","RyanZombieSpider18Opfor","RyanZombieSpider19Opfor","RyanZombieSpider20Opfor","RyanZombieSpider21Opfor","RyanZombieSpider22Opfor","RyanZombieSpider23Opfor","RyanZombieSpider24Opfor","RyanZombieSpider25Opfor","RyanZombieSpider26Opfor","RyanZombieSpider27Opfor","RyanZombieSpider28Opfor","RyanZombieSpider29Opfor","RyanZombieSpider30Opfor","RyanZombieSpider31Opfor","RyanZombieSpider32Opfor","Zombie_O_Crawler_NATO","Zombie_O_Shambler_NATO","Zombie_O_RA_NATO","Zombie_O_RC_NATO","Zombie_O_Shooter_NATO","Zombie_O_Walker_NATO","Zombie_O_Crawler_Civ","Zombie_O_Shambler_Civ","Zombie_O_RA_Civ","Zombie_O_RC_Civ","Zombie_O_Walker_Civ","Zombie_Special_OPFOR_Boomer","WBK_SpecialZombie_Corrupted_3","WBK_Goliaph_3","Zombie_Special_OPFOR_Leaper_1","Zombie_Special_OPFOR_Leaper_2","Zombie_Special_OPFOR_Screamer","WBK_SpecialZombie_Smasher_3","WBK_SpecialZombie_Smasher_Hellbeast_3","WBK_SpecialZombie_Smasher_Acid_3","RyanZombieC_man_1walkerOpfor","RyanZombieC_man_polo_1_FwalkerOpfor","RyanZombieC_man_polo_2_FwalkerOpfor","RyanZombieC_man_polo_4_FwalkerOpfor","RyanZombieC_man_polo_5_FwalkerOpfor","RyanZombieC_man_polo_6_FwalkerOpfor","RyanZombieC_man_p_fugitive_FwalkerOpfor","RyanZombieC_man_w_worker_FwalkerOpfor","RyanZombieC_scientist_FwalkerOpfor","RyanZombieC_man_hunter_1_FwalkerOpfor","RyanZombieC_man_pilot_FwalkerOpfor","RyanZombieC_journalist_FwalkerOpfor","RyanZombieC_OresteswalkerOpfor","RyanZombieC_NikoswalkerOpfor","RyanZombie15walkerOpfor","RyanZombie16walkerOpfor","RyanZombie17walkerOpfor","RyanZombie18walkerOpfor","RyanZombie19walkerOpfor","RyanZombie20walkerOpfor","RyanZombie21walkerOpfor","RyanZombie22walkerOpfor","RyanZombie23walkerOpfor","RyanZombie24walkerOpfor","RyanZombie25walkerOpfor","RyanZombie26walkerOpfor","RyanZombie27walkerOpfor","RyanZombie28walkerOpfor","RyanZombie29walkerOpfor","RyanZombie30walkerOpfor","RyanZombie31walkerOpfor","RyanZombie32walkerOpfor","DSA_411","DSA_Abomination","DSA_Crazy","DSA_ActiveIdol","DSA_ActiveIdol2","DSA_Hatman","DSA_Mindflayer","DSA_Rake","DSA_Shadowman","DSA_Snatcher","DSA_Vampire","DSA_Wendigo","no_legs_skinned_unit","skinned_unit","zombie_bolter","zombie_runner","zombie_walker"], 25];
		{
			private _distance = player distance _x;
			if (_distance < 1500) then {
				// Calculate the multiplier using an exponential function
				_radMultiplier = _radMultiplier + 1 + (exp((1500 - _distance) / 200) - 1) * (499 / (exp(10) - 1));
			};
			sleep 0.01;
		} forEach _radObjects;
		
		{
			private _distance = player distance _x;
			if (_distance < 25) then {
				_radMutantMultiplier = _radMutantMultiplier + 1 + (exp((25 - _distance) / 2.5) - 1) * (29 / (exp(10) - 1));
			};
			sleep .01;
		} forEach _radMutants;

		if (count _radObjects > 0) then {
			_index = _index + 1;
		};
		
		if (count _radMutants > 0) then {
			_index = _index + 1;
		};
		
		_isUnderRoof = call getUnderBuildingStatus;
		if (rain < .1) then {
			_radRain = 0;
		} else {
			if (!(_isUnderRoof)) then {
				_radRain = call getRainRads;
				_index = _index + 1;
			};
		};
		
		if (surfaceIsWater getPos player && isNull objectParent player) then { // Checking to see if the player is in water and not in a boat
            _radWater = 3; _index = _index + 1;
		} else { _radWater = 0; };
		
		//hint format["Rad Rain: %1, Water: %2, Objects: %3, Under Roof: %4, Index: %5, Rain: %6", _radRain, _radWater, _radObjects, _isUnderRoof, _index, rain];
		
		if (_index > 0) then {
			radExposure = [_radMultiplier, _radRain, _radWater, _radMutantMultiplier] call getCalculatedRadExposure;
		} else {
			if (radExposure > 0) then {
				radExposure = radExposure - 0.5;
			} else { radExposure = 0 };
		};
		
		private _radValue = player getVariable ["Rad", 0];
		
		if (_radValue >= 100) then {
			[_radMultiplier, _radRain, _radWater, _radMutantMultiplier] call getCalculatedRadExposure;
		};
		
		sleep 5;
    };
    // Once the player dies, reset the variables
    radExposure = 0;
    _playerCBRN = 1; // lower is better
    _radRain = 0; // higher = more rads
    _isUnderRoof = false;
    sleep 5;
};