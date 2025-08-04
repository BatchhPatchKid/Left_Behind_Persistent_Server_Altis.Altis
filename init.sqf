// Compiling functions and storing them in the missionNamespace

missionNamespace setVariable ["FN_findSafePosition", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_findSafePosition.sqf"];
missionNamespace setVariable ["FN_createAIUnit", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_createAIUnit.sqf"];
missionNamespace setVariable ["FN_setUnitSkills", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_setUnitSkills.sqf"];
missionNamespace setVariable ["FN_selectFaction", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_selectFaction.sqf"];
missionNamespace setVariable ["FN_createWaypoints", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_createWaypoints.sqf"];
missionNamespace setVariable ["FN_spawnWanderingFaction", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_spawnWanderingFaction.sqf"];
missionNamespace setVariable ["FN_spawnHuntingFaction", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_spawnHuntingFaction.sqf"];
missionNamespace setVariable ["FN_getFactionSkills", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_getFactionSkills.sqf"];
missionNamespace setVariable ["FN_createObject_Fortifications", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\campFortificationsScripts\FN_createObject_Fortifications.sqf"];
missionNamespace setVariable ["FN_spawnAI_Fortifications", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\campFortificationsScripts\FN_spawnAI_Fortifications.sqf"];
missionNamespace setVariable ["FN_fortificationsMain", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\campFortificationsScripts\FN_fortificationsMain.sqf"];
missionNamespace setVariable ["FN_fortificationsAux", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\campFortificationsScripts\FN_fortificationsAux.sqf"];
missionNamespace setVariable ["FN_arrayReturn", compileFinal  preprocessFileLineNumbers "ArrayDatabase.sqf"];
missionNamespace setVariable ["FN_convertWeightedArray", compileFinal  preprocessFileLineNumbers "Server Ran Scripts\convertWeightedArray.sqf"];
missionNamespace setVariable ["FN_ambientVeh", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_ambientVeh.sqf"];
missionNamespace setVariable ["FN_factionSelector", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_factionSelector.sqf"];
missionNamespace setVariable ["FN_ZTriggerSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\FN_ZTriggerSpawner.sqf"];
missionNamespace setVariable ["FN_spawnAI", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_spawnAI.sqf"];
missionNamespace setVariable ["FN_equipAI", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_equipAI.sqf"];
missionNamespace setVariable ["FN_renegadeSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_renegadeSpawner.sqf"];
missionNamespace setVariable ["FN_meleeChance", compileFinal  preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_meleeChance.sqf"];
missionNamespace setVariable ["FN_factionSpawnerMain", compileFinal  preprocessFileLineNumbers "AISpawners\FN_factionSpawnerMain.sqf"];
missionNamespace setVariable ["FN_lootSpawner", compileFinal  preprocessFileLineNumbers "LootSystem\FN_lootSpawner.sqf"];
missionNamespace setVariable ["FN_fillLootCrate", compileFinal  preprocessFileLineNumbers "LootSystem\FN_fillLootCrate.sqf"];
missionNamespace setVariable ["FN_spawnLootCrate", compileFinal  preprocessFileLineNumbers "LootSystem\FN_spawnLootCrate.sqf"];
missionNamespace setVariable ["FN_lootGarbageSystem", compileFinal  preprocessFileLineNumbers "Server Ran Scripts\FN_lootGarbageSystem.sqf"];
missionNamespace setVariable ["FN_attachAceLoot", compileFinal  preprocessFileLineNumbers "LootSystem\FN_attachAceLoot.sqf"];
missionNamespace setVariable ["FN_spawnLootGround", compileFinal  preprocessFileLineNumbers "LootSystem\FN_spawnLootGround.sqf"];
missionNamespace setVariable ["FN_ExitingTrigger", compileFinal  preprocessFileLineNumbers "ExitingTrigger.sqf"];
missionNamespace setVariable ["FN_Conversations", compileFinal  preprocessFileLineNumbers "Economy System\Conversations.sqf"];
missionNamespace setVariable ["FN_economySystem", compileFinal  preprocessFileLineNumbers "Economy System\economySystem.sqf"];
missionNamespace setVariable ["FN_economySystemCrate", compileFinal  preprocessFileLineNumbers "Economy System\economySystemCrate.sqf"];
missionNamespace setVariable ["FN_spawnStaticTrader", compileFinal  preprocessFileLineNumbers "Economy System\spawnStaticTrader.sqf"];
missionNamespace setVariable ["FN_traderTasks", compileFinal  preprocessFileLineNumbers "Economy System\traderTasks.sqf"];
missionNamespace setVariable ["FN_specialVehicleSpawns", compileFinal  preprocessFileLineNumbers "Ambient\FN_specialVehicleSpawns.sqf"];
missionNamespace setVariable ["FN_factionArea", compileFinal  preprocessFileLineNumbers "Ambient\FN_factionArea.sqf"];
missionNamespace setVariable ["FN_spawnZom", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\FN_spawnZom.sqf"];
missionNamespace setVariable ["FN_drinkWater", compileFinal  preprocessFileLineNumbers "Ambient\FN_drinkWater.sqf"];
missionNamespace setVariable ["FN_refillCanteen", compileFinal  preprocessFileLineNumbers "Ambient\FN_refillCanteen.sqf"];
missionNamespace setVariable ["FN_updateDrinkActions", compileFinal preprocessFileLineNumbers "Ambient\FN_updateDrinkActions.sqf"];
missionNamespace setVariable ["FN_updateEatActions", compile preprocessFileLineNumbers "Ambient\FN_updateEatActions.sqf"];
missionNamespace setVariable ["FN_purifyWater", compileFinal  preprocessFileLineNumbers "Ambient\FN_purifyWater.sqf"];
missionNamespace setVariable ["FN_eatFood", compileFinal  preprocessFileLineNumbers "Ambient\FN_eatFood.sqf"];
missionNamespace setVariable ["FN_skinAnimal", compileFinal  preprocessFileLineNumbers "Ambient\FN_skinAnimal.sqf"];
missionNamespace setVariable ["FN_cookMeat", compileFinal preprocessFileLineNumbers "Ambient\FN_cookMeat.sqf"];
missionNamespace setVariable ["FN_createFire", compileFinal preprocessFileLineNumbers "Ambient\FN_createFire.sqf"];
missionNamespace setVariable ["FN_sanitySystem", compileFinal preprocessFileLineNumbers "Ambient\FN_sanitySystem.sqf"];
missionNamespace setVariable ["FN_defecate", compileFinal preprocessFileLineNumbers "Ambient\FN_defecate.sqf"];
missionNamespace setVariable ["FN_theRuns", compileFinal preprocessFileLineNumbers "Ambient\FN_theRuns.sqf"];
missionNamespace setVariable ["411Spawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\411Spawner.sqf"];
missionNamespace setVariable ["AbominationSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\AbominationSpawner.sqf"];
missionNamespace setVariable ["GoliathSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\GoliathSpawner.sqf"];
missionNamespace setVariable ["HellspawnSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\HellspawnSpawner.sqf"];
missionNamespace setVariable ["MindflayerSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\MindflayerSpawner.sqf"];
missionNamespace setVariable ["RakeSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\RakeSpawner.sqf"];
missionNamespace setVariable ["ShadowmenSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\ShadowmenSpawner.sqf"];
missionNamespace setVariable ["SkullsSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\SkullsSpawner.sqf"];
missionNamespace setVariable ["SnatcherSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\SnatcherSpawner.sqf"];
missionNamespace setVariable ["StatueSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\StatueSpawner.sqf"];
missionNamespace setVariable ["TankSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\TankSpawner.sqf"];
missionNamespace setVariable ["VampireSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\VampireSpawner.sqf"];
missionNamespace setVariable ["VariousMutantSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\VariousMutantSpawner.sqf"];
missionNamespace setVariable ["WendigoSpawner", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\WendigoSpawner.sqf"];
missionNamespace setVariable ["mutantEffects", compileFinal  preprocessFileLineNumbers "AISpawners\mutantSpawners\mutantEffects.sqf"];
missionNamespace setVariable ["inclimateWeather", compileFinal  preprocessFileLineNumbers "Ambient\inclimateWeather.sqf"];
missionNamespace setVariable ["FN_PurchaseItem", compileFinal  preprocessFileLineNumbers "Economy System\functions\FN_PurchaseItem.sqf"];
missionNamespace setVariable ["FN_PurchaseMag", compileFinal  preprocessFileLineNumbers "Economy System\functions\FN_PurchaseMag.sqf"];
missionNamespace setVariable ["FN_SellAction", compileFinal  preprocessFileLineNumbers "Economy System\functions\FN_SellAction.sqf"];
missionNamespace setVariable ["FN_addItemToAmmoBox", compileFinal  preprocessFileLineNumbers "Economy System\functions\FN_addItemToAmmoBox.sqf"];
missionNamespace setVariable ["FN_ammoBoxCheck", compileFinal  preprocessFileLineNumbers "Economy System\functions\FN_ammoBoxCheck.sqf"];
missionNamespace setVariable ["FN_BINO", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_BINO.sqf"];
missionNamespace setVariable ["FN_EXPLOSIVE", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_EXPLOSIVE.sqf"];
missionNamespace setVariable ["FN_GRENADES", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_GRENADES.sqf"];
missionNamespace setVariable ["FN_MISC", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_MISC.sqf"];
missionNamespace setVariable ["FN_NVG", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_NVG.sqf"];
missionNamespace setVariable ["FN_ResetMenu", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_ResetMenu.sqf"];
missionNamespace setVariable ["FN_UNDERRAIL", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_UNDERRAIL.sqf"];
missionNamespace setVariable ["FN_backPack", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_backPack.sqf"];
missionNamespace setVariable ["FN_chestRig", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_chestRig.sqf"];
missionNamespace setVariable ["FN_clothing", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_clothing.sqf"];
missionNamespace setVariable ["FN_launchers", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_launchers.sqf"];
missionNamespace setVariable ["FN_mags", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_mags.sqf"];
missionNamespace setVariable ["FN_muzzle", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_muzzle.sqf"];
missionNamespace setVariable ["FN_optics", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_optics.sqf"];
missionNamespace setVariable ["FN_primary", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_primary.sqf"];
missionNamespace setVariable ["FN_rail", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_rail.sqf"];
missionNamespace setVariable ["FN_sidearms", compileFinal  preprocessFileLineNumbers "Economy System\functions\actionFunctions\FN_sidearms.sqf"];
missionNamespace setVariable ["FN_deleteCurrentTask", compileFinal  preprocessFileLineNumbers "Economy System\functions\taskFunctions\FN_deleteCurrentTask.sqf"];
missionNamespace setVariable ["FN_killTaskGroup", compileFinal  preprocessFileLineNumbers "Economy System\functions\taskFunctions\FN_killTaskGroup.sqf"];
missionNamespace setVariable ["FN_killTaskGroupStationary", compileFinal  preprocessFileLineNumbers "Economy System\functions\taskFunctions\FN_killTaskGroupStationary.sqf"];
missionNamespace setVariable ["FN_killTaskLeapers", compileFinal  preprocessFileLineNumbers "Economy System\functions\taskFunctions\FN_killTaskLeapers.sqf"];
missionNamespace setVariable ["FN_killTaskPlayer", compileFinal  preprocessFileLineNumbers "Economy System\functions\taskFunctions\FN_killTaskPlayer.sqf"];
missionNamespace setVariable ["FN_killTaskSniper", compileFinal  preprocessFileLineNumbers "Economy System\functions\taskFunctions\FN_killTaskSniper.sqf"];
missionNamespace setVariable ["garbageCollection", compileFinal  preprocessFileLineNumbers "Server Ran Scripts\garbageCollection.sqf"];
missionNamespace setVariable ["sleepTime", compileFinal  preprocessFileLineNumbers "Server Ran Scripts\sleepTime.sqf"];
missionNamespace setVariable ["onPlayerKilled", compileFinal  preprocessFileLineNumbers "onPlayerKilled.sqf"];
missionNamespace setVariable ["onPlayerRespawn", compileFinal  preprocessFileLineNumbers "onPlayerRespawn.sqf"];
missionNamespace setVariable ["teleporter", compileFinal  preprocessFileLineNumbers "teleporter.sqf"];
missionNamespace setVariable ["FN_factionClothingCheck", compileFinal  preprocessFileLineNumbers "FN_factionClothingCheck.sqf"];
missionNamespace setVariable ["temperature", compileFinal preprocessFileLineNumbers "Ambient\temperature.sqf"];
missionNamespace setVariable ["radSystem", compileFinal preprocessFileLineNumbers "Ambient\radSystem.sqf"];
missionNamespace setVariable ["randomEncounters", compileFinal preprocessFileLineNumbers "Ambient\randomEncounters.sqf"];
missionNamespace setVariable ["hydrationNutritionSystem", compileFinal preprocessFileLineNumbers "Ambient\hydrationNutritionSystem.sqf"];
missionNamespace setVariable ["FN_poopSystem", compileFinal preprocessFileLineNumbers "Ambient\FN_poopSystem.sqf"];
missionNamespace setVariable ["FN_sleep", compileFinal preprocessFileLineNumbers "FN_sleep.sqf"];
missionNamespace setVariable ["FN_setDownBaseCache", compileFinal preprocessFileLineNumbers "FN_setDownBaseCache.sqf"];
missionNamespace setVariable ["FN_checkFaction", compileFinal preprocessFileLineNumbers "FN_checkFaction.sqf"];
missionNamespace setVariable ["FN_changeGroupSide", compileFinal preprocessFileLineNumbers "AISpawners\factionSpawnerFunctions\FN_changeGroupSide.sqf"];
missionNamespace setVariable ["mutantEffects", compileFinal preprocessFileLineNumbers "AISpawners\mutantSpawners\mutantEffects.sqf"];
missionNamespace setVariable ["mutantEffects", compileFinal preprocessFileLineNumbers "AISpawners\mutantSpawners\mutantEffects.sqf"];
missionNamespace setVariable ["PF_init", compileFinal preprocessFileLineNumbers"PF\init.sqf"];

if (!isDedicated) then {
	waitUntil {!isNull player};
	sleep 0.1;

	// Define the function to add multiple diary entries
	addDiaryEntries = {
		params ["_entries"];
		
		{
			private _title = _x select 0;
			private _content = _x select 1;
			player createDiaryRecord [
				"Diary",
				[_title, _content]
			];
		} forEach _entries;
	};

	// Ensure the function is defined globally
	if (isNil "addDiaryEntries") then {
		missionNamespace setVariable ["addDiaryEntries", addDiaryEntries];
	};

	// Define the diary entries
	_diaryEntries = [
		["Base Building", "You are allowed to use ace fortify to base build in the scenario; however, due to the garbage collector, the fortifications will be deleted if you don't take the correct precautions. If you put down a flag using the self ace interactions then Scenario Actions to put down a flag. Everything around that flag within 150 meters will not despawn. That means EVERYTHING. Nothing will despawn, so if you need to delete some stuff, you must do it manually."],
		["Sleep System", "The sleep system allows the player(s) to 'sleep' through the night. The hours allowed to be slept through is 8pm to 6am. For the server to sleep through the night, all players must be 'Trying to sleep' at their respective sleeping bag. This can be accessed by putting down the sleeping bag in the ace self interactions menu. From there, look at the sleeping back that would have put at your feet, and select 'Try to sleep.' Once all the players in the server during the appropriate time are 'Trying to sleep,' this will skip the night to 6am. "],
		["Factions", "All groups on the island except the Boonie Boys and the Survivors Union start out hostile. Other factions include Pigs Flesh, Altis Liberation Front, World Order, the Russian Federation, the United States Army, New Horizon, The Red Bullet, Ravens Cloak, Deadmans Trident, the Republic of Altis, PMC Group Alpha, Bandits and Renegades. Your standing can change based on the clothing you wear; dressing like a faction or one of its allies makes them consider you friendly so long as the units spawn after the change."],
		["Deaths", "Each time a player succumbs to their wounds, an anomaly of some kind makes the player inhabit a random persons body. This kills the person that was once inhabiting the body, and makes it so the player gets to live on. This essentially makes the player invincible to death. If any factions find out about this, they will have adverse reactions. "],
		["Backstory", "EVERYONE else on the island is hostile to the player. You may make your own head canon for your character, otherwise use the following: Your name is John Smith, a native resident of the island. After surviving years in the wasteland, you've become quite hardened. You joined the closest faction to make some easy friends/allies. Your ultimate mission is to survive and thrive in the wasteland. Not just make a base and live there, but compete with other survivors and see who is truly the fittest. To do this, you must test yourself by entering mutant zones willingly and taking on entire bandit camps. At heart, you are a warrior, and you want to prove to the wasteland you are not an easy target to take advantage of."],
		["Locations", "Locations that are NOT within faction borders (any spot with a question mark) are completely random. The exact location, how many people are there, who are there, if there are zombies there, if there are multiple factions there, are there mutants also there, and more are all completely random. This makes every question marked location unique every time you visit it. Never expect the same thing each time. Be warned, this means that leaving an area will reset any factions that were there. Locations within faction borders are fairly consistent except for the amount of people there (usually), and the gear they have. <br/><br/>All locations if teleported into will NOT spawn anything. You must enter them naturally to spawn anything. So if you set up a respawn at a location, this will ensure that the location does not spawn any AI. "],
		["Faction Traders", "Each faction's flag on the map marks a trader hub. Traders themselves are neutral, but hostile guards will still engage you if you're not friendly with their faction. Both the trader NPC and the ammo cache inside their office allow buying and selling items using bank notes. Traders may also wander at friendly locations; they sometimes have limited backpack space, so selling large items may require multiple transactions."],
		["Trader Tasks", "Trader tasks are a way to earn money and reputation with the traders. They can be found in the trader's office, and can be completed for money and reputation. The tasks vary from killing a certain amount of enemies, to collecting items, to delivering items. Completing these tasks will help you get better gear from the traders."],
		["Random Encounters", "Random encounters are a way to spice up the game. They can happen at any time, and can range from a simple bandit ambush, to a full on mutant attack. These encounters can be triggered by entering certain areas, or by simply being in the wrong place at the wrong time."],
		["Loot Boxes", "Every location marked on the map has the chance to spawn a loot box. Friendly camps do NOT spawn loot boxes, but any hostile group including mutants to bandits will spawn loot boxes. The box will be an army green WW2 style medical container."],
		["Hydration & Nutrition", "You must eat and drink to survive. Hydration and nutrition decrease over time and faster in harsh conditions. Check your levels via scenario actions; running out of either will cause you to pass out and eventually die. Refill canteens at water sources and purify water when needed."],
		["Radiation", "Radiation comes from certain idols, mutants and even heavy rain. Use gas masks and CBRN gear to reduce exposure. High exposure is lethal, so watch for warnings and take shelter or retreat if your levels climb too high."],
		["Sanity", "Disturbing events and mutant encounters wear down your sanity. Low sanity can trigger hallucinations or other negative effects. Rest in safe areas or interact with friendly factions to recover."],
		["Temperature System", "Temperature system is calculated based on your clothing, altitude, if it's raining, if you’re in the water, if you're in a building, and if you're near a fire. All of these things combine into how your temperature is calculated. You will start to freeze if your body temperature goes below 91.5F. You will need to either make a fire, or enter the hot zone(s) on the map to combat the cold. If your body goes below 89F, you will die. Being at a low altitude, in a building, and having warm clothing can help delay frostbite but will not stop it. Warm Clothing are as follows: Clothing with Jacket or sweater. Any hot weather clothing is those that includes T-Shirts/Tanktops. The 'Check your temp' option in scenario actions will tell you if your equipment is rated for cold weather.<br/><br/>Building a Fire: use a 'Box of matches' and something flamable (like bank notes) to create a fire. "],
		["MISSION", "Survive. Create a base. Go on patrols. Take missions from traders. Protect your home while serving the Survivors Union if you wish to. Do whatever you want in the scenario. Just be warned, without a Zeus, it is limited but with a Zeus, the possibilities are endless. "],
		["Faction Descriptions", "Factions:<br/><br/><br/>Deviant Factions:<br/><br/>Pig Flesh - PF:<br/>Fighting Style: Rush and destroy everything<br/>Intimidation: Extremely Hard to Intimidate<br/>Pre-existing Alliances: None<br/>Alliance Factor: Player becomes a cannibal<br/>Description: Cannibals that worship the age of the apocalypse, and believe the more human flesh they devour, the stronger they become. Distinguishing Features: Wears mostly red clothing, and oftenly has bad equipment.<br/><br/>Altan Liberation Front - ALF:<br/>Fighting Style: Tactical and thought out, 3:1 ratio<br/>Intimidation: Very Hard to Intimidate<br/>Pre-existing Alliances: None<br/>Alliance Factor: Players have to give up their entire faction to them, and all of their territory if they have any. Otherwise, they must pass their tests of combat.<br/>Description: A radical paramilitary faction that was fighting previous to the apocalypse for the liberation of Altis from US occupation. Now they fight for superiority in the wasteland at all costs.<br/>Distinguishing Features: Battered PMC/Paramilitary gear. Primarily UCP camo patterns.<br/><br/>World Order - WO:<br/>Fighting Style: Fall back and wait for reinforcementsIntimidation: Hard<br/>Pre-existing Alliances: None<br/>Alliance Factor: Pledge allegiance to their leader, and provide support to the faction whenever they need it<br/>Description: A social nationalist faction that fights for world domination under their godly leader. <br/>Distinguishing Features: Wears mostly black, and uses G36’s primarily.<br/><br/>Russia - RU:<br/>Fighting Style: Disorganization of enemy command and use of defensive and offensive operations<br/>Intimidation: Extremely Hard<br/>Pre-existing Alliances: None<br/>Alliance Factor: Surrender completely and willing to be conscripted into their army<br/>Description: The Russian Army was tasked with containing the outbreak by any means necessary. Rumors say they also have a secondary mission as to why they are deploying troops into the dead zones.<br/>Distinguishing Features: EMR camo and primary weapon is AK74-M<br/><br/>US Army - US:<br/>Fighting Style: 3:1 ratio, and overwhelm the enemy with superior firepower<br/>Intimidation: Very hard<br/>Pre-existing Alliances: None<br/>Alliance Factor: Fight for the liberation of the Altis, and help whenever the Army calls you<br/>Description: A battalion of CBRN trained infantry has been deployed to the Livonia area to ‘cure’ the region. The UN tasked the US to cure the infection; however, some speculate that isn’t all the US is doing in the infection zones.<br/>Distinguishing Features: Multicam CBRN gear and M40 gas masks with AR platform weapons.<br/><br/><br/><br/>Independent: <br/><br/>New Horizon - NH:<br/>Fighting Style: Hit and run tactics<br/>Intimidation: Medium<br/>Pre-existing Alliances: Deadman’s TridentAlliance Factor: Providing mutual support for their factions and yours. <br/>Description: A faction that embraces the apocalypse, and believes its mother nature weeding out the weak. They fight to survive. and will do anything to do so.<br/>Distinguishing Features: Wears mostly green with a mandatory green shemagh.<br/><br/>The Red Bullet: TRB<br/>Fighting Style: Destroy the enemies with unending waves of cannon fodder<br/>Intimidation: Hard<br/>Pre-existing Alliances: Raven’s Cloak<br/>Alliance Factor: Pledge unwavering loyalty to their leader, and give all of your factions land<br/>Description: A communist faction that fights for the total domination of Altis under their charismatic leader.<br/>Distinguishing Features: Granite/CBRN gear using mostly AK platforms.<br/><br/>Raven’s Cloak - RC:<br/>Fighting Style: Sneak up and strike fast<br/>Intimidation: Medium<br/>Pre-existing Alliances: The Red Bullet<br/>Alliance Factor: Kill a ROA camp, and provide them support on their raids<br/>Description: A faction of bandits that formed a loose alliance with each other to gain more power. Their entire ideology is to pillage and loot the weak.<br/>Distinguishing Features: None. The faction is similar to what regular bandits would wear except maybe with some better gear.<br/><br/>Deadman’s Trident - DT:<br/>Fighting Style: Defense is the best offense, let the enemy push to you and rain hell on them <br/>Intimidation: Easy<br/>Pre-existing Alliances: New Horizon<br/>Alliance Factor: Pledge allegiance to Zeus, and follow their leaders might<br/>Description: A faction that believes in the Greek Pantheon of gods, and punishes the non-believers harshly.<br/>Distinguishing Features: Blue headgear and vest with a white facewear.<br/><br/>The Republic of Altis - ROA:<br/>Fighting Style: Slow and methodical, impatience will be the downfall of the enemy<br/>Intimidation: Hard<br/>Pre-existing Alliances: Survivors Union<br/>Alliance Factor: Become a citizen of their republic, and support the ROA if need be.<br/>Description: A PMC that was based in Altis. They’re extremely wary of unknown survivors, and will often shoot and ask questions later unless.<br/>Distinguishing Features: PMC gear with multicam equipment. Their clothes often consist of button up shirts, and cargo pants.<br/><br/>PMC Group Alpha - PMC:<br/>Fighting Style: Reactive and reinforcements to any conflict. Mortars are usually practiced if they are on the losing side.<br/>Intimidation: Extremely Hard<br/>Pre-existing Alliances: None<br/>Alliance Factor: Assist them on high risk missions and wear their M81 camo. You must join their organization to be allies with them.<br/>Distinguishing Features: M81 camo with AK style weapons. 5 man QRF teams are common.<br/><br/><br/><br/>BLUFOR:<br/><br/>Survivors Union - SU:<br/>Fighting Style: Retreat back to a fortified position, and overwhelm the enemy<br/>Intimidation: Medium<br/>Pre-existing Alliances: BB and ROA<br/>Alliance Factor: Kill no friendly survivors, and help survivors whenever you can<br/>Description: A faction of survivors that grouped together to protect the weak from other, more harsh factions. Also runs all Trader Posts in any dead zone.Distinguishing Features: None. Primarily bad to alright equipment with gas masks.<br/><br/>Boonie Boys - BB:<br/>Fighting Style: Small well equipped teams on the offensive, and tons of underequipped members to defend.<br/>Intimidation: Hard<br/>Pre-existing Alliances: Survivors Union<br/>Alliance Factor: Have a Boonie Hat on your person at all times, and prove to them you can be a reliable ally.<br/>Description: A new faction that has spread from the island Altis that has a reputation for being good to their allies but ruthless with their enemies. There are endless stories of the founding members descreating enemy forces and destroying entire factions. This has caused many to flock to them in search of safety; however, due to the factions' nature to be ruthless, they often have undisciplined survivors joining them making them a borderline bandit faction."],
		["Garbage Collection", "Due to the scenario having the possibility of getting very cluttered, there is a very aggressive garbage clean up script running on the server. If an AI that is NOT within 150 meters from a base flag pole and is over 1000 meters from the nearest player, then it WILL be deleted. Same with vehicles and vehicle wrecks except they need to be 2000 meters from the nearest player. If a player exceeds the 2000 meter mark for the car, just think of it as a bandit stealing their car."],
		["Survival System", "In this scenario, there is a custom made hydration and nutrition (HN) system that utilizes other scenario specific functions such as temperature and radiation. To use the HN system, you must use the ace self-interactions menu to reach the Scenario Actions. From there, to reach HN you need to go to Scenario Actions -> Survival System. From here, you are given a myriad of options to operate the scenario survival system. These should all be self explanatory, but I will explain each nonetheless:<br/><br/>Check Temperature: Checks your player’s current temperature as well as the clothing description<br/><br/>Check Rad Exposure: Checks the player’s radiation exposure if they have a geiger counter<br/><br/>Check Hydration and Nutrition: Checks the players current hydration and nutrition level. This is calculated with the player's current temperature in mind. The colder or hotter the player is, the faster they dehydrate and starve.<br/><br/>Drink Water: This function drinks water from the player’s inventory prioritizing water sources in the following order: soda, water bottles, canteens, unpurified water bottles, and finally unpurified canteens. Take note that sodas and unpurified water sources do give amounts of radiation while clean water sources do not.<br/><br/>Eat Food: This function eats food from the player’s inventory prioritizing:<br/>1. Powdered milk and rice<br/>2. Cooked chicken, beans, and bacon<br/>3. MRE’s and cooked boar (5 rads)<br/>4. Cooked sheep<br/>5. Uncooked boar meat (5 rads)<br/>6. Uncooked sheep meat<br/>7. Uncooked chicken meat (5 rads)<br/>8. Cooked rabbit meat (35 rads)<br/>9. Uncooked rabbit meat (35 rads)<br/>10. Cooked buffalo meat (100 rads)<br/>11.Uncooked buffalo meat (100 rads)<br/><br/>Refill Canteen: If the player has an empty canteen and is near a water source (ocean, well, water tank, etc) they can refill their canteen with contaminated water.<br/><br/>Purify Water: If the player has a contaminated water bottle or canteen, they can purify their water source using water purification tablets to make the water safe to drink.<br/><br/>Skin Animal: The player can skin an animal (goat, boar, rabbit, human, dog, sheep, and chickens) to obtain their uncooked meat. If the player does not have a gutting knife, they can still skin the animal (with the exception of the human) to obtain lesser meat (rabbit meat). If the player uses a gutting knife, they can obtain the default meat from the animal.<br/><br/>Cook Meat: The player can, if near a fire source, can cook their uncooked meat. If the player has multiple pieces of uncooked meat, they can cook them all at once. Boar gives cooked boar meat, goat gives cooked goat meat, and etc.<br/><br/>Make Fire: If the player has matches and a fire starter source (bank notes, documents, and notepad) they can craft a fireplace using 1 of the fire starter’s in this priority: notepad, documents, and finally bank notes. Note that the matches last indefinitely."]
	];

	// Broadcast the diary entries to all clients
	if (hasInterface) then {
		[_diaryEntries] call addDiaryEntries;
		[player] spawn (missionNamespace getVariable "FN_attachAceLoot");
	} else {
		[_diaryEntries] remoteExec ["addDiaryEntries", 0, true];
	};

	player groupChat "Remember to check the briefing tab for a scenario information in your map";

	player enableStamina false;

	if (side player != civilian && (hasInterface or hasInterface)) then {
		//player execVM "Ambient\ZSpawner.sqf";
		//player execVM "Ambient\BanditSpawner.sqf";
		//player execVM "Ambient\anomalySpawner.sqf";
		[player] spawn (missionNamespace getVariable "temperature");
		[player] spawn (missionNamespace getVariable "radSystem");
		[player] spawn (missionNamespace getVariable "randomEncounters");
		[player] spawn (missionNamespace getVariable "hydrationNutritionSystem");
		[player] spawn (missionNamespace getVariable "FN_sanitySystem");
		[player] spawn (missionNamespace getVariable "FN_poopSystem");
		[player] spawn (missionNamespace getVariable "FN_factionClothingCheck");
	};

	// adding any food or drinks to the player's ace interact menu as they spawn;
	player addEventHandler ["InventoryClosed", {
		params ["_unit","_container"];
		// Refresh drink menu
		[_unit] call FN_updateDrinkActions;
		// Refresh eat menu
		[_unit] call FN_updateEatActions;
		// Refresh the faction alliance check
		[_unit] call FN_factionClothingCheck;
	}];

	addMissionEventHandler ["EntityRespawned", {
		params ["_newUnit","_oldUnit"];
		if (isPlayer _newUnit) then {
			_newUnit addEventHandler ["InventoryClosed", {
				params ["_unit"];
				[_unit] call FN_updateDrinkActions;
				// Refresh eat menu
				[_unit] call FN_updateEatActions;
				// Refresh the faction alliance check
				[_unit] call FN_factionClothingCheck;
			}];
		};
	}];

	/*
		ACE Self-Interaction Setup
	*/

	// Scenario Actions
	_actionScenario = ["ScenarioActions","Scenario Actions","",{}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions"],_actionScenario] call ace_interact_menu_fnc_addActionToClass;

	// Open Arsenal
	_actionArsenal = ["Arsenal","Open Arsenal","",{[player,player,true] call ace_arsenal_fnc_openBox;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Scenario Actions"],_actionArsenal] call ace_interact_menu_fnc_addActionToClass;

	// Check Faction Affiliation
	_actionFaction = ["faction","Check Faction Affiliation","",{[player] call FN_checkFaction;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Scenario Actions"],_actionFaction] call ace_interact_menu_fnc_addActionToClass;

	// Lay Down Sleeping Bag
	_actionSleep = ["sleep","Lay Down Sleeping Bag","",{call FN_sleep;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Scenario Actions"],_actionSleep] call ace_interact_menu_fnc_addActionToClass;

	// Set Down Base Flag
	_actionFlag = ["base","Set Down Base Flag","",{call FN_setDownBaseCache;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Scenario Actions"],_actionFlag] call ace_interact_menu_fnc_addActionToClass;

	// Survival Actions
	_actionSurvival = ["SurvivalActions","Survival Actions","",{}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions"],_actionSurvival] call ace_interact_menu_fnc_addActionToClass;

	// Eat
	_actionEat = ["eat","Eat","",{[player] call FN_eat;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionEat] call ace_interact_menu_fnc_addActionToClass;

	// Drink
	_actionDrink = ["drink","Drink","",{[player] call FN_drink;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionDrink] call ace_interact_menu_fnc_addActionToClass;

	// Refill Canteen
	_actionRefillCanteen = ["refill","Refill Canteen","",{[player] call FN_refillCanteen;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionRefillCanteen] call ace_interact_menu_fnc_addActionToClass;

	// Purify Water
	_actionPurifyWater = ["purify","Purify Water","",{[player] call FN_purifyWater;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionPurifyWater] call ace_interact_menu_fnc_addActionToClass;

	// Skin Animal
	_actionSkinAnimal = ["skinAnimal","Skin Animal","",{[player] call FN_skinAnimal;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionSkinAnimal] call ace_interact_menu_fnc_addActionToClass;

	// Cook Meat
	_actionCookMeat = ["cookMeat","Cook Meat","",{[player] call FN_cookMeat;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionCookMeat] call ace_interact_menu_fnc_addActionToClass;

	// Make Fire
	_actionCreateFire = ["createFire","Make Fire","",{[player] call FN_createFire;}, {true}] call ace_interact_menu_fnc_createAction;
	[(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionCreateFire] call ace_interact_menu_fnc_addActionToClass;

	/*
		Commented-out ACE actions (deleted for now):

	_actionTemp = ["temperature","Check Temperature","",{call FN_temperature;}, {true}] call ace_interact_menu_fnc_createAction; [(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionTemp] call ace_interact_menu_fnc_addActionToClass;

	_actionRad = ["radiation","Check Rad Exposure","",{[player] call FN_radiation;}, {true}] call ace_interact_menu_fnc_createAction; [(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionRad] call ace_interact_menu_fnc_addActionToClass;

	_actionDisplayStats = ["status","Check Hydration And Nutrition","",{[player] call FN_displayHydrationNutrition;}, {true}] call ace_interact_menu_fnc_createAction; [(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionDisplayStats] call ace_interact_menu_fnc_addActionToClass;

	_actionSanity = ["sanity","Check Sanity","",{call FN_checkSanity;}, {true}] call ace_interact_menu_fnc_createAction; [(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionSanity] call ace_interact_menu_fnc_addActionToClass;

	_actionDefecate = ["defecate","Defecate","",{[player] call FN_defecate;}, {true}] call ace_interact_menu_fnc_createAction; [(typeOf player),1,["ACE_SelfActions","Survival Actions"],_actionDefecate] call ace_interact_menu_fnc_addActionToClass;
	*/

	// Add zeus action to start garbage collection
	private _gcAction = ["StartGC","Start Garbage Collection","",{ [true] spawn (missionNamespace getVariable "garbageCollection"); },{ true }] call ace_interact_menu_fnc_createAction;
	[["ACE_ZeusActions"], _gcAction] call ace_interact_menu_fnc_addActionToZeus;

	player setVariable ["SU_Relation",true,true];
	player setVariable ["BB_Relation",true,true];
	player setVariable ["PF_Relation",false,true];
	player setVariable ["ALF_Relation",false,true];
	player setVariable ["WO_Relation",false,true];
	player setVariable ["RU_Relation",false,true];
	player setVariable ["US_Relation",false,true];
	player setVariable ["NH_Relation",false,true];
	player setVariable ["TRB_Relation",false,true];
	player setVariable ["RC_Relation",false,true];
	player setVariable ["DT_Relation",false,true];
	player setVariable ["ROA_Relation",false,true];
	player setVariable ["PMC_Relation",false,true];
	player setVariable ["Bandit_Relation",false,true];
	player setVariable ["Renegade_Relation",false,true];
	player setVariable ["wants_to_sleep", false, true];
	sleepRequestUpdate = time;
	publicVariableServer "sleepRequestUpdate";

	west setFriend [civilian, 0];
	east setFriend [civilian, 0];
	resistance setFriend [civilian, 0];
	civilian setFriend [west, 0];
	civilian setFriend [east, 0];
	civilian setFriend [independent, 0];
	civilian setFriend [civilian, 1];

	[player] call FN_updateDrinkActions;
	[player] call FN_updateEatActions;
	[player] call FN_factionClothingCheck;
};

if (isServer) then {
    enableDynamicSimulationSystem true;
    "Group" setDynamicSimulationDistance 500;
    PFrun=false;
    [] spawn (missionNamespace getVariable "PF_init");
};