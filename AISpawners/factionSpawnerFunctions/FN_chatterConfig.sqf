// Configuration for AI radio chatter

// Spawn lines spoken when a unit is created
_spawnLines = createHashMapFromArray [
    ["US", [ // United States
        "Eagle team on station.",
        "Razor squad reporting for duty."
    ]],
    ["RU", [ // Russia
        "Vympel unit ready.",
        "For the motherland!"
    ]],
    ["TRB", [ //The Red Bullet
        "Tribal hunters arrived.",
        "The spirits guide us."
    ]],
    ["PMC", [ //PMC Group Alpha
        "Contractors deployed.",
        "Mission is green."
    ]],
    ["ALF", [ //Altis Liberation Front
        "Freedom fighters assembled.",
        "Liberty or death."
    ]],
    ["Renegade", [
        "Renegade operative present."
    ]],
    // New factions
    ["BB", [  // Boonie Boys
        "Boonie Boys mobilizing.",
        "Vegetation scouts ready."
    ]],
    ["SU", [  // Survivors Union
        "Survivors Union online.",
        "Strength in numbers."
    ]],
    ["Bandits", [
        "Bandit crew assembled.",
        "Time to raid."
    ]],
    ["NH", [  // New Horizon
        "New Horizon has arrived.",
        "A new dawn begins."
    ]],
    ["DT", [  // Deadman's Trident
        "Deadman's Trident emerges.",
        "Three prongs of death."
    ]],
    ["WO", [  // World Order
        "World Order initiated.",
        "Compliance is mandatory."
    ]]
];

// Regular chatter lines used after spawning
_chatterLines = createHashMapFromArray [
    ["US", [
        "Stay frosty.",
        "Eyes open out there."
    ]],
    ["RU", [
        "Keep moving.",
        "Hold this ground."
    ]],
    ["TRB", [
        "Another day, another hunt.",
        "We take what we can."
    ]],
    ["PMC", [
        "Time is money.",
        "Watch the corners."
    ]],
    ["ALF", [
        "Freedom for Altis.",
        "Stay with the group."
    ]],
    ["Renegade", [
        "Nobody tells us what to do.",
        "Chaos reigns."
    ]],
    ["BB", [
        "Bush camo on point.",
        "Watch for ambush."
    ]],
    ["SU", [
        "Band together.",
        "Stay vigilant."
    ]],
    ["Bandits", [
        "Keep your pockets full.",
        "No mercy."
    ]],
    ["NH", [
        "Bright future ahead.",
        "Keep moving forward."
    ]],
    ["DT", [
        "Below the waves.",
        "Strike deep."
    ]],
    ["WO", [
        "Order above all.",
        "Prepare for protocol."
    ]]
];


// Combat chatter lines used when units are engaged
_combatLines = createHashMapFromArray [
    ["US", [
        "Contact!",
        "We're taking fire!"
    ]],
    ["RU", [
        "Enemy ahead!",
        "Open fire!"
    ]],
    ["TRB", [
        "Strike true!",
        "Defend the tribe!"
    ]],
    ["PMC", [
        "Hostiles engaging!",
        "Return fire!"
    ]],
    ["ALF", [
        "For Altis!",
        "Hold the line!"
    ]],
    ["Renegade", [
        "No rules now!",
        "Light 'em up!"
    ]],
    ["BB", [
        "From the bush!",
        "Camouflage strike!"
    ]],
    ["SU", [
        "Union, stand firm!",
        "Push them back!"
    ]],
    ["Bandits", [
        "Take them down!",
        "Loot awaits!"
    ]],
    ["NH", [
        "Future fights now!",
        "Drive them out!"
    ]],
    ["DT", [
        "Cut through them!",
        "Trident strike!"
    ]],
    ["WO", [
        "Maintain order!",
        "Neutralize target!"
    ]]
];

// Callsigns used for group IDs
_callsigns = createHashMapFromArray [
    ["US", ["Eagle", "Razor", "Viper"]],
    ["RU", ["Bear", "Hammer", "Vodka"]],
    ["TRB", ["Totem", "Spirit", "Wolf"]],
    ["PMC", ["Mamba", "Ghost", "Raven"]],
    ["ALF", ["Freedom", "Rebel", "Liberty"]],
    ["Renegade", ["Rogue", "Bandit", "Outlaw"]],
    ["BB", ["Brush", "Briar", "Camouflage"]],
    ["SU", ["Unity", "Solidarity", "Shield"]],
    ["Bandits", ["Skull", "Fang", "Scorpion"]],
    ["NH", ["Dawn", "Aurora", "Horizon"]],
    ["DT", ["Trident", "Poseidon", "Leviathan"]],
    ["WO", ["Axis", "Vector", "Prime"]]
];

missionNamespace setVariable ["LB_spawnLines", _spawnLines];
missionNamespace setVariable ["LB_chatterLines", _chatterLines];
missionNamespace setVariable ["LB_combatLines", _combatLines];
missionNamespace setVariable ["LB_callsigns", _callsigns];