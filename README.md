# Left Behind - Persistent Server (Altis)

This repository contains the `Left_Behind_Persistent_Server_Altis.Altis` mission for **Arma 3**. The scenario is a persistent survival environment featuring dynamic factions, mutant threats and an economy system with roaming traders.

## Mission Overview
The mission briefing defines several gameplay systems including base building, a sleep mechanic, faction relations and temperature survival challenges. Players are encouraged to explore, take missions from faction traders and create a base while surviving hostile encounters.

## Requirements
- **Arma 3**
- Mod set matching the mission's `addons` list. Key dependencies include:
  - [ACE3](https://ace3.acemod.org/) and `CBA_A3`
  - [Task Force Radio](https://github.com/michail-nikolaev/task-force-arma-3-radio)
  - [Ravage](https://ravage.space/)
  - Ryan's Zombies & Demons
  - Drongo's Spooks and Anomalies
  - RHS: AFRF and RHS: USAF
  - WBK Zombies & other zombie/monster mods
  - Additional mods referenced in `mission.sqm` such as *Spike*, *FRITH_RUIN_CLOTH*, *APR_IMS_iconRework* and others

Ensure all required mods are loaded before starting the scenario. Missing dependencies will prevent the mission from launching.

## Setup
1. Copy `Left_Behind_Persistent_Server_Altis.Altis` into your Arma 3 `MPMissions` directory.
2. Start Arma 3 with the required mods enabled.
3. Host or join a multiplayer session and select the mission from the scenario list.

## Running the Scenario
- Upon spawning you will be teleported into the zone. Equipment is stripped then re-issued based on the faction you arrive with.
- Visit faction traders to buy or sell equipment via the economy system.
- Build bases using ACE Fortify. To prevent cleanup place a flag via **Scenario Actions**; objects within 150 meters of that flag are not removed.
- Survival mechanics such as hydration, nutrition, sanity and temperature are explained in the briefing diary entries.

The mission is intended for persistent servers but can also be played locally. Check the in-game **Briefing** tab for more information and tips.