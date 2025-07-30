if (isNil "LB_currentDrinkActions") then {
    LB_currentDrinkActions = [];
};

player addEventHandler ["Take", {
    [player] call FN_updateDrinkActions;
}];

player addEventHandler ["Put", {
    [player] call FN_updateDrinkActions;
}];

player addEventHandler ["InventoryClosed", {
    [player] call FN_updateDrinkActions;
}];
