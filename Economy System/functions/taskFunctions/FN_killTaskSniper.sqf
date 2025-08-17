params ["_target","_caller","_actionId","_args"];
private _container = _args select 0;

if (isNull (currentTask _caller)) then {
  hintSilent format ["The rogue sniper has a bounty put on them. Eliminate them for a reward, %1", name _caller];
  private _taskId = format ["RS_%1_%2", getPlayerUID _caller, floor (diag_tickTime * 1000)];
  [_caller, _container, _actionId, _taskId] remoteExec ["LB_fnc_spawnRogueSniper", 2];
} else {
  hintSilent "Sorry, but it seems you already have a task assigned. Finish that one before accepting another.";
};