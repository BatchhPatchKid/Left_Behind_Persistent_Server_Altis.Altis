// Configuration for AI radio chatter

// Spawn lines spoken when a unit is created
/*_spawnLines = createHashMapFromArray [
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

missionNamespace setVariable ["LB_spawnLines", _spawnLines];
missionNamespace setVariable ["LB_chatterLines", _chatterLines];
missionNamespace setVariable ["LB_combatLines", _combatLines];

// Lines triggered when a unit fires its weapon
_firedLines = createHashMapFromArray [
    ["US", ["Target spotted.", "Weapons hot."]],
    ["RU", ["Engaging target.", "Fire at will."]],
    ["TRB", ["Loose the arrows!", "Strike from the wilds!"]],
    ["PMC", ["Contractor engaging.", "Opening fire."]],
    ["ALF", ["For Altis!", "Freedom fires!"]],
    ["Renegade", ["Make it rain!", "Unleash chaos!"]],
    ["BB", ["From the brush!", "Let 'em fly!"]],
    ["SU", ["Union guns hot.", "Engage!" ]],
    ["Bandits", ["Take the shot!", "Blast 'em!" ]],
    ["NH", ["Advancing fire!", "Push forward!" ]],
    ["DT", ["Trident strikes!", "Fire from the deep!" ]],
    ["WO", ["Enforce order!", "Execute protocol!" ]]
];

// Lines triggered when a unit is hit
_hitLines = createHashMapFromArray [
    ["US", ["I'm hit!", "Taking fire!"]],
    ["RU", ["Contact on me!", "I'm under fire!"]],
    ["TRB", ["The spirits shield me!", "They strike us!"]],
    ["PMC", ["I've been hit!", "Need cover!"]],
    ["ALF", ["Freedom bleeds!", "They got me!"]],
    ["Renegade", ["They tagged me!", "Hit but not down!"]],
    ["BB", ["Branches won't stop that!", "I've been spotted!"]],
    ["SU", ["Union wounded!", "Need assist!"]],
    ["Bandits", ["They got me!", "Cover me!"]],
    ["NH", ["Future takes a hit!", "Under pressure!"]],
    ["DT", ["Hull breach!", "Taking on water!"]],
    ["WO", ["Order disrupted!", "Stabilize me!"]]
];

// Lines triggered when a unit dies
_deathLines = createHashMapFromArray [
    ["US", ["Eagle down!", "We've lost one!"]],
    ["RU", ["Comrade down!", "One of ours is gone!"]],
    ["TRB", ["A hunter falls!", "Spirits receive me!"]],
    ["PMC", ["Contractor down!", "We lost a man!"]],
    ["ALF", ["Freedom fighter fallen!", "Altis remembers!"]],
    ["Renegade", ["Renegade down!", "Chaos claims another!"]],
    ["BB", ["Boonie down!", "The bush claims one!"]],
    ["SU", ["Union member lost!", "We've lost a comrade!"]],
    ["Bandits", ["Bandit down!", "They got one of us!"]],
    ["NH", ["New horizon fades!", "We lose a pioneer!"]],
    ["DT", ["Trident snapped!", "Depths take me!"]],
    ["WO", ["Order unit lost!", "Protocol failure!"]]
];

missionNamespace setVariable ["LB_firedLines", _firedLines];
missionNamespace setVariable ["LB_hitLines", _hitLines];
missionNamespace setVariable ["LB_deathLines", _deathLines];