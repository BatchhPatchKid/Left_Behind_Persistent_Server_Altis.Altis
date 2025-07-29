params ["_group", "_pos", "_radius"];

waitUntil { !isNull _group };

private _wp1 = _group addWaypoint [_pos, _radius, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointBehaviour "AWARE";

private _wp2 = _group addWaypoint [_pos, _radius, 1];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointSpeed "FULL";
_wp2 setWaypointBehaviour "AWARE";

private _wp3 = _group addWaypoint [_pos, _radius, 2];
_wp3 setWaypointType "CYCLE";
_wp3 setWaypointSpeed "FULL";
_wp3 setWaypointBehaviour "AWARE";

_group setCurrentWaypoint _wp1;

deleteWaypoint [_group, 3];