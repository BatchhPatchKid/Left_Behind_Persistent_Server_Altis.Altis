params ["_faction","_unit","_melee","_primaryOverride", "_sfOverride"];

money = false;
nvg= false;
primary = false;
secondary = true;
optics = false;
muzzle = false;
firstAid = false;
water = false;
food = false;
rocket = false;
rndShitAmount = 3;
railAttachment = false;
grenades = false;
_map = false;
_compass = false;
_watch = false;
_radio = false;
_gps = false;

//Basic Selection of gear
_headgearArraySelection = ["headgearCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_facewearArraySelection = ["facewearCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_uniformArraySelection = ["uniformCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_vestArraySelection = ["vestCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_backpackArraySelection = ["backpackCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_rifleArraySelection = ["primaryCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_handgunArraySelection = ["handgunCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_launcherArraySelection = ["launcherCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_rndShitArraySelection = ["randomCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_opticsArraySelection = ["opticsCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_muzzleArraySelection = ["muzzleCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_railArraySelection = ["bipodCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_nvgSelection = ["nvgCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_waterSelection = ["waterCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_foodSelection = ["foodCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_meleeSelection = ["meleeCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_firstAidSelection = ["medicalCommon"] call (missionNamespace getVariable "FN_arrayReturn");
_glWeapons = ["glWeapons"] call (missionNamespace getVariable "FN_arrayReturn");
_grenades = ["grenades"] call (missionNamespace getVariable "FN_arrayReturn");
_gpsArraySelection = ["DSA_Detector",.15,"ItemGPS",1];
_radioArraySelection = ["radios"] call (missionNamespace getVariable "FN_arrayReturn");

//Rare Items
_rareNVG = ["nvgRare"] call (missionNamespace getVariable "FN_arrayReturn");
_headgearArraySelectionRare = ["headgearRare"] call (missionNamespace getVariable "FN_arrayReturn");
_vestArraySelectionRare = ["vestRare"] call (missionNamespace getVariable "FN_arrayReturn");
_backpackArraySelectionRare = ["backpackRare"] call (missionNamespace getVariable "FN_arrayReturn");
_rifleArraySelectionRare = ["primaryRare"] call (missionNamespace getVariable "FN_arrayReturn");
_handgunArraySelectionRare = ["handgunRare"] call (missionNamespace getVariable "FN_arrayReturn");
_opticsArraySelectionRare = ["opticsRare"] call (missionNamespace getVariable "FN_arrayReturn");
_muzzleArraySelectionRare = ["muzzleRare"] call (missionNamespace getVariable "FN_arrayReturn");
_railArraySelectionRare = ["railRare"] call (missionNamespace getVariable "FN_arrayReturn");
_uniformArraySelectionRare = ["uniformRare"] call (missionNamespace getVariable "FN_arrayReturn");

switch _faction do {
	case "Bandit": {
		_facewearArraySelection = ["facewearBandit"] call (missionNamespace getVariable "FN_arrayReturn");
		firstAid = (random 5 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		money = (random 5 < 1);
		nvg = (random 300 < 1);
		rocket = (random 300 < 1);
		primary = (random 3 < 1);
		optics = (random 15 < 1);
		muzzle = (random 10 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 155 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 155 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 155 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 170 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 175 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 185 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 100 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 600 < 1) then {_nvgSelection = _rareNVG;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 50 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 14 < 1);
			nvg = (random 20 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = (random 6 < 1);
			railAttachment = (random 6 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 50 < 1);
			
			_headgearArraySelection = ["headgearBandit_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestBandit_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "Renegade": {
		_headgearArraySelection = ["headgearRenegade"] call (missionNamespace getVariable "FN_arrayReturn");
		_uniformArraySelection = ["uniformRenegade"] call (missionNamespace getVariable "FN_arrayReturn");
		_facewearArraySelection = ["facewearRenegade"] call (missionNamespace getVariable "FN_arrayReturn");
		firstAid = (random 5 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		money = (random 5 < 1);
		grenades = (random 10 < 1);
		primary = TRUE;
		
		rndShitAmount = random [1, 2, 5];
	};
	case "BB": {
		_headgearArraySelection = ["headgearBB"] call (missionNamespace getVariable "FN_arrayReturn");
		_facewearArraySelection = ["facewearSU"] call (missionNamespace getVariable "FN_arrayReturn");
		_meleeSelection = ["meleeBB"] call (missionNamespace getVariable "FN_arrayReturn");
		_rifleArraySelection= ["rifleBB"] call (missionNamespace getVariable "FN_arrayReturn");
		firstAid = (random 5 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		money = (random 5 < 1);
		nvg = (random 300 < 1);
		rocket = (random 300 < 1);
		primary = true;
		optics = (random 20 < 1);
		muzzle = (random 15 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		if (random 155 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 155 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 170 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 175 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 185 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 165 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 50 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = (random 6 < 1);
			railAttachment = (random 6 < 1);
			nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 50 < 1);
			
			_vestArraySelection = ["vestBB_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["rifleBB_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_opticsArraySelection = ["opticsBB_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_muzzleArraySelection = ["muzzleBB_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_uniformArraySelection = ["uniformBB_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	}; 
	case "DT": {
		_headgearArraySelection = ["headgearDT"] call (missionNamespace getVariable "FN_arrayReturn");
		_facewearArraySelection = ["facewearDT"] call (missionNamespace getVariable "FN_arrayReturn");
		firstAid = (random 5 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		money = (random 6 < 1);
		nvg = (random 300 < 1);
		rocket = (random 300 < 1);
		primary = (random 4 < 1);
		optics = (random 30 < 1);
		muzzle = (random 25 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 20 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 600 < 1) then {_nvgSelection = _rareNVG;};
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 50 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = (random 6 < 1);
			muzzle = (random 10 < 1);
			railAttachment = (random 6 < 1);
			nvg = (random 20 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 70 < 1);
			
			_facewearArraySelection = ["facewearDT_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestBandit_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["rifleDT_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_opticsArraySelection = ["opticsDT_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_muzzleArraySelection = ["muzzleDT_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "NH": {
		_headgearArraySelection = ["headgearNH"] call (missionNamespace getVariable "FN_arrayReturn");
		_facewearArraySelection = ["facewearNH"] call (missionNamespace getVariable "FN_arrayReturn");
		if (random 600 < 1) then {_nvgSelection = _rareNVG;};
		firstAid = (random 5 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		money = (random 6 < 1);
		nvg = (random 300 < 1);
		rocket = (random 300 < 1);
		primary = (random 3 < 1);
		optics = (random 30 < 1);
		muzzle = (random 25 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 17 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 50 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = (random 6 < 1);
			railAttachment = (random 6 < 1);
			nvg = (random 20 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 60 < 1);
			
			_facewearArraySelection = ["facewearNH_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestBandit_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["rifleNH_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_opticsArraySelection = ["opticsNH_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_muzzleArraySelection = ["muzzleNH_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "PF": {
		_headgearArraySelection = ["headgearPF"] call (missionNamespace getVariable "FN_arrayReturn");
		_uniformArraySelection = ["uniformPF"] call (missionNamespace getVariable "FN_arrayReturn");
		_meleeSelection = ["meleePF"] call (missionNamespace getVariable "FN_arrayReturn");
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		firstAid = (random 5 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		money = (random 6 < 1);
		nvg = (random 300 < 1);
		rocket = (random 250 < 1);
		primary = (random 2 < 1);
		optics = (random 30 < 1);
		muzzle = (random 25 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 7 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 30 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = (random 6 < 1);
			railAttachment = (random 6 < 1);
			nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 60 < 1);
			
			_headgearArraySelection = ["headgearPF_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestPF_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["riflePF_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "RC": {
		_headgearArraySelection = ["headgearRC"] call (missionNamespace getVariable "FN_arrayReturn");
		_facewearArraySelection = ["facewearRC"] call (missionNamespace getVariable "FN_arrayReturn");
		_vestArraySelection = ["vestRC"] call (missionNamespace getVariable "FN_arrayReturn");
		_meleeSelection = ["meleeRC"] call (missionNamespace getVariable "FN_arrayReturn");
		_uniformArraySelection = ["uniformRC"] call (missionNamespace getVariable "FN_arrayReturn");
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		firstAid = (random 4 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		money = (random 4 < 1);
		nvg = (random 250 < 1);
		rocket = (random 250 < 1);
		primary = true;
		optics = (random 5 < 1);
		muzzle = (random 15 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 70 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 150 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 150 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 145 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 150 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 155 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 165 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 150 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 40 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = (random 6 < 1);
			railAttachment = (random 6 < 1);
			nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 40 < 1);
			
			_headgearArraySelection = ["headgearRC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_uniformArraySelection = ["uniformRC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestRC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["rifleRC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_opticsArraySelection = ["opticsRC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_muzzleArraySelection = ["muzzleRC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "TRB": {
		_facewearArraySelection = ["facewearTRB"] call (missionNamespace getVariable "FN_arrayReturn");
		_uniformArraySelection = ["uniformTRB"] call (missionNamespace getVariable "FN_arrayReturn");
		_rifleArraySelection = ["rifleTRB"] call (missionNamespace getVariable "FN_arrayReturn");
		_headgearArraySelection = ["headgearTRB"] call (missionNamespace getVariable "FN_arrayReturn");
		_meleeSelection = ["meleeTRB"] call (missionNamespace getVariable "FN_arrayReturn");
		_opticsArraySelection = ["russianOptic"] call (missionNamespace getVariable "FN_arrayReturn");
		_muzzleArraySelection = ["russianMuzzle"] call (missionNamespace getVariable "FN_arrayReturn");
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		firstAid = (random 4 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		money = (random 4 < 1);
		nvg = (random 250 < 1);
		rocket = (random 250 < 1);
		primary = true;
		optics = (random 10 < 1);
		muzzle = (random 10 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 60 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 160 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 160 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 150 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 170 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 175 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 185 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 165 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 30 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = (random 6 < 1);
			railAttachment = (random 6 < 1);
			nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 40 < 1);
			
			_headgearArraySelection = ["headgearTRB_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestTRB_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["rifleTRB_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "US": {
		_headgearArraySelection = ["headgearUS"] call (missionNamespace getVariable "FN_arrayReturn");
		_facewearArraySelection = ["facewearUS"] call (missionNamespace getVariable "FN_arrayReturn");
		_uniformArraySelection = ["uniformUS"] call (missionNamespace getVariable "FN_arrayReturn");
		_vestArraySelection = ["vestUS"] call (missionNamespace getVariable "FN_arrayReturn");
		_backpackArraySelection = ["backpackUS"] call (missionNamespace getVariable "FN_arrayReturn");
		_rifleArraySelection = ["rifleUS"] call (missionNamespace getVariable "FN_arrayReturn");
		_handgunArraySelection = ["handgunUS"] call (missionNamespace getVariable "FN_arrayReturn");
		_launcherArraySelection = ["launcherUS"] call (missionNamespace getVariable "FN_arrayReturn");
		firstAid = (random 3 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		if (random 300 < 1) then {_nvgSelection = _rareNVG;};
		money = (random 2 < 1);
		nvg = (random 150 < 1);
		rocket = (random 150 < 1);
		primary = true;
		optics = (random 2 < 1);
		muzzle = (random 10 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 5 < 1);
		_map = (random 3 < 1);
		_compass = true;
		_watch = true;
		_radio = true;
		_gps = (random 10 < 1);
		
		if (random 45 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 55 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 35 < 1) then {_railArraySelection = _railArraySelectionRare;};
		
		//Ranger
		if (random 10 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = true;
			railAttachment = true;
			nvg = true;
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = true;
			
			_uniformArraySelection = ["uniformUS_Ranger_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_headgearArraySelection = ["headgearUS_Ranger_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestUS_Ranger_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["rifleUS_Ranger_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_opticsArraySelection = ["opticsUS_Ranger_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_muzzleArraySelection = ["muzzleUS_Ranger_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
		//marine
		//sniper
	};
	case "SU": {
		_facewearArraySelection = ["facewearSU"] call (missionNamespace getVariable "FN_arrayReturn");
		_uniformArraySelection = ["uniformSU"] call (missionNamespace getVariable "FN_arrayReturn");
		firstAid = (random 5 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		if (random 600 < 1) then {_nvgSelection = _rareNVG;};
		money = (random 4 < 1);
		nvg = (random 300 < 1);
		rocket = (random 300 < 1);
		primary = true;
		optics = (random 3 < 1);
		muzzle = (random 25 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 20 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 50 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = (random 6 < 1);
			railAttachment = (random 6 < 1);
			nvg = (random 20 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 50 < 1);
			
			_headgearArraySelection = ["headgearSU_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestSU_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["rifleSU_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
case "RU": {
	_headgearArraySelection = ["headgearRU"] call (missionNamespace getVariable "FN_arrayReturn");
	_uniformArraySelection = ["uniformRU"] call (missionNamespace getVariable "FN_arrayReturn");
	_vestArraySelection = ["vestRU"] call (missionNamespace getVariable "FN_arrayReturn");
	_backpackArraySelection = ["backpackRU"] call (missionNamespace getVariable "FN_arrayReturn");
	_rifleArraySelection = ["rifleRU"] call (missionNamespace getVariable "FN_arrayReturn");
	_handgunArraySelection = ["handgunRU"] call (missionNamespace getVariable "FN_arrayReturn");
	_launcherArraySelection = ["launcherRU"] call (missionNamespace getVariable "FN_arrayReturn");
	_muzzleArraySelection = ["muzzleRU"] call (missionNamespace getVariable "FN_arrayReturn");
	_opticsArraySelection = ["russianOptic"] call (missionNamespace getVariable "FN_arrayReturn");
	_muzzleArraySelection = ["russianMuzzle"] call (missionNamespace getVariable "FN_arrayReturn");
	_facewearArraySelection = ["facewearRU"] call (missionNamespace getVariable "FN_arrayReturn");
	firstAid = (random 3 < 1);
	water = (random 16 < 1);
	food = (random 20 < 1);
	if (random 360 < 1) then {_nvgSelection = _rareNVG;};
	money = (random 4 < 1);
	nvg = (random 180 < 1);
	rocket = (random 180 < 1);
	primary = true;
	optics = true;
	muzzle = (random 7 < 1);
	railAttachment = (random 20 < 1);
	grenades = (random 8 < 1);
	_map = (random 5 < 1);
	_compass = true;
	_watch = true;
	_radio = true;
	_gps = (random 20 < 1);
	
	rndShitAmount = random [1, 2, 5];
	if (random 145 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
	if (random 140 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
	if (random 135 < 1) then {_railArraySelection = _railArraySelectionRare;};
	
	if (random 15 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
		firstAid = true;
		water = true;
		food = true;
		money = true;
		rocket = (random 30 < 1);
		primary = true;
		secondary= false;
		optics = true;
		muzzle = true;
		railAttachment = true;
		nvg = true;
		_map = true;
		_compass = true;
		_watch = true;
		_radio = true;
		_gps = (random 3 < 1);
		
		_uniformArraySelection = ["uniformRU_SF"] call (missionNamespace getVariable "FN_arrayReturn");
		_rifleArraySelection = ["rifleRU_SF"] call (missionNamespace getVariable "FN_arrayReturn");
		_headgearArraySelection = ["headgearRU_SF"] call (missionNamespace getVariable "FN_arrayReturn");
		_vestArraySelection = ["vestRU_SF"] call (missionNamespace getVariable "FN_arrayReturn");
		_muzzleArraySelection = ["muzzleRU_SF"] call (missionNamespace getVariable "FN_arrayReturn");
		
		if (random 3 < 1) then {
			_railArraySelection = _railArraySelectionRare;
		};
	};
};
	case "ROA": {
		_facewearArraySelection = ["facewearROA"] call (missionNamespace getVariable "FN_arrayReturn");
		_uniformArraySelection = ["uniformROA"] call (missionNamespace getVariable "FN_arrayReturn");
		_vestArraySelection = ["vestROA"] call (missionNamespace getVariable "FN_arrayReturn");
		_rifleArraySelection = ["rifleROA"] call (missionNamespace getVariable "FN_arrayReturn");
		_headgearArraySelection = ["headgearROA"] call (missionNamespace getVariable "FN_arrayReturn");
		_muzzleArraySelection = ["muzzleROA_SF"] call (missionNamespace getVariable "FN_arrayReturn");

		firstAid = (random 3 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		if (random 400 < 1) then {_nvgSelection = _rareNVG;};
		money = (random 4 < 1);
		nvg = (random 200 < 1);
		rocket = (random 200 < 1);
		primary = true;
		optics = (random 2 < 1);
		muzzle = (random 5 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 20 < 1);
		_map = true;
		_compass = true;
		_watch = true;
		_radio = true;
		_gps = (random 30 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 20 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = (random 3 < 1);
			railAttachment = (random 6 < 1);
			nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 8 < 1);
			
			_headgearArraySelection = ["headgearROA_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestROA_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "PMC": {
		_headgearArraySelection = ["headgearPMC"] call (missionNamespace getVariable "FN_arrayReturn");
		_facewearArraySelection = ["facewearPMC"] call (missionNamespace getVariable "FN_arrayReturn");
		_uniformArraySelection = ["uniformPMC"] call (missionNamespace getVariable "FN_arrayReturn");
		_vestArraySelection = ["vestPMC"] call (missionNamespace getVariable "FN_arrayReturn");
		_rifleArraySelection = ["riflePMC"] call (missionNamespace getVariable "FN_arrayReturn");
		_opticsArraySelection = ["russianOptic"] call (missionNamespace getVariable "FN_arrayReturn");
		_muzzleArraySelection = ["rhs_acc_tgpa", 1];
		_railArraySelection = ["rhs_acc_grip_rk6", 1];
		firstAid = (random 3 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		if (random 400 < 1) then {_nvgSelection = _rareNVG;};
		money = (random 4 < 1);
		nvg = (random 200 < 1);
		rocket = (random 200 < 1);
		primary = true;
		optics = (random 2 < 1);
		muzzle = true;
		railAttachment = (random 20 < 1);
		grenades = (random 20 < 1);
		_map = true;
		_compass = true;
		_watch = true;
		_radio = true;
		_gps = (random 5 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 20 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = true;
			railAttachment = true;
			nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 5 < 1);
			
			_facewearArraySelection = ["facewearPMC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_uniformArraySelection = ["uniformPMC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["riflePMC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_muzzleArraySelection = ["muzzlePMC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_opticsArraySelection = ["opticsPMC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestPMC_SF"] call (missionNamespace getVariable "FN_arrayReturn");
		};
	};
	case "WO": {
		_headgearArraySelection = ["headgearWO"] call (missionNamespace getVariable "FN_arrayReturn");
		_facewearArraySelection = ["facewearWO"] call (missionNamespace getVariable "FN_arrayReturn");
		_uniformArraySelection = ["uniformWO"] call (missionNamespace getVariable "FN_arrayReturn");
		_vestArraySelection = ["vestWO"] call (missionNamespace getVariable "FN_arrayReturn");
		_rifleArraySelection = ["rifleWO"] call (missionNamespace getVariable "FN_arrayReturn");
		_backpackArraySelection = ["backpackWO"] call (missionNamespace getVariable "FN_arrayReturn");
		_meleeSelection = ["meleeWO"] call (missionNamespace getVariable "FN_arrayReturn");
		firstAid = (random 4 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		money = (random 4 < 1);
		nvg = (random 250 < 1);
		rocket = (random 250 < 1);
		primary = (random 2 < 1);
		optics = (random 10 < 1);
		muzzle = (random 25 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 4 < 1);
		_gps = (random 70 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 40 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = (random 6 < 1);
			railAttachment = (random 6 < 1);
			nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 45 < 1);
			
			_headgearArraySelection = ["headgearWO_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestWO_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["rifleWO_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_opticsArraySelection = ["opticsWO_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_muzzleArraySelection = ["muzzleWO_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "ALF": {
		_uniformArraySelection = ["uniformALF"] call (missionNamespace getVariable "FN_arrayReturn");
		_vestArraySelection = ["vestALF"] call (missionNamespace getVariable "FN_arrayReturn");
		_rifleArraySelection = ["rifleALF"] call (missionNamespace getVariable "FN_arrayReturn");
		_headgearArraySelection = ["headgearALF"] call (missionNamespace getVariable "FN_arrayReturn");
		_facewearArraySelection = ["facewearALF"] call (missionNamespace getVariable "FN_arrayReturn");
		firstAid = (random 4 < 1);
		water = (random 16 < 1);
		food = (random 20 < 1);
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		money = (random 4 < 1);
		nvg = (random 250 < 1);
		rocket = (random 250 < 1);
		primary = true;
		optics = (random 15 < 1);
		muzzle = (random 25 < 1);
		railAttachment = (random 20 < 1);
		grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 3 < 1);
		_gps = (random 50 < 1);
		
		rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 30 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			firstAid = true;
			water = true;
			food = true;
			money = true;
			rocket = (random 30 < 1);
			primary = true;
			secondary= false;
			optics = true;
			muzzle = true;
			railAttachment = (random 6 < 1);
			nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 40 < 1);
			
			_headgearArraySelection = ["headgearALF_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_vestArraySelection = ["vestALF_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_rifleArraySelection = ["rifleALF_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_opticsArraySelection = ["opticsALF_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			_muzzleArraySelection = ["muzzleALF_SF"] call (missionNamespace getVariable "FN_arrayReturn");
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
};
_headgear = selectRandomWeighted _headgearArraySelection;
_facewear = selectRandomWeighted _facewearArraySelection;
_rifle = selectRandomWeighted _rifleArraySelection;
_uniform = selectRandomWeighted _uniformArraySelection;
_vest = selectRandomWeighted _vestArraySelection;
_handgun = selectRandomWeighted _handgunArraySelection;
_launcher = selectRandomWeighted _launcherArraySelection;
		
_unit addHeadgear _headgear;
_unit addGoggles _facewear;
_unit forceAddUniform _uniform;
_unit addVest _vest;

if (rocket) then {
	_backpackArraySelection = _backpackArraySelectionRare;
	_backpack = selectRandomWeighted _backpackArraySelection;
	_unit addBackpack _backpack;
	[_unit, _launcher, 2+(random 3)] call BIS_fnc_addWeapon;
} else {
	_backpack = selectRandomWeighted _backpackArraySelection;
	_unit addBackpack _backpack;
};

_unit addItemToBackpack "WBK_HeadLampItem";
	
if (random 2 < 1) then {
	for "_j" from 1 to (round (random 5)) do {
		_unit addItemToVest "ACE_fieldDressing";
		.01;
	};
};
	
if (firstAid) then {
	_unit addItemToBackpack (selectRandomWeighted _firstAidSelection);
};

if (water) then {
	_unit addItemToBackpack (selectRandomWeighted _waterSelection);
};

if (food) then {
	_unit addItemToBackpack (selectRandomWeighted _foodSelection);
};

if (grenades) then {
	_unit addItemToBackpack (selectRandomWeighted _grenades);
};

if (money) then {
	for "_j" from 1 to (round (random 5)) do {
		_unit addItemToVest "rvg_money";
	};
};

if (nvg) then {
	_unit linkItem (selectRandomWeighted _nvgSelection);
};

if (!(_melee)) then {
	if (primary || _primaryOverride || _sfOverride) then {
		[_unit, _rifle, (round (random 7))+2] call BIS_fnc_addWeapon; 
		if (railAttachment) then {
			_unit addPrimaryWeaponItem (selectRandomWeighted _railArraySelection);
		} else {
			_unit addPrimaryWeaponItem "acc_flashlight";
		};
		if (optics) then {
			private _opticSelected = selectRandomWeighted _opticsArraySelection;
			private _longRangeWeapons = ["longRangeWeapon"] call (missionNamespace getVariable "FN_arrayReturn");
			private _longRangeScope = ["longRangeScope"] call (missionNamespace getVariable "FN_arrayReturn");
			if (_rifle in _longRangeWeapons) then { //series of if statements to ensure that long range weapons have long range scopes
				if (_opticSelected in _longRangeScope) then {
					_unit addPrimaryWeaponItem _opticSelected; //optic is good to put onto a sniper
				} else {
					private _longRangeScopeWeight = ["longRangeScopeWeight"] call (missionNamespace getVariable "FN_arrayReturn");
					_unit addPrimaryWeaponItem (selectRandomWeighted _longRangeScopeWeight); 
				};
			} else {
				_unit addPrimaryWeaponItem (_opticSelected);
			};
		};
		if (muzzle) then {
			_unit addPrimaryWeaponItem (selectRandomWeighted _muzzleArraySelection);
		};
	} else {
		//Adding sidearm
		[_unit, _handgun, (round (random 5))+2] call BIS_fnc_addWeapon;
		_unit addHandgunItem "acc_flashlight_pistol";
	};
} else {
	_handgun = selectRandomWeighted _meleeSelection;
	[_unit, _handgun, 0] call BIS_fnc_addWeapon;
};

if (_rifle in _glWeapons) then {
	_mxGL = ["arifle_MX_GL_F","arifle_MX_GL_Black_F","arifle_MX_GL_khk_F"];
	_glRussian = ["glRussian"] call (missionNamespace getVariable "FN_arrayReturn");
	if (_rifle in _glRussian) then {
		_glRounds = ["glRoundsRussian"] call (missionNamespace getVariable "FN_arrayReturn");
		_numRounds = random [3, 5, 8];
		for "_i" from 1 to _numRounds do {
			_unit addItemToBackpack (selectRandomWeighted _glRounds);
		};
	} else {
		if (_rifle in _mxGL) then {
			_glRounds = ["3Rnd_SmokeYellow_Grenade_shell", 0.1,"3Rnd_Smoke_Grenade_shell", 0.1,"3Rnd_SmokeRed_Grenade_shell", 0.1,"3Rnd_SmokePurple_Grenade_shell", 0.1,"3Rnd_SmokeOrange_Grenade_shell", 0.1,"3Rnd_SmokeGreen_Grenade_shell", 0.1,"3Rnd_SmokeBlue_Grenade_shell", 0.1,"3Rnd_UGL_FlareYellow_F", 0.05,"3Rnd_UGL_FlareWhite_F", 0.05,"3Rnd_UGL_FlareRed_F", 0.05,"3Rnd_UGL_FlareCIR_F", 0.05,"3Rnd_UGL_FlareGreen_F", 0.05,"3Rnd_HE_Grenade_shell", 0.6];
			_numRounds = random [3, 5, 8];
			for "_i" from 1 to _numRounds do {
				_unit addItemToBackpack (selectRandomWeighted _glRounds);
			};
		} else {
			_glRounds = ["glRounds"] call (missionNamespace getVariable "FN_arrayReturn");
			_numRounds = random [3, 5, 8];
			for "_i" from 1 to _numRounds do {
				_unit addItemToBackpack (selectRandomWeighted _glRounds);
			};
		};
	};
};

if (muzzle) then {
	_unit addHandgunItem (selectRandomWeighted _muzzleArraySelection);
};

for "_i" from 1 to rndShitAmount do {
	_unit addItemToBackpack (selectRandomWeighted _rndShitArraySelection);
};

if (_map) then {
	_unit linkItem "ItemMap";
};
if (_compass) then {
	_unit linkItem "ItemCompass";
};
if (_watch) then {
	_unit linkItem "ItemWatch";
};
if (_radio) then {
	_unit linkItem (selectRandomWeighted _radioArraySelection);
};
if (_gps) then {
	_unit linkItem (selectRandomWeighted _gpsArraySelection);
};