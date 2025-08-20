params ["_player"];

_player setVariable ["prayStatus", 0, true];
private _keepPraying = _player getVariable ["prayStatus",0];

private _addPig = 0;
private _addZeus = 0;
private _addWanderer = 0;

//Checking for Pig Flesh ritual pray objects
private _churches = nearestTerrainObjects [_player, ["CHAPEL", "CHURCH", "CROSS"], 10];
private _bodies = (getPos _player) nearObjects ["no_skin_open_chest", 10];

if (count _bodies > 0 && count _churches > 0) then {
	_addPig = .1;
	{
		_addPig = _addPig + .01;
	} forEach _bodies
};

//Checking for Deadman's Trident ritual pray objects 
private _pos = getPosASL player;
private _nearWater = false;
private _radiusToCheck = 10;

// Check in a radius around the player
for "_i" from 0 to 359 step 45 do {
    private _offset = [(_pos select 0) + _radiusToCheck * cos _i, (_pos select 1) + _radiusToCheck * sin _i, 0];

    if (surfaceIsWater _offset) exitWith { 
			if (count _churches > 0) then {
				_addZeus = _addZeus + .05;
			};

			_addZeus = _addZeus + .1; 
		};
};

//Checkig for Wanderer pray objects 
if (sunOrMoon < 0.35 && count _churches > 0) then {
	_addWanderer = .1;

	private _types = [
		"Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue",
		"ACE_Chemlight_IR","ACE_Chemlight_HiGreen","ACE_Chemlight_HiRed","ACE_Chemlight_HiWhite"
	];
	private _chems = nearestObjects [_player, _types, 10];

	{
		_addWanderer = _addWanderer + .005;
	} forEach _chems;
};

//if the player is not near any spots for prayer, then exit early to not waste the player's time
if (_addPig == 0 && _addZeus == 0 && _addWanderer == 0) exitWith { ["The requirements for praying have not been met"] remoteExec ["hint", _player]; };

private _id = _player addAction ["Stop Praying", {
  params ["_target","_caller","_actionId","_args"];
  
  _target setVariable ["prayStatus", 1, true];

  _target removeAction _actionId;
}];

[_player, "Acts_Grieving"] remoteExec ["switchMove", 0, true];

while {true} do {
	_player setVariable ["ritualStatusPig", (_player getVariable ["ritualStatusPig",0]) + _addPig, true];
	_player setVariable ["ritualStatusZeus", (_player getVariable ["ritualStatusZeus",0]) + _addZeus, true];
	_player setVariable ["ritualStatusWanderer", (_player getVariable ["ritualStatusWanderer",0]) + _addWanderer, true];
	
	_keepPraying = _player getVariable ["prayStatus",0];
	if (_keepPraying == 1) exitWith {
		[_player, ""] remoteExec ["switchMove", 0, true];
	};

	sleep 1;
};