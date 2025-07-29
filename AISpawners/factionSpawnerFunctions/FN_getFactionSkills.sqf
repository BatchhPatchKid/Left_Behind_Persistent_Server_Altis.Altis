params ["_faction", "_pos"];

// Default values
private _side = independent;
private _unit = "I_G_Survivor_F";
private _aim = 0;
private _aimSpeed = 0;
private _spot = 0;
private _courage = 0.75;
private _aimShake = 0;
private _command = 0;
private _spotDist = 0;
private _reload = 0;
private _sfGroup = 100;
private _playersRelationArray = [];
private _distForAllyToTakeEffect = 1500;

// Faction-specific settings
private _factionSettings = [ //aim, aimSpeed, spot, courage, aimShake, command, spotDist, reload, sfGroup
	["Bandit", [0.3, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 50, "Bandit_Relation"]],
	["BB", [0.3, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 50, "BB_Relation"]],
	["DT", [0.15, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 50, "DT_Relation"]],
	["NH", [0.20, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 50, "NH_Relation"]],
	["PF", [0.20, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 35, "PF_Relation"]],
	["RC", [0.55, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 35, "RC_Relation"]],
	["TRB", [0.55, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 35, "TRB_Relation"]],
	["US", [0.85, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 10, "US_Relation"]],
	["SU", [0.3, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 40, "SU_Relation"]],
	["RU", [0.85, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 10, "RU_Relation"]],
	["ROA", [0.65, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 25, "ROA_Relation"]],
	["PMC", [0.85, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 30, "PMC_Relation"]],
	["WO", [0.4, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 35, "WO_Relation"]],
	["ALF", [0.65, 0.5, 0.4, 0.75, 0.4, 0.5, 0.5, 0.6, 25, "ALF_Relation"]]
];

// Find faction settings
private _factionData = _factionSettings select { _x select 0 == _faction };
if (count _factionData > 0) then {
	private _skills = (_factionData select 0) select 1; //grabbing the faction skills
	_aim = _skills select 0;
	_aimSpeed = _skills select 1;
	_spot = _skills select 2;
	_courage = _skills select 3;
	_aimShake = _skills select 4;
	_command = _skills select 5;
	_spotDist = _skills select 6;
	_reload = _skills select 7;
	_sfGroup = _skills select 8; //Lower the number, the more likely the units will be spec ops (0 being all the time)
	private _relationVar = _skills select 9;

	// Check player relations
	{
		if (_x distance _pos < _distForAllyToTakeEffect) then {
			_relation = _x getVariable _relationVar;
			_playersRelationArray pushBack _relation;
		};
	} forEach allPlayers;

	if (_playersRelationArray findIf { _x } != -1) then {
		_unit = "B_G_Survivor_F";
		_side = west;
	} else {
		if (_faction == "RU") then {
			_unit = "O_G_Survivor_F";
			_side = east;
		} else {
			_unit = "I_G_Survivor_F";
			_side = independent;
		};
	};
};

// Return the results
[_side, _unit, _aim, _aimSpeed, _spot, _courage, _aimShake, _command, _spotDist, _reload, _sfGroup]