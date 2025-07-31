params ["_unit"];
[_unit] spawn {
	// Refresh the faction alliance check
	params ["_unit"];
	[_unit] call FN_factionClothingCheck;

	private _factions = [
		["BB_Relation",   "Boonie Boys (BB)"],
		["SU_Relation",   "Survivors Union (SU)"],
		["PF_Relation",   "Pigs Flesh (PF)"],
		["ALF_Relation",  "Altis Liberation Front (ALF)"],
		["WO_Relation",   "World Order (WO)"],
		["RU_Relation",   "Russian Federation (RU)"],
		["US_Relation",   "United States Army (US)"],
		["NH_Relation",   "New Horizon (NH)"],
		["TRB_Relation",  "The Red Bullet (TRB)"],
		["RC_Relation",   "Ravens Cloak (RC)"],
		["DT_Relation",   "Deadmans Trident (DT)"],
		["ROA_Relation",  "Republic of Altis (ROA)"],
		["PMC_Relation",  "PMC Group Alpha (PMC)"],
		["Bandit_Relation", "Bandits"],
		["Renegade_Relation", "Renegades"]
	];

	private _relations = [];

	{
		private _var = _x select 0;
		private _name = _x select 1;

		if (player getVariable [_var, false]) then {
			_relations pushBack _name;
		};
	} forEach _factions;

	private _relationString = if (_relations isEqualTo []) then {
		"You are not friendly with any factions."
	} else {
		format ["You are friendly with factions: %1", _relations joinString " and "]
	};

	hint _relationString;
	sleep 6;
	hintSilent "";
};