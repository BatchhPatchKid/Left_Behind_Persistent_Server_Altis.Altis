params ["_player"];

_player setVariable ["prayStatus", 0, true];
private _keepPraying = _player getVariable ["ritualStatus",0];

private _add = 0.1;

private _churches = nearestTerrainObjects [_player, ["CHAPEL", "CHURCH", "CROSS"], 10];

private _bodies = (getPos _player) nearObjects ["no_skin_open_chest", 10];

if (count _churches > 0) then {
	_add = _add + .2;
};

if (count _bodies > 0) then {
	{
		_add = _add + .02;
	} forEach _bodies
};

private _id = _player addAction ["Stop Praying", {
  params ["_target","_caller","_actionId","_args"];
  
  _target setVariable ["prayStatus", 1, true];

  _target removeAction _actionId;
}];

[_player, "Acts_Grieving"] remoteExec ["switchMove", _player];

while {true} do {
	_player setVariable ["ritualStatus", (_player getVariable ["ritualStatus",0]) + _add, true];
	
	_keepPraying = _player getVariable ["prayStatus",0];
	if (_keepPraying == 1) exitWith {
		[_player, ""] remoteExec ["switchMove", _player];
	};

	sleep 1;
};