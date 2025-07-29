params ["_faction"];

_meleeChance = 0;
if (_faction == "Renegade") then {
	_meleeChance = 0.35;
};
if (_faction == "Bandit") then {
	_meleeChance = 0.30;
};
if (_faction == "BB") then {
	_meleeChance = 0.35;
}; 
if (_faction == "DT") then {
	_meleeChance = 0.50;
};
if (_faction == "NH") then {
	_meleeChance = 0.30;
};
if (_faction == "PF") then {
	_meleeChance = 0.60;
};
if (_faction == "RC") then {
	_meleeChance = 0.10;
};
if (_faction == "TRB") then {
	_meleeChance = 0.15;
};
if (_faction == "US") then {
	_meleeChance = 0;
};
if (_faction == "SU") then {
	_meleeChance = 0.25;	
};
if (_faction == "RU") then {
	_meleeChance = 0;	
};
if (_faction == "ROA") then {
	_meleeChance = 0;	
};
if (_faction == "PMC") then {
	_meleeChance = 0;	
};
if (_faction == "WO") then {
	_meleeChance = 0.15;	
};
if (_faction == "ALF") then {
	_meleeChance = 0;	
};

_meleeChance