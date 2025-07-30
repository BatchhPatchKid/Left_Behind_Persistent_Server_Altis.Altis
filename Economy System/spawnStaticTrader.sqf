params ["_faction", "_trigger"];

if (isServer) then {
	[_faction, _trigger] spawn {
		params ["_faction", "_trigger"];
		
		_grpTrader = createGroup WEST;
		_trader = _grpTrader createUnit ["B_G_Survivor_F",(getPos _trigger),[],1,"NONE"];
		[_faction, _trader, false, true, false] call (missionNamespace getVariable "FN_equipAI");
		_trader disableAI "ANIM";
		removeBackpackGlobal _trader;

		[_trader] call (missionNamespace getVariable "FN_economySystem");

		_wp1 = _grpTrader addWaypoint [(getPos _trigger), 0];
		_wp1 setWaypointType "HOLD";
		_grpTrader enableGunLights "ForceOn";



		_trader addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator"];
			if (isPlayer _killer) then {
			
				_killer setVariable ["SU_Relation",FALSE,true];
				_killer setVariable ["BB_Relation",FALSE,true];
				_killer setVariable ["PF_Relation",FALSE,true];
				_killer setVariable ["ALF_Relation",FALSE,true];
				_killer setVariable ["WO_Relation",FALSE,true];
				_killer setVariable ["RU_Relation",FALSE,true];
				_killer setVariable ["US_Relation",FALSE,true];
				_killer setVariable ["NH_Relation",FALSE,true];
				_killer setVariable ["TRB_Relation",FALSE,true];
				_killer setVariable ["RC_Relation",FALSE,true];
				_killer setVariable ["DT_Relation",FALSE,true];
				_killer setVariable ["ROA_Relation",FALSE,true];
				_killer setVariable ["PMC_Relation",FALSE,true];
				_killer setVariable ["Bandit_Relation",FALSE,true];
				_killer setVariable ["Renegade_Relation",true,true];
			
				hintSilent parseText format ["<t size='1.25' color='#ff0000'> *ATTENTION*<br/><br/></t><t>Trader has been killed by %1. %1 is now a renegade.</t>", (name _killer)];
				
				{
					if (_x inArea [_killer, 100, 100, 0, false]) then {
						_x allowDamage true;
					};
				} forEach allPlayers;
				
				_units = nearestObjects [player, ["CAManBase"], 100];
				_aiUnits = [];
				
				{
					if (!isPlayer _x AND alive _x) then {
						_aiUnits pushBack _x;
					};
				} forEach _units;	
				
				if (count _aiUnits != 0) then {
					_grpBetray = _aiUnits joinSilent createGroup independent;
					_wp1 = _grpBetray addWaypoint [(getPos _killer), 0];
					_wp1 setWaypointType "MOVE";
				};
			};
		}];
		
		while {true} do { //checking to see if all players have left the trader zone (if so, then exit loop)
			_playerInside = false;
			{
				if (_x inArea _trigger) then {
					_playerInside = true;
				};
				sleep .01;
			} forEach allPlayers;
			if (!_playerInside) then {
				deleteVehicle _trader;
				break;
			};
			sleep 5;
		};
	};
};