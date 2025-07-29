params ["_arrayToConvert"];

_nonWeightedArray = [];
{
	if ((typeName _x) == "STRING") then {
		_nonWeightedArray pushBack _x;
	};
	sleep .01;
} forEach _arrayToConvert;

_nonWeightedArray;