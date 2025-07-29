if (isNil "LB_currentDrinkActions") then {
    LB_currentDrinkActions = [];
};

player addEventHandler ["InventoryChanged", {
    // Prevent over-triggering
    if (!isNil "LB_lastDrinkUpdate" && time < LB_lastDrinkUpdate + 1) exitWith {};
    LB_lastDrinkUpdate = time;

    [player] call FN_updateDrinkActions;
}];
