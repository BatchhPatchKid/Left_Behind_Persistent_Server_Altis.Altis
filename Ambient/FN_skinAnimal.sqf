/*
    FN_skinAnimal.sqf
    -----------------
    Skins nearby dead entities within 5m. The script differentiates between animals (actual animals) 
    and "Man" animals (humans, zombies, large mutants). Behavior:

    1) Animals (not "Man"):
       - No Knife -> salvage 1x Boar Meat
       - Knife    -> get 1x Sheep Meat
       In both cases, the animal is deleted. No gore object is spawned.

    2) Human-likes (class "Man"):
       - If no Knife -> cannot skin; show hint and exit
       - If Knife is present:
           * Large mutants -> Buffalo Meat, no gore
           * Zombies      -> Rabbit Meat + gore object
           * Normal Human -> Chicken Meat + gore object

    Arrays are defined on one line each. 
*/

params ["_player"];

// 1) Arrays
private _animalsToCheck = ["Rabbit_F","Sheep_random_F","Hen_random_F","Cock_random_F","Cock_white_F","Fin_sand_F","Fin_blackwhite_F","Fin_ocherwhite_F","Fin_tricolour_F","Fin_random_F","Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F","Alsatian_Random_F","Goat_random_F","Goat_random_F2"];
private _largeMutants   = ["WBK_SpecialZombie_Smasher_3","WBK_SpecialZombie_Smasher_Hellbeast_3","WBK_SpecialZombie_Smasher_Acid_3","WBK_Goliaph_3"];
private _zombies        = ["RyanZombieCrawler1Opfor","RyanZombieCrawler2Opfor","RyanZombieCrawler3Opfor","RyanZombieCrawler4Opfor","RyanZombieCrawler5Opfor","RyanZombieCrawler6Opfor","RyanZombieCrawler7Opfor","RyanZombieCrawler8Opfor","RyanZombieCrawler9Opfor","RyanZombieCrawler10Opfor","RyanZombieCrawler11Opfor","RyanZombieCrawler12Opfor","RyanZombieCrawler13Opfor","RyanZombieCrawler14Opfor","RyanZombieCrawler15Opfor","RyanZombieCrawler16Opfor","RyanZombieCrawler17Opfor","RyanZombieCrawler18Opfor","RyanZombieCrawler19Opfor","RyanZombieCrawler20Opfor","RyanZombieCrawler21Opfor","RyanZombieCrawler22Opfor","RyanZombieCrawler23Opfor","RyanZombieCrawler24Opfor","RyanZombieCrawler25Opfor","RyanZombieCrawler26Opfor","RyanZombieCrawler27Opfor","RyanZombieCrawler28Opfor","RyanZombieCrawler29Opfor","RyanZombieCrawler30Opfor","RyanZombieCrawler31Opfor","RyanZombieCrawler32Opfor","Zombie_O_Crawler_Civ","Zombie_O_Shambler_Civ","Zombie_O_RA_Civ","Zombie_O_RC_Civ","Zombie_O_Walker_Civ","Zombie_O_Crawler_FIA","Zombie_O_Shambler_FIA","Zombie_O_RA_FIA","Zombie_O_RC_FIA","Zombie_O_Shooter_FIA","Zombie_O_Walker_FIA","Zombie_Special_OPFOR_Boomer","WBK_SpecialZombie_Corrupted_3","Zombie_Special_OPFOR_Leaper_1","Zombie_Special_OPFOR_Leaper_2","Zombie_Special_OPFOR_Screamer","RyanZombieboss1Opfor","RyanZombieboss2Opfor","RyanZombieboss3Opfor","RyanZombieboss4Opfor","RyanZombieboss5Opfor","RyanZombieboss6Opfor","RyanZombieboss7Opfor","RyanZombieboss8Opfor","RyanZombieboss9Opfor","RyanZombieboss10Opfor","RyanZombieboss11Opfor","RyanZombieboss12Opfor","RyanZombieboss13Opfor","RyanZombieboss14Opfor","RyanZombieboss15Opfor","RyanZombieboss16Opfor","RyanZombieboss17Opfor","RyanZombieboss18Opfor","RyanZombieboss19Opfor","RyanZombieboss20Opfor","RyanZombieboss21Opfor","RyanZombieboss22Opfor","RyanZombieboss23Opfor","RyanZombieboss24Opfor","RyanZombieboss25Opfor","RyanZombieboss26Opfor","RyanZombieboss27Opfor","RyanZombieboss28Opfor","RyanZombieboss29Opfor","RyanZombieboss30Opfor","RyanZombieboss31Opfor","RyanZombieboss32Opfor","RyanZombieC_man_1Opfor","RyanZombieC_man_polo_1_FOpfor","RyanZombieC_man_polo_2_FOpfor","RyanZombieC_man_polo_4_FOpfor","RyanZombieC_man_polo_5_FOpfor","RyanZombieC_man_polo_6_FOpfor","RyanZombieC_man_p_fugitive_FOpfor","RyanZombieC_man_w_worker_FOpfor","RyanZombieC_scientist_FOpfor","RyanZombieC_man_hunter_1_FOpfor","RyanZombieC_man_pilot_FOpfor","RyanZombieC_journalist_FOpfor","RyanZombieC_OrestesOpfor","RyanZombieC_NikosOpfor","RyanZombie15Opfor","RyanZombie16Opfor","RyanZombie17Opfor","RyanZombie18Opfor","RyanZombie19Opfor","RyanZombie20Opfor","RyanZombie21Opfor","RyanZombie22Opfor","RyanZombie23Opfor","RyanZombie24Opfor","RyanZombie25Opfor","RyanZombie26Opfor","RyanZombie27Opfor","RyanZombie28Opfor","RyanZombie29Opfor","RyanZombie30Opfor","RyanZombie31Opfor","RyanZombie32Opfor","RyanZombieC_man_1mediumOpfor","RyanZombieC_man_polo_1_FmediumOpfor","RyanZombieC_man_polo_2_FmediumOpfor","RyanZombieC_man_polo_4_FmediumOpfor","RyanZombieC_man_polo_5_FmediumOpfor","RyanZombieC_man_polo_6_FmediumOpfor","RyanZombieC_man_p_fugitive_FmediumOpfor","RyanZombieC_man_w_worker_FmediumOpfor","RyanZombieC_scientist_FmediumOpfor","RyanZombieC_man_hunter_1_FmediumOpfor","RyanZombieC_man_pilot_FmediumOpfor","RyanZombieC_journalist_FmediumOpfor","RyanZombieC_OrestesmediumOpfor","RyanZombieC_NikosmediumOpfor","RyanZombie15mediumOpfor","RyanZombie16mediumOpfor","RyanZombie17mediumOpfor","RyanZombie18mediumOpfor","RyanZombie19mediumOpfor","RyanZombie20mediumOpfor","RyanZombie21mediumOpfor","RyanZombie22mediumOpfor","RyanZombie23mediumOpfor","RyanZombie24mediumOpfor","RyanZombie25mediumOpfor","RyanZombie26mediumOpfor","RyanZombie27mediumOpfor","RyanZombie28mediumOpfor","RyanZombie29mediumOpfor","RyanZombie30mediumOpfor","RyanZombie31mediumOpfor","RyanZombie32mediumOpfor","RyanZombieC_man_1slowOpfor","RyanZombieC_man_polo_1_FslowOpfor","RyanZombieC_man_polo_2_FslowOpfor","RyanZombieC_man_polo_4_FslowOpfor","RyanZombieC_man_polo_5_FslowOpfor","RyanZombieC_man_polo_6_FslowOpfor","RyanZombieC_man_p_fugitive_FslowOpfor","RyanZombieC_man_w_worker_FslowOpfor","RyanZombieC_scientist_FslowOpfor","RyanZombieC_man_hunter_1_FslowOpfor","RyanZombieC_man_pilot_FslowOpfor","RyanZombieC_journalist_FslowOpfor","RyanZombieC_OrestesslowOpfor","RyanZombieC_NikosslowOpfor","RyanZombie15slowOpfor","RyanZombie16slowOpfor","RyanZombie17slowOpfor","RyanZombie18slowOpfor","RyanZombie19slowOpfor","RyanZombie20slowOpfor","RyanZombie21slowOpfor","RyanZombie22slowOpfor","RyanZombie23slowOpfor","RyanZombie24slowOpfor","RyanZombie25slowOpfor","RyanZombie26slowOpfor","RyanZombie27slowOpfor","RyanZombie28slowOpfor","RyanZombie29slowOpfor","RyanZombie30slowOpfor","RyanZombie31slowOpfor","RyanZombie32slowOpfor","RyanZombieSpider1Opfor","RyanZombieSpider2Opfor","RyanZombieSpider3Opfor","RyanZombieSpider4Opfor","RyanZombieSpider5Opfor","RyanZombieSpider6Opfor","RyanZombieSpider7Opfor","RyanZombieSpider8Opfor","RyanZombieSpider9Opfor","RyanZombieSpider10Opfor","RyanZombieSpider11Opfor","RyanZombieSpider12Opfor","RyanZombieSpider13Opfor","RyanZombieSpider14Opfor","RyanZombieSpider15Opfor","RyanZombieSpider16Opfor","RyanZombieSpider17Opfor","RyanZombieSpider18Opfor","RyanZombieSpider19Opfor","RyanZombieSpider20Opfor","RyanZombieSpider21Opfor","RyanZombieSpider22Opfor","RyanZombieSpider23Opfor","RyanZombieSpider24Opfor","RyanZombieSpider25Opfor","RyanZombieSpider26Opfor","RyanZombieSpider27Opfor","RyanZombieSpider28Opfor","RyanZombieSpider29Opfor","RyanZombieSpider30Opfor","RyanZombieSpider31Opfor","RyanZombieSpider32Opfor","RyanZombieC_man_1walkerOpfor","RyanZombieC_man_polo_1_FwalkerOpfor","RyanZombieC_man_polo_2_FwalkerOpfor","RyanZombieC_man_polo_4_FwalkerOpfor","RyanZombieC_man_polo_5_FwalkerOpfor","RyanZombieC_man_polo_6_FwalkerOpfor","RyanZombieC_man_p_fugitive_FwalkerOpfor","RyanZombieC_man_w_worker_FwalkerOpfor","RyanZombieC_scientist_FwalkerOpfor","RyanZombieC_man_hunter_1_FwalkerOpfor","RyanZombieC_man_pilot_FwalkerOpfor","RyanZombieC_journalist_FwalkerOpfor","RyanZombieC_OresteswalkerOpfor","RyanZombieC_NikoswalkerOpfor","RyanZombie15walkerOpfor","RyanZombie16walkerOpfor","RyanZombie17walkerOpfor","RyanZombie18walkerOpfor","RyanZombie19walkerOpfor","RyanZombie20walkerOpfor","RyanZombie21walkerOpfor","RyanZombie22walkerOpfor","RyanZombie23walkerOpfor","RyanZombie24walkerOpfor","RyanZombie25walkerOpfor","RyanZombie26walkerOpfor","RyanZombie27walkerOpfor","RyanZombie28walkerOpfor","RyanZombie29walkerOpfor","RyanZombie30walkerOpfor","RyanZombie31walkerOpfor","RyanZombie32walkerOpfor","zombie_walker","zombie_runner","zombie_bolter","DSA_Crazy"];

//checking if the player can add the item
if !(_player canAdd "rvg_Boar_Meat") exitWith {
    hint "Your inventory is full, cannot skin right now.";
};

// 2) Search for dead entities near the player
private _searchRadius = 5;
private _nearbyAnimals = nearestObjects [_player, _animalsToCheck, _searchRadius];
private _deadAnimals = _nearbyAnimals select { !alive _x };
private _nearbyMen = nearestObjects [_player, ["Man"], _searchRadius];
private _deadMen = _nearbyMen select { !alive _x && !isPlayer _x };
private _targets = _deadAnimals + _deadMen;
if (count _targets == 0) exitWith { hint "No dead animals or AI nearby to skin!"; };

private _closest      = _targets select 0;
private _closestClass = typeOf _closest;

// 3) Position and orientation for gore
private _pos = getPosATL _closest;
private _dir = getDir _closest;

// Function to spawn gore object (for man targets)
private _spawnGore = {
    private _goreObj = createVehicle ["no_skin_open_chest", _pos, [], 0, "CAN_COLLIDE"];
    _goreObj setDir _dir;
};

// 4) Distinguish animal vs man
if (_closestClass in _animalsToCheck) then {
    // ========== It's an animal (not "Man")
    // Knife not required to salvage *something*. If no knife, get boar; if knife, get sheep.
    private _hasKnife = [_player, "rvg_guttingKnife"] call BIS_fnc_hasItem;
    if (!_hasKnife) then {
        // No knife => Boar Meat
        _player addItem "rvg_Boar_Meat";
        hintSilent "Without a knife, you only salvaged subpar boar meat";
    } else {
        // Have a knife => Sheep Meat
        _player addItem "rvg_Sheep_Meat";
        hintSilent "You skinned the animal for sheep meat";
    };
    deleteVehicle _closest;
    _player playMove "AinvPknlMstpSnonWnonDnon_medic2";

} else {
    // ========== It's a "Man" (human, zombie, mutant, etc.)
    // Must have a knife to proceed
    if (!([_player, "rvg_guttingKnife"] call BIS_fnc_hasItem)) exitWith {
        hint "You need a gutting knife to skin a person or mutant";
    };

    // With a knife, check if large mutant, zombie, or normal human
    if (_closestClass in _largeMutants) then {
        // Large mutant => Buffalo Meat, no gore
        _player addItem "rvg_Buffalo_Meat";
        deleteVehicle _closest;
        hintSilent "You skinned a large mutant and got buffalo meat";
    } else {
        if (_closestClass in _zombies) then {
            // Zombie => Rabbit Meat + gore
            _player addItem "rvg_Rabbit_Meat";
            [_spawnGore] call BIS_fnc_call;
            deleteVehicle _closest;
            hintSilent "You skinned a zombie and got rabbit meat";
        } else {
            // Normal human => Chicken Meat + gore
            _player addItem "rvg_Chicken_Meat";
			if ((random 1) > .85) then {
				_player addItem "ACE_bloodIV_250";
			};
            [_spawnGore] call BIS_fnc_call;
            deleteVehicle _closest;
            hintSilent "You skinned a person and got chicken meat";
        };
    };
    _player playMove "AinvPknlMstpSnonWnonDnon_medic2";
};

// 5) Clear hint after ~3s
0 spawn {
    sleep 3;
    hintSilent "";
};