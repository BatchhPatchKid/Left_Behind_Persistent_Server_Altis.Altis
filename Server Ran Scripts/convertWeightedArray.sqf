params ["_arrayToConvert"];

private _nonWeightedArray = [];
{
    if (typeName _x isEqualTo "STRING") then {
        _nonWeightedArray pushBack _x;
    };
} forEach _arrayToConvert;

_nonWeightedArray;