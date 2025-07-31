params ["_grp", "_vehicles", "_extraUnits"];
{
    _x enableDynamicSimulation true;
} forEach (_extraUnits + units _grp);
{ _x enableDynamicSimulation true; } forEach _vehicles;
_grp enableDynamicSimulation true;