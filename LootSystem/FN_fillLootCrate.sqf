params ["_box","_levelGear"];
private ["_CRVest","_CRWeapon","_CRHeadgear","_CRItems","_rndNumCR","_rndNum","_i","_rndWeapon","_mags","_rndMagNum"];

//loot arrays

//Basic Selection of gear
private _commonHeadgearLoot = ["headgearCommon"] call (missionNamespace getVariable "FN_arrayReturn");
private _uniforms = ["uniformCommon"] call (missionNamespace getVariable "FN_arrayReturn");
private _commonVestLoot = ["vestCommon"] call (missionNamespace getVariable "FN_arrayReturn");
private _backpackItems = ["backpackCommon"] call (missionNamespace getVariable "FN_arrayReturn");
private _commonWeaponLoot = ["primaryCommon"] call (missionNamespace getVariable "FN_arrayReturn");
private _miscItems = ["randomCommon"] call (missionNamespace getVariable "FN_arrayReturn");
private _nvgs = ["nvgCommon"] call (missionNamespace getVariable "FN_arrayReturn");
private _waterSelection = ["waterCommon"] call (missionNamespace getVariable "FN_arrayReturn");
private _foodSelection = ["foodCommon"] call (missionNamespace getVariable "FN_arrayReturn");
private _firstAidSelection = ["medicalCommon"] call (missionNamespace getVariable "FN_arrayReturn");
private _explosives = ["explosiveCommon"] call (missionNamespace getVariable "FN_arrayReturn");

//Rare Items
private _rareHeadgearLoot = ["headgearRare"] call (missionNamespace getVariable "FN_arrayReturn");
private _rareVestLoot = ["vestRare"] call (missionNamespace getVariable "FN_arrayReturn");
private _rareWeaponLoot = ["primaryRare"] call (missionNamespace getVariable "FN_arrayReturn");
private _rareWeaponItems = ["muzzleRare"] call (missionNamespace getVariable "FN_arrayReturn");

//Selecting how many will go into the crate and adding the items to the crate
private _rndNum = ceil (random 3);
for "_i" from 1 to _rndNum do {
        if (_levelGear == 0) then { _rndNumCR = [1, 20] call BIS_fnc_randomInt; };
        if (_levelGear == 1) then { _rndNumCR = [15, 20] call BIS_fnc_randomInt; };
        if (_levelGear == 2) then { _rndNumCR = 20; };
        if (_rndNumCR == 20) then { _CRVest = true } else { _CRVest = false };
        if (_CRVest) then {
                _box addItemCargoGlobal [(_rareVestLoot call BIS_fnc_selectRandomWeighted), 1];
        } else {
                _box addItemCargoGlobal [(_commonVestLoot call BIS_fnc_selectRandomWeighted), 1];
        };
};

for "_i" from 1 to _rndNum do {
        if (_levelGear == 0) then { _rndNumCR = [1, 20] call BIS_fnc_randomInt; };
        if (_levelGear == 1) then { _rndNumCR = [15, 20] call BIS_fnc_randomInt; };
        if (_levelGear == 2) then { _rndNumCR = 20; };
        if (_rndNumCR == 20) then { _CRWeapon = true } else { _CRWeapon = false };
        if (_CRWeapon) then {
                _rndWeapon = _rareWeaponLoot call BIS_fnc_selectRandomWeighted;
                _box addItemCargoGlobal [_rndWeapon, 1];
                _mags = _rndWeapon call BIS_fnc_compatibleMagazines;
                _rndMagNum = [1, 5] call BIS_fnc_randomInt;
                _box addItemCargoGlobal [(_mags select 0), _rndMagNum];
        } else {
                _rndWeapon = _commonWeaponLoot call BIS_fnc_selectRandomWeighted;
                _box addItemCargoGlobal [_rndWeapon, 1];
                _mags = _rndWeapon call BIS_fnc_compatibleMagazines;
                _rndMagNum = [1, 5] call BIS_fnc_randomInt;
                _box addItemCargoGlobal [(_mags select 0), _rndMagNum];
        };
};

_rndNum = ceil (random 3);
for "_i" from 1 to _rndNum do {
        if (_levelGear == 0) then { _rndNumCR = [1, 20] call BIS_fnc_randomInt; };
        if (_levelGear == 1) then { _rndNumCR = [15, 20] call BIS_fnc_randomInt; };
        if (_levelGear == 2) then { _rndNumCR = 20; };
        if (_rndNumCR == 20) then { _CRHeadgear = true } else { _CRHeadgear = false };
        if (_CRHeadgear) then {
                _box addItemCargoGlobal [(_rareHeadgearLoot call BIS_fnc_selectRandomWeighted), 1];
        } else {
                _box addItemCargoGlobal [(_commonHeadgearLoot call BIS_fnc_selectRandomWeighted), 1];
        };
};

if ((random 1) > .9) then {
        _rndNum = ceil (random [1, 2, 4]);
        for "_i" from 1 to _rndNum do {
                _box addItemCargoGlobal [(_uniforms call BIS_fnc_selectRandomWeighted), 1];
        };
};

_rndNum = ceil (random 3);
for "_i" from 1 to _rndNum do {
        if (_levelGear == 0) then { _rndNumCR = [1, 20] call BIS_fnc_randomInt; };
        if (_levelGear == 1) then { _rndNumCR = [15, 20] call BIS_fnc_randomInt; };
        if (_levelGear == 2) then { _rndNumCR = 20; };
        if (_rndNumCR == 20) then { _CRHeadgear = true } else { _CRHeadgear = false };
        if (_CRHeadgear) then { _box addItemCargoGlobal [(_rareWeaponItems call BIS_fnc_selectRandomWeighted), 1]; };
};

_rndNum = ceil (random 5);
for "_i" from 1 to _rndNum do {
        _box addItemCargoGlobal [(_firstAidSelection call BIS_fnc_selectRandomWeighted), 1];
};

_rndNum = ceil (random 2);
for "_i" from 1 to _rndNum do {
        _box addItemCargoGlobal [(_waterSelection call BIS_fnc_selectRandomWeighted), 1];
};

_rndNum = ceil (random 2);
for "_i" from 1 to _rndNum do {
        _box addItemCargoGlobal [(_foodSelection call BIS_fnc_selectRandomWeighted), 1];
};

_rndNum = ceil (random 2);
for "_i" from 1 to _rndNum do {
        _box addItemCargoGlobal [(_explosives call BIS_fnc_selectRandomWeighted), 1];
};

_rndNum = ceil (random [0, 2, 5]);
for "_i" from 1 to _rndNum do {
        _box addItemCargoGlobal [(_miscItems call BIS_fnc_selectRandomWeighted), 1];
};

_rndNum = ceil (random 2);
for "_i" from 1 to _rndNum do {
        _box addItemCargoGlobal [(_backpackItems call BIS_fnc_selectRandomWeighted), 1];
};

if (_levelGear == 2 && (round(random 3) == 2)) then {
        _box addItemCargoGlobal [(_nvgs call BIS_fnc_selectRandomWeighted), 1];
};