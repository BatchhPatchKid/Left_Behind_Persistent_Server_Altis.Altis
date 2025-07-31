params ["_grpToChange"];

private _grpCiv = createGroup civilian;

{
	[_x] joinSilent _grpCiv;
	_x addRating -1000;
} forEach units _grpToChange;

_grpCiv