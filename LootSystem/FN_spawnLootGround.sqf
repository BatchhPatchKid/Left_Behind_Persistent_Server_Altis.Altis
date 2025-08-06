params ["_player"];

if (random 1 > .5) then {
	// caching database
	private _arrayReturn = missionNamespace getVariable "FN_arrayReturn";

	private _lootArrayPool = [
		"headgearCommon", 5,
		"uniformCommon", 5,
		"vestCommon", 5,
		"backpackCommon", 4,
		"primaryCommon", 3,
		"randomCommon", 12,
		"nvgCommon", .25,
		"waterCommon", 8,
		"foodCommon", 8,
		"medicalCommon", 7,
		"explosiveCommon", 3,
		"headgearRare", 1,
		"vestRare", 1,
		"primaryRare", 1,
		"muzzleRare", 1
	];

	// Pick a key (weighted, using selectRandomWeighted)
	private _chosenKey = selectRandomWeighted _lootArrayPool;

	// Use the key to get the loot array
	private _lootArray = [_chosenKey] call _arrayReturn;

	private _holder = createVehicle ["GroundWeaponHolder", getPosATL _player, [], 0, "CAN_COLLIDE"];
	_holder setPosATL [(getPosATL _holder select 0), (getPosATL _holder select 1), (getPosATL _holder select 2) + 0.1];

	switch (_chosenKey) do {
		case ("primaryCommon"): {
			_weaponSelected = selectRandomWeighted _lootArray;
			_holder addWeaponCargoGlobal [_weaponSelected, 1];
			_holder addMagazineCargoGlobal [(compatibleItems _weaponSelected), round (random 5)];
		};

		case ("primaryRare"): {
			_weaponSelected = selectRandomWeighted _lootArray;
			_holder addWeaponCargoGlobal [_weaponSelected, 1];
			_holder addMagazineCargoGlobal [(compatibleItems _weaponSelected), round (random 5)];
		};

		case ("backpackCommon"): {
			_holder addBackpackCargoGlobal [(selectRandomWeighted _lootArray), 1];
		};

		default {
			_holder addItemCargoGlobal [(selectRandomWeighted _lootArray), 1];
		};
	};

	[format ["<t color='#ffffffff' size='0.80'>You managed to salvage something</t>"], .8, 1, 1, .3, 0, 789] spawn BIS_fnc_dynamicText;
} else {
	[format ["<t color='#ffffffff' size='0.80'>You found nothing</t>"], .8, 1, 1, .3, 0, 789] spawn BIS_fnc_dynamicText;
};