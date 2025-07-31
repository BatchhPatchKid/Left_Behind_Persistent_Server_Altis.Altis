/*
  spawnEmptyMutants.sqf
  ---------------------
  Spawns a specified number of mutants by first creating them in a civilian group,
  then moving each into its own empty‐side group.
  Usage: [count] execVM "spawnEmptyMutants.sqf";
*/
params ["_count"];

private _pos = getPos player;
private _horde = createGroup east;
private _civHorde = createGroup civilian;

for "_i" from 1 to _count do {
    private _unit = _horde createUnit [
        "Zombie_O_Shambler_Civ", _pos, [], 0, "FORM"
    ];
};

{
	[_x] joinSilent _civHorde;
} forEach units _horde;