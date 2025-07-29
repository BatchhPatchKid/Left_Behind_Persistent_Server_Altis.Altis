params ["_factionArray", "_excludeFaction"];
private _factionSelected = _excludeFaction;
while {_factionSelected == _excludeFaction} do {
	_factionSelected = selectRandomWeighted _factionArray;
};
_factionSelected