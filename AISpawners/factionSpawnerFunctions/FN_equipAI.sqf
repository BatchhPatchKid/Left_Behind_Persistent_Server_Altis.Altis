params ["_faction","_unit","_melee","_primaryOverride", "_sfOverride"];

private _money = false;
private _nvg = false;
private _primary = false;
private _optics = false;
private _muzzle = false;
private _firstAid = false;
private _water = false;
private _food = false;
private _rocket = false;
private _rndShitAmount = 3;
private _railAttachment = false;
private _grenades = false;
private _map = false;
private _compass = false;
private _watch = false;
private _radio = false;
private _gps = false;

private _arrayReturn = missionNamespace getVariable "FN_arrayReturn";

//Basic Selection of gear
_headgearArraySelection = ["headgearCommon"] call _arrayReturn;
_facewearArraySelection = ["facewearCommon"] call _arrayReturn;
_uniformArraySelection = ["uniformCommon"] call _arrayReturn;
_vestArraySelection = ["vestCommon"] call _arrayReturn;
_backpackArraySelection = ["backpackCommon"] call _arrayReturn;
_rifleArraySelection = ["primaryCommon"] call _arrayReturn;
_handgunArraySelection = ["handgunCommon"] call _arrayReturn;
_launcherArraySelection = ["launcherCommon"] call _arrayReturn;
_rndShitArraySelection = ["randomCommon"] call _arrayReturn;
_opticsArraySelection = ["opticsCommon"] call _arrayReturn;
_muzzleArraySelection = ["muzzleCommon"] call _arrayReturn;
_railArraySelection = ["bipodCommon"] call _arrayReturn;
_nvgSelection = ["nvgCommon"] call _arrayReturn;
_waterSelection = ["waterCommon"] call _arrayReturn;
_foodSelection = ["foodCommon"] call _arrayReturn;
_meleeSelection = ["meleeCommon"] call _arrayReturn;
_firstAidSelection = ["medicalCommon"] call _arrayReturn;
_glWeapons = ["glWeapons"] call _arrayReturn;
_grenadeItems = ["grenades"] call _arrayReturn;
_gpsArraySelection = ["DSA_Detector",.15,"ItemGPS",1];
_radioArraySelection = ["radios"] call _arrayReturn;

//Rare Items
_rareNVG = ["nvgRare"] call _arrayReturn;
_headgearArraySelectionRare = ["headgearRare"] call _arrayReturn;
_vestArraySelectionRare = ["vestRare"] call _arrayReturn;
_backpackArraySelectionRare = ["backpackRare"] call _arrayReturn;
_rifleArraySelectionRare = ["primaryRare"] call _arrayReturn;
_handgunArraySelectionRare = ["handgunRare"] call _arrayReturn;
_opticsArraySelectionRare = ["opticsRare"] call _arrayReturn;
_muzzleArraySelectionRare = ["muzzleRare"] call _arrayReturn;
_railArraySelectionRare = ["railRare"] call _arrayReturn;
_uniformArraySelectionRare = ["uniformRare"] call _arrayReturn;

private _chosenLamp = "WBK_HeadLampItem_Double";

switch _faction do {
	case "Bandit": {
		_facewearArraySelection = ["facewearBandit"] call _arrayReturn;
		_firstAid = (random 5 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		_money = (random 5 < 1);
		_nvg = (random 300 < 1);
		_rocket = (random 300 < 1);
		_primary = (random 3 < 1);
		_optics = (random 15 < 1);
		_muzzle = (random 10 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);
		
		_rndShitAmount  = random [1, 2, 5];
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
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 14 < 1);
			_nvg = (random 20 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = (random 6 < 1);
			_railAttachment = (random 6 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 50 < 1);
			
			_headgearArraySelection = ["headgearBandit_SF"] call _arrayReturn;
			_vestArraySelection = ["vestBandit_SF"] call _arrayReturn;
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "Renegade": {
		_headgearArraySelection = ["headgearRenegade"] call _arrayReturn;
		_uniformArraySelection = ["uniformRenegade"] call _arrayReturn;
		_facewearArraySelection = ["facewearRenegade"] call _arrayReturn;
		_firstAid = (random 5 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		_money = (random 5 < 1);
		_grenades = (random 10 < 1);
		_primary = TRUE;
		
		_chosenLamp = "WBK_LampItem_Black";

		_rndShitAmount = random [1, 2, 5];
	};
	case "BB": {
		_headgearArraySelection = ["headgearBB"] call _arrayReturn;
		_facewearArraySelection = ["facewearSU"] call _arrayReturn;
		_meleeSelection = ["meleeBB"] call _arrayReturn;
		_rifleArraySelection= ["rifleBB"] call _arrayReturn;
		_firstAid = (random 5 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		_money = (random 5 < 1);
		_nvg = (random 300 < 1);
		_rocket = (random 300 < 1);
		_primary = true;
		_optics = (random 20 < 1);
		_muzzle = (random 15 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);
		
		_rndShitAmount = random [1, 2, 5];
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		if (random 155 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 155 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 170 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 175 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 185 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 165 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 50 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = (random 6 < 1);
			_railAttachment = (random 6 < 1);
			_nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 50 < 1);
			
			_vestArraySelection = ["vestBB_SF"] call _arrayReturn;
			_rifleArraySelection = ["rifleBB_SF"] call _arrayReturn;
			_opticsArraySelection = ["opticsBB_SF"] call _arrayReturn;
			_muzzleArraySelection = ["muzzleBB_SF"] call _arrayReturn;
			_uniformArraySelection = ["uniformBB_SF"] call _arrayReturn;
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	}; 
	case "DT": {
		_headgearArraySelection = ["headgearDT"] call _arrayReturn;
		_facewearArraySelection = ["facewearDT"] call _arrayReturn;
		_firstAid = (random 5 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		_money = (random 6 < 1);
		_nvg = (random 300 < 1);
		_rocket = (random 300 < 1);
		_primary = (random 4 < 1);
		_optics = (random 30 < 1);
		_muzzle = (random 25 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 20 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);

		_chosenLamp = "WBK_LampItem_Blue";
		
		_rndShitAmount = random [1, 2, 5];
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
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = (random 6 < 1);
			_muzzle = (random 10 < 1);
			_railAttachment = (random 6 < 1);
			_nvg = (random 20 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 70 < 1);
			
			_facewearArraySelection = ["facewearDT_SF"] call _arrayReturn;
			_vestArraySelection = ["vestBandit_SF"] call _arrayReturn;
			_rifleArraySelection = ["rifleDT_SF"] call _arrayReturn;
			_opticsArraySelection = ["opticsDT_SF"] call _arrayReturn;
			_muzzleArraySelection = ["muzzleDT_SF"] call _arrayReturn;
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "NH": {
		_headgearArraySelection = ["headgearNH"] call _arrayReturn;
		_facewearArraySelection = ["facewearNH"] call _arrayReturn;
		if (random 600 < 1) then {_nvgSelection = _rareNVG;};
		_firstAid = (random 5 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		_money = (random 6 < 1);
		_nvg = (random 300 < 1);
		_rocket = (random 300 < 1);
		_primary = (random 3 < 1);
		_optics = (random 30 < 1);
		_muzzle = (random 25 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 17 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);

		_chosenLamp = "WBK_LampItem_Green";
		
		_rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 50 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = (random 6 < 1);
			_railAttachment = (random 6 < 1);
			_nvg = (random 20 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 60 < 1);
			
			_facewearArraySelection = ["facewearNH_SF"] call _arrayReturn;
			_vestArraySelection = ["vestBandit_SF"] call _arrayReturn;
			_rifleArraySelection = ["rifleNH_SF"] call _arrayReturn;
			_opticsArraySelection = ["opticsNH_SF"] call _arrayReturn;
			_muzzleArraySelection = ["muzzleNH_SF"] call _arrayReturn;
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "PF": {
		_headgearArraySelection = ["headgearPF"] call _arrayReturn;
		_uniformArraySelection = ["uniformPF"] call _arrayReturn;
		_meleeSelection = ["meleePF"] call _arrayReturn;
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		_firstAid = (random 5 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		_money = (random 6 < 1);
		_nvg = (random 300 < 1);
		_rocket = (random 250 < 1);
		_primary = (random 2 < 1);
		_optics = (random 30 < 1);
		_muzzle = (random 25 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 7 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);

		_chosenLamp = "WBK_LampItem_Red";
		
		_rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 30 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = (random 6 < 1);
			_railAttachment = (random 6 < 1);
			_nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 60 < 1);
			
			_headgearArraySelection = ["headgearPF_SF"] call _arrayReturn;
			_vestArraySelection = ["vestPF_SF"] call _arrayReturn;
			_rifleArraySelection = ["riflePF_SF"] call _arrayReturn;
			
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "RC": {
		_headgearArraySelection = ["headgearRC"] call _arrayReturn;
		_facewearArraySelection = ["facewearRC"] call _arrayReturn;
		_vestArraySelection = ["vestRC"] call _arrayReturn;
		_meleeSelection = ["meleeRC"] call _arrayReturn;
		_uniformArraySelection = ["uniformRC"] call _arrayReturn;
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		_firstAid = (random 4 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		_money = (random 4 < 1);
		_nvg = (random 250 < 1);
		_rocket = (random 250 < 1);
		_primary = true;
		_optics = (random 5 < 1);
		_muzzle = (random 15 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 70 < 1);
		
		_rndShitAmount = random [1, 2, 5];
		if (random 150 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 150 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 145 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 150 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 155 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 165 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 150 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 40 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = (random 6 < 1);
			_railAttachment = (random 6 < 1);
			_nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 40 < 1);
			
			_headgearArraySelection = ["headgearRC_SF"] call _arrayReturn;
			_uniformArraySelection = ["uniformRC_SF"] call _arrayReturn;
			_vestArraySelection = ["vestRC_SF"] call _arrayReturn;
			_rifleArraySelection = ["rifleRC_SF"] call _arrayReturn;
			_opticsArraySelection = ["opticsRC_SF"] call _arrayReturn;
			_muzzleArraySelection = ["muzzleRC_SF"] call _arrayReturn;
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "TRB": {
		_facewearArraySelection = ["facewearTRB"] call _arrayReturn;
		_uniformArraySelection = ["uniformTRB"] call _arrayReturn;
		_rifleArraySelection = ["rifleTRB"] call _arrayReturn;
		_headgearArraySelection = ["headgearTRB"] call _arrayReturn;
		_meleeSelection = ["meleeTRB"] call _arrayReturn;
		_opticsArraySelection = ["russianOptic"] call _arrayReturn;
		_muzzleArraySelection = ["russianMuzzle"] call _arrayReturn;
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		_firstAid = (random 4 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		_money = (random 4 < 1);
		_nvg = (random 250 < 1);
		_rocket = (random 250 < 1);
		_primary = true;
		_optics = (random 10 < 1);
		_muzzle = (random 10 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 60 < 1);
		
		_rndShitAmount = random [1, 2, 5];
		if (random 160 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 160 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 150 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 170 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 175 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 185 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 165 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 30 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = (random 6 < 1);
			_railAttachment = (random 6 < 1);
			_nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 40 < 1);
			
			_headgearArraySelection = ["headgearTRB_SF"] call _arrayReturn;
			_vestArraySelection = ["vestTRB_SF"] call _arrayReturn;
			_rifleArraySelection = ["rifleTRB_SF"] call _arrayReturn;
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "US": {
		_headgearArraySelection = ["headgearUS"] call _arrayReturn;
		_facewearArraySelection = ["facewearUS"] call _arrayReturn;
		_uniformArraySelection = ["uniformUS"] call _arrayReturn;
		_vestArraySelection = ["vestUS"] call _arrayReturn;
		_backpackArraySelection = ["backpackUS"] call _arrayReturn;
		_rifleArraySelection = ["rifleUS"] call _arrayReturn;
		_handgunArraySelection = ["handgunUS"] call _arrayReturn;
		_launcherArraySelection = ["launcherUS"] call _arrayReturn;
		_firstAid = (random 3 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		if (random 300 < 1) then {_nvgSelection = _rareNVG;};
		_money = (random 2 < 1);
		_nvg = (random 150 < 1);
		_rocket = (random 150 < 1);
		_primary = true;
		_optics = (random 2 < 1);
		_muzzle = (random 10 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 5 < 1);
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
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = true;
			_railAttachment = true;
			_nvg = true;
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = true;
			
			_uniformArraySelection = ["uniformUS_Ranger_SF"] call _arrayReturn;
			_headgearArraySelection = ["headgearUS_Ranger_SF"] call _arrayReturn;
			_vestArraySelection = ["vestUS_Ranger_SF"] call _arrayReturn;
			_rifleArraySelection = ["rifleUS_Ranger_SF"] call _arrayReturn;
			_opticsArraySelection = ["opticsUS_Ranger_SF"] call _arrayReturn;
			_muzzleArraySelection = ["muzzleUS_Ranger_SF"] call _arrayReturn;
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
		//marine
		//sniper
	};
	case "SU": {
		_facewearArraySelection = ["facewearSU"] call _arrayReturn;
		_uniformArraySelection = ["uniformSU"] call _arrayReturn;
		_firstAid = (random 5 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		if (random 600 < 1) then {_nvgSelection = _rareNVG;};
		_money = (random 4 < 1);
		_nvg = (random 300 < 1);
		_rocket = (random 300 < 1);
		_primary = true;
		_optics = (random 3 < 1);
		_muzzle = (random 25 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 20 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 5 < 1);
		_gps = (random 80 < 1);

		_rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 50 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = (random 6 < 1);
			_railAttachment = (random 6 < 1);
			_nvg = (random 20 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 50 < 1);
			
			_headgearArraySelection = ["headgearSU_SF"] call _arrayReturn;
			_vestArraySelection = ["vestSU_SF"] call _arrayReturn;
			_rifleArraySelection = ["rifleSU_SF"] call _arrayReturn;
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
case "RU": {
	_headgearArraySelection = ["headgearRU"] call _arrayReturn;
	_uniformArraySelection = ["uniformRU"] call _arrayReturn;
	_vestArraySelection = ["vestRU"] call _arrayReturn;
	_backpackArraySelection = ["backpackRU"] call _arrayReturn;
	_rifleArraySelection = ["rifleRU"] call _arrayReturn;
	_handgunArraySelection = ["handgunRU"] call _arrayReturn;
	_launcherArraySelection = ["launcherRU"] call _arrayReturn;
	_muzzleArraySelection = ["muzzleRU"] call _arrayReturn;
	_opticsArraySelection = ["russianOptic"] call _arrayReturn;
	_muzzleArraySelection = ["russianMuzzle"] call _arrayReturn;
	_facewearArraySelection = ["facewearRU"] call _arrayReturn;
	_firstAid = (random 3 < 1);
	_water = (random 16 < 1);
	_food = (random 20 < 1);
	if (random 360 < 1) then {_nvgSelection = _rareNVG;};
	_money = (random 4 < 1);
	_nvg = (random 180 < 1);
	_rocket = (random 180 < 1);
	_primary = true;
	_optics = true;
	_muzzle = (random 7 < 1);
	_railAttachment = (random 20 < 1);
	_grenades = (random 8 < 1);
	_map = (random 5 < 1);
	_compass = true;
	_watch = true;
	_radio = true;
	_gps = (random 20 < 1);
	
	_rndShitAmount = random [1, 2, 5];
	if (random 145 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
	if (random 140 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
	if (random 135 < 1) then {_railArraySelection = _railArraySelectionRare;};
	
	if (random 15 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
		_firstAid = true;
		_water = true;
		_food = true;
		_money = true;
		_rocket = (random 30 < 1);
		_primary = true;
		_secondary= false;
		_optics = true;
		_muzzle = true;
		_railAttachment = true;
		_nvg = true;
		_map = true;
		_compass = true;
		_watch = true;
		_radio = true;
		_gps = (random 3 < 1);
		
		_uniformArraySelection = ["uniformRU_SF"] call _arrayReturn;
		_rifleArraySelection = ["rifleRU_SF"] call _arrayReturn;
		_headgearArraySelection = ["headgearRU_SF"] call _arrayReturn;
		_vestArraySelection = ["vestRU_SF"] call _arrayReturn;
		_muzzleArraySelection = ["muzzleRU_SF"] call _arrayReturn;
		
		if (random 3 < 1) then {
			_railArraySelection = _railArraySelectionRare;
		};
	};
};
	case "ROA": {
		_facewearArraySelection = ["facewearROA"] call _arrayReturn;
		_uniformArraySelection = ["uniformROA"] call _arrayReturn;
		_vestArraySelection = ["vestROA"] call _arrayReturn;
		_rifleArraySelection = ["rifleROA"] call _arrayReturn;
		_headgearArraySelection = ["headgearROA"] call _arrayReturn;
		_muzzleArraySelection = ["muzzleROA_SF"] call _arrayReturn;

		_firstAid = (random 3 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		if (random 400 < 1) then {_nvgSelection = _rareNVG;};
		_money = (random 4 < 1);
		_nvg = true;
		_rocket = (random 200 < 1);
		_primary = true;
		_optics = (random 2 < 1);
		_muzzle = (random 5 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 20 < 1);
		_map = true;
		_compass = true;
		_watch = true;
		_radio = true;
		_gps = (random 30 < 1);
		_chosenLamp = "";
		
		_rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 20 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = (random 3 < 1);
			_railAttachment = (random 6 < 1);
			_nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 8 < 1);
			
			_headgearArraySelection = ["headgearROA_SF"] call _arrayReturn;
			_vestArraySelection = ["vestROA_SF"] call _arrayReturn;
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "PMC": {
		_headgearArraySelection = ["headgearPMC"] call _arrayReturn;
		_facewearArraySelection = ["facewearPMC"] call _arrayReturn;
		_uniformArraySelection = ["uniformPMC"] call _arrayReturn;
		_vestArraySelection = ["vestPMC"] call _arrayReturn;
		_rifleArraySelection = ["riflePMC"] call _arrayReturn;
		_opticsArraySelection = ["russianOptic"] call _arrayReturn;
		_muzzleArraySelection = ["rhs_acc_tgpa", 1];
		_railArraySelection = ["rhs_acc_grip_rk6", 1];
		_firstAid = (random 3 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		if (random 400 < 1) then {_nvgSelection = _rareNVG;};
		_money = (random 4 < 1);
		_nvg = true;
		_rocket = (random 200 < 1);
		_primary = true;
		_optics = (random 2 < 1);
		_muzzle = true;
		_railAttachment = (random 20 < 1);
		_grenades = (random 20 < 1);
		_map = true;
		_compass = true;
		_watch = true;
		_radio = true;
		_gps = (random 5 < 1);

		_chosenLamp = "";
		
		_rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 20 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = true;
			_railAttachment = true;
			_nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 5 < 1);
			
			_facewearArraySelection = ["facewearPMC_SF"] call _arrayReturn;
			_uniformArraySelection = ["uniformPMC_SF"] call _arrayReturn;
			_rifleArraySelection = ["riflePMC_SF"] call _arrayReturn;
			_muzzleArraySelection = ["muzzlePMC_SF"] call _arrayReturn;
			_opticsArraySelection = ["opticsPMC_SF"] call _arrayReturn;
			_vestArraySelection = ["vestPMC_SF"] call _arrayReturn;
		};
	};
	case "WO": {
		_headgearArraySelection = ["headgearWO"] call _arrayReturn;
		_facewearArraySelection = ["facewearWO"] call _arrayReturn;
		_uniformArraySelection = ["uniformWO"] call _arrayReturn;
		_vestArraySelection = ["vestWO"] call _arrayReturn;
		_rifleArraySelection = ["rifleWO"] call _arrayReturn;
		_backpackArraySelection = ["backpackWO"] call _arrayReturn;
		_meleeSelection = ["meleeWO"] call _arrayReturn;
		_firstAid = (random 4 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		_money = (random 4 < 1);
		_nvg = (random 250 < 1);
		_rocket = (random 250 < 1);
		_primary = (random 2 < 1);
		_optics = (random 10 < 1);
		_muzzle = (random 25 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 4 < 1);
		_gps = (random 70 < 1);
		
		_rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 170 < 1) then {_vestArraySelection = _vestArraySelectionRare;};
		if (random 160 < 1) then {_backpackArraySelection = _backpackArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 40 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = (random 6 < 1);
			_railAttachment = (random 6 < 1);
			_nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 45 < 1);
			
			_headgearArraySelection = ["headgearWO_SF"] call _arrayReturn;
			_vestArraySelection = ["vestWO_SF"] call _arrayReturn;
			_rifleArraySelection = ["rifleWO_SF"] call _arrayReturn;
			_opticsArraySelection = ["opticsWO_SF"] call _arrayReturn;
			_muzzleArraySelection = ["muzzleWO_SF"] call _arrayReturn;
			
			if (random 3 < 1) then {
				_railArraySelection = _railArraySelectionRare;
			};
		};
	};
	case "ALF": {
		_uniformArraySelection = ["uniformALF"] call _arrayReturn;
		_vestArraySelection = ["vestALF"] call _arrayReturn;
		_rifleArraySelection = ["rifleALF"] call _arrayReturn;
		_headgearArraySelection = ["headgearALF"] call _arrayReturn;
		_facewearArraySelection = ["facewearALF"] call _arrayReturn;
		_firstAid = (random 4 < 1);
		_water = (random 16 < 1);
		_food = (random 20 < 1);
		if (random 500 < 1) then {_nvgSelection = _rareNVG;};
		_money = (random 4 < 1);
		_nvg = (random 250 < 1);
		_rocket = (random 250 < 1);
		_primary = true;
		_optics = (random 15 < 1);
		_muzzle = (random 25 < 1);
		_railAttachment = (random 20 < 1);
		_grenades = (random 15 < 1);
		_map = (random 7 < 1);
		_compass = (random 10 < 1);
		_watch = (random 5 < 1);
		_radio = (random 3 < 1);
		_gps = (random 50 < 1);
		
		_rndShitAmount = random [1, 2, 5];
		if (random 170 < 1) then {_headgearArraySelection = _headgearArraySelectionRare;};
		if (random 180 < 1) then {_rifleArraySelection = _rifleArraySelectionRare;};
		if (random 185 < 1) then {_opticsArraySelection = _opticsArraySelectionRare;};
		if (random 195 < 1) then {_muzzleArraySelection = _muzzleArraySelectionRare;};
		if (random 175 < 1) then {_railArraySelection = _railArraySelectionRare;};
		if (random 100 < 1) then {_uniformArraySelection = _uniformArraySelectionRare;};
		
		if (random 30 < 1 && !_melee || _sfOverride) then { // how rare a special unit spawns 
			_firstAid = true;
			_water = true;
			_food = true;
			_money = true;
			_rocket = (random 30 < 1);
			_primary = true;
			_secondary= false;
			_optics = true;
			_muzzle = true;
			_railAttachment = (random 6 < 1);
			_nvg = (random 10 < 1);
			_map = true;
			_compass = true;
			_watch = true;
			_radio = true;
			_gps = (random 40 < 1);
			
			_headgearArraySelection = ["headgearALF_SF"] call _arrayReturn;
			_vestArraySelection = ["vestALF_SF"] call _arrayReturn;
			_rifleArraySelection = ["rifleALF_SF"] call _arrayReturn;
			_opticsArraySelection = ["opticsALF_SF"] call _arrayReturn;
			_muzzleArraySelection = ["muzzleALF_SF"] call _arrayReturn;
			
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

if (_rocket) then {
	_backpackArraySelection = _backpackArraySelectionRare;
	_backpack = selectRandomWeighted _backpackArraySelection;
	_unit addBackpack _backpack;
	[_unit, _launcher, 2+(random 3)] call BIS_fnc_addWeapon;
} else {
	_backpack = selectRandomWeighted _backpackArraySelection;
	_unit addBackpack _backpack;
};

_unit addItemToUniform _chosenLamp;
	
if (random 2 < 1) then {
	for "_j" from 1 to (round (random 5)) do {
		_unit addItemToVest "ACE_fieldDressing";
	};
};
	
if (_firstAid) then {
	_unit addItemToBackpack (selectRandomWeighted _firstAidSelection);
};

if (_water) then {
	_unit addItemToBackpack (selectRandomWeighted _waterSelection);
};

if (_food) then {
	_unit addItemToBackpack (selectRandomWeighted _foodSelection);
};

if (_grenades) then {
	_unit addItemToBackpack (selectRandomWeighted _grenadeItems);
};

if (_money) then {
	for "_j" from 1 to (round (random 5)) do {
		_unit addItemToVest "rvg_money";
	};
};

if (_nvg) then {
	_unit linkItem (selectRandomWeighted _nvgSelection);
};

if (!(_melee)) then {
	if (_primary  || _primaryOverride || _sfOverride) then {
		[_unit, _rifle, (round (random 7))+2] call BIS_fnc_addWeapon; 
		if (_railAttachment) then {
			_unit addPrimaryWeaponItem (selectRandomWeighted _railArraySelection);
		} else {
			_unit addPrimaryWeaponItem "acc_flashlight";
		};
		if (_optics) then {
			private _opticSelected = selectRandomWeighted _opticsArraySelection;
			private _longRangeWeapons = ["longRangeWeapon"] call _arrayReturn;
			private _longRangeScope = ["longRangeScope"] call _arrayReturn;
			if (_rifle in _longRangeWeapons) then { //series of if statements to ensure that long range weapons have long range scopes
				if (_opticSelected in _longRangeScope) then {
					_unit addPrimaryWeaponItem _opticSelected; //optic is good to put onto a sniper
				} else {
					private _longRangeScopeWeight = ["longRangeScopeWeight"] call _arrayReturn;
					_unit addPrimaryWeaponItem (selectRandomWeighted _longRangeScopeWeight); 
				};
			} else {
				_unit addPrimaryWeaponItem (_opticSelected);
			};
		};
		if (_muzzle) then {
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
	_glRussian = ["glRussian"] call _arrayReturn;
	if (_rifle in _glRussian) then {
		_glRounds = ["glRoundsRussian"] call _arrayReturn;
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
			_glRounds = ["glRounds"] call _arrayReturn;
			_numRounds = random [3, 5, 8];
			for "_i" from 1 to _numRounds do {
				_unit addItemToBackpack (selectRandomWeighted _glRounds);
			};
		};
	};
};

if (_muzzle) then {
	_unit addHandgunItem (selectRandomWeighted _muzzleArraySelection);
};

for "_i" from 1 to _rndShitAmount do {
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