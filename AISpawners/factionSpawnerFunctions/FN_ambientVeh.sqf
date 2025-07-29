params ["_pos", "_triggerRadius"];

_vehArray = ["defaultVeh"] call (missionNamespace getVariable "FN_arrayReturn");
_roadPosition = [0,0,0];

for "_i" from 0 to (round(random [1, 3, 6])) do { // possibly spawning 1 to 4 vehicles
    if ((round(random [1, 5, 10])) >= 5) then {
        _roadPositions = nearestTerrainObjects [_pos, ["ROAD", "MAIN ROAD", "TRAIL"], (_triggerRadius / 1.25)];
        if (count _roadPositions > 0 && !(isNil "_roadPositions")) then {
            while {true} do {
                _roadPosition = getPos (selectRandom _roadPositions);
                _collisionObjects = nearestObjects [_roadPosition, ["empty", "car"], 5];
                _nearPlayers = { _roadPosition distance _x < 200 } count allPlayers;
                if (_nearPlayers == 0 && player distance _roadPosition > 100 && (count _collisionObjects) < 1) exitWith {};
            };
        } else {
            while {true} do {
                _roadPosition = [_pos, 15, 200, 6, 0, 20, 0, [], []] call BIS_fnc_findSafePos;
                _collisionObjects = nearestObjects [_roadPosition, ["empty", "car"], 5];
                _nearPlayers = { _roadPosition distance _x < 200 } count allPlayers;
                if (_nearPlayers == 0 && player distance _roadPosition > 100 && (count _collisionObjects) < 1) exitWith {};
            };
        };

        _veh = (_vehArray call BIS_fnc_selectRandomWeighted) createVehicle _roadPosition;
        _veh setDir (random 360);

        clearWeaponCargoGlobal _veh;
        clearMagazineCargoGlobal _veh;
        clearItemCargoGlobal _veh;

        {
            _veh setHitPointDamage [_x, (random [.65, .75, .8])];
        } forEach ["HitEngine", "HitFuel", "HitHRotor", "HitVRotor", "HitHull", "wheel_1_1_steering", "wheel_1_2_steering", "wheel_2_1_steering", "wheel_2_2_steering", "wheel_1_3_steering", "wheel_2_3_steering", "wheel_1_4_steering", "wheel_2_4_steering"];

        _veh setFuel (random [0, .015, .03]);
        _veh setHitPointDamage ["HitL", 0]; // Ensure the left headlight is not damaged
        _veh setHitPointDamage ["HitR", 0]; // Ensure the right headlight is not damaged

        _veh setLightBrightness 10; // Set the brightness of the left headlight to maximum
        _veh setLightDayLight true; // Force the left headlight to be on during daylight
    };
};