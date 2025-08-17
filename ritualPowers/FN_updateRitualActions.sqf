params ["_player"];

waitUntil { sleep 0.1; !isNil { _player getVariable "ritualStatus" } };

// remove previously added children (full paths), then headers (full paths)
private _oldChildren = _player getVariable ["LB_currentRitualEntries", []];
{ [typeOf _player, 1, _x, false] call ace_interact_menu_fnc_removeActionFromClass } forEach _oldChildren;

private _oldHeaders  = _player getVariable ["LB_currentRitualHeaders", []];
{ [typeOf _player, 1, _x, false] call ace_interact_menu_fnc_removeActionFromClass } forEach _oldHeaders;

private _INF = 1e9;

private _itemsPlayer = items _player;

private _zeusRelic = 1;
private _wandererRelic = 1;
private _pigRelic = 1;
private _poseidonRelic = 1;

//if the player does not have the relic, then they can't use certain spells
private _zeusLock = 1000; 
private _wandererLock = 1000; 
private _pigLock = 1000; 
private _poseidonLock = 1000; 

if ("LB_ZeusIdol" in _itemsPlayer) then { 
  _zeusLock = 1;
  _zeusRelic = 0.2;
};

if ("LB_WandererIdol" in _itemsPlayer) then { 
  _wandererLock = 1;
  _wandererRelic = 0.2;
};

if ("LB_PoseidonIdol" in _itemsPlayer) then { 
  _poseidonLock = 1;
  _poseidonRelic = 0.2;
};

if ("LB_GreatPigIdol" in _itemsPlayer) then { 
  _pigLock = 1;
  _pigRelic = 0.2;
};

// requirements [min, max) — your thresholds
private _req = createHashMapFromArray [
  ["wanderer_banish",[10*_wandererRelic*_wandererLock,_INF]],
  ["chronos_day",[40*_zeusRelic,_INF]],
  ["chronos_night",[40*_zeusRelic,_INF]],
  ["apollo_self",[15*_zeusRelic,_INF]],
  ["apollo_allies",[25*_zeusRelic,_INF]],
  ["hypnos_mass",[30*_zeusRelic*_zeusLock,_INF]],
  ["hypnos_single",[10*_zeusRelic,_INF]],
  ["goliath_all",[25*_wandererRelic,_INF]],
  ["goliath_enemy",[15*_wandererRelic*_wandererLock,_INF]],
  ["goliath_single",[10*_wandererRelic,_INF]],
  ["pig_explosion",[30*_pigRelic,_INF]],
  ["pig_fireball",[17*_pigRelic,_INF]],
  ["pig_wisdom",[35*_pigRelic*_pigLock,_INF]],
  ["wanderer_mutants",[25*_wandererRelic,_INF]],
  ["wanderer_tank",[50*_wandererRelic*_wandererLock,_INF]],
  ["hermes_cursor",[27*_zeusRelic*_zeusLock,_INF]],
  ["hermes_random",[15*_zeusRelic,_INF]],
  ["zeus_bolt",[20*_zeusRelic,_INF]],
  ["zeus_rain",[50*_zeusRelic*_zeusLock,_INF]],
  ["zeus_storm",[60*_zeusRelic*_zeusLock,_INF]]
];

// DEFs: [id, title, function, extraArgsAfterReqNum]
private _defs = [
  ["goliath_enemy","SUMMON SHARD UPON ENEMY",FN_killGoliathShardEnemy,[]],
  ["goliath_all","SUMMON SHARDS UPON ALL",FN_killGoliathShardALL,[]],
  ["goliath_single","SUMMON SHARD UPON SINGLE",FN_killGoliathShard,[]],

  ["wanderer_mutants","SUMMON FRIENDS FROM BEYOND THIS WORLD",FN_summonMutants,[]],
  ["wanderer_tank","SUMMON A POWERFUL ALLY FROM BEYOND THIS WORLD",FN_summonTank,[]],
  ["wanderer_banish","BANISH AN ENTITY TO THE DARK WODE",FN_banishUnit,[]],

  ["zeus_bolt","SUMMON ZEUS'S BOLT",FN_zeusBolt,[]],
  ["zeus_storm","SUMMON ZEUS'S WRATH",FN_zeusStorm,[]],
  ["zeus_rain","RAIN THE NON-BELIEVERS FROM THE SKY",FN_zeusRain,[]],

  ["hypnos_single","BRAINWASH A NON-BELIEVER",FN_hypnosBrainwashSingle,[]],
  ["hypnos_mass","BRAINWASH THE NON-BELIEVERS",FN_hypnosBrainwash,[]],

  ["hermes_random","TELEPORT ONESELF TO RANDOM LOCATION",FN_teleportRandom,[]],
  ["hermes_cursor","TELEPORT YOU AND YOUR FELLOW BELIEVERS",FN_teleportCursor,[]],

  // Chronos keeps its hour, but now receives _reqNum as second param (caller, reqNum, hour)
  ["chronos_day","COMMAND TIME TO LURCH FORWARD TO DAY",FN_changeTime,[9]],
  ["chronos_night","COMMAND TIME TO LURCH FORWARD TO NIGHT",FN_changeTime,[23]],

  ["apollo_self","RESTORE ONESELF",FN_healSelf,[]],
  ["apollo_allies","RESTORE ONESELF AND FELLOW BELIEVERS",FN_healAllies,[]],

  ["pig_fireball","CAST GREAT PIG'S FIREBALL",FN_pigFireball,[]],
  ["pig_explosion","CAST GREAT PIG'S JUDGEMENT",FN_pigExplosion,[]],
  ["pig_wisdom","CAST GREAT PIG'S WISDOM",FN_pigWisdom,[ ]]
];

// header display names
private _headerTitle = createHashMapFromArray [
  ["wandererPath","WANDERER POWERS"],
  ["greekPath","GREEK POWERS"],
  ["pigPath","PIG POWERS"]
];

// map ritual id -> header key
private _groupFor = {
  params ["_id"];
  switch (true) do {
    case ((_id find "goliath_") == 0): { "wandererPath" };
    case ((_id find "wanderer_") == 0): { "wandererPath" };
    case ((_id find "pig_") == 0): { "pigPath" };
    case ((_id find "zeus_") == 0): { "greekPath" };
    case ((_id find "hypnos_") == 0): { "greekPath" };
    case ((_id find "hermes_") == 0): { "greekPath" };
    case ((_id find "chronos_") == 0): { "greekPath" };
    case ((_id find "apollo_") == 0): { "greekPath" };
    default { "ritualPowers" };
  };
};

private _r = _player getVariable ["ritualStatus",0];

// collect eligible children per header, also compute the req number we'll pass in
private _groups = createHashMap;   // header -> array of [id,title,fn,extra,reqNum]
{
  private _id = _x#0;
  private _bounds = _req get _id;
  if (!isNil "_bounds") then {
    private _min = _bounds select 0;
    private _max = _bounds select 1;
    if (_r >= _min && _r < _max) then {
      private _g = [_id] call _groupFor;
      private _arr = _groups getOrDefault [_g, []];
      _arr pushBack [_id, _x#1, _x#2, _x#3, _min];   // store reqNum = _min
      _groups set [_g, _arr];
    };
  };
} forEach _defs;

private _newChildren = [];
private _newHeaders  = [];

// create headers that have kids, then add kids; each action passes (caller, reqNum, ...extra)
{
  private _groupId = _x;
  private _kids = _groups get _groupId;

  if (_kids isNotEqualTo []) then {
    private _title = _headerTitle getOrDefault [_groupId, toUpper _groupId];
    private _headerAction = [_groupId, _title, "", {}, {true}] call ace_interact_menu_fnc_createAction;
    private _headerFullPath = [typeOf _player, 1, ["ACE_SelfActions"], _headerAction] call ace_interact_menu_fnc_addActionToClass;
    _newHeaders pushBack _headerFullPath;

    private _parentPath = ["ACE_SelfActions", _groupId];

    {
      private _id     = _x#0;
      private _name   = _x#1;
      private _fn     = _x#2;
      private _extra  = _x#3;      // array (may be [])
      private _reqNum = _x#4;      // from _req min

      // data we want at click-time
      private _actionParams = [_fn, _reqNum] + _extra;

      // statement: (_target, _caller, _params)
      private _stmt = {
        params ["_t","_c","_p"];
        private _fn     = _p#0;
        private _reqNum = _p#1;
        private _extra  = if ((count _p) > 2) then { _p select [2, (count _p) - 2] } else { [] };
        ([_c, _reqNum] + _extra) spawn _fn;
      };

      private _a  = [_id, _name, "", _stmt, {true}, {}, _actionParams] call ace_interact_menu_fnc_createAction;
      private _fp = [typeOf _player, 1, _parentPath, _a] call ace_interact_menu_fnc_addActionToClass;
      _newChildren pushBack _fp;
    } forEach _kids;
  };
} forEach (keys _groups);

_player setVariable ["LB_currentRitualEntries", _newChildren, false];
_player setVariable ["LB_currentRitualHeaders", _newHeaders,  false];