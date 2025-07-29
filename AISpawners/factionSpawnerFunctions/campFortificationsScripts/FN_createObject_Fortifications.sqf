params ["_pos", "_objType", "_xDir", "_yDir", "_xDis", "_yDis", "_zDis", "_prob"];
_object = "";
if (random 1 > _prob) then {
	_object = createVehicle [_objType, [0, 0, 0], [], 0, "CAN_COLLIDE"];     
	_object allowDamage false;     
	_object setVectorDirAndUp [[_xDir,_yDir,0], (vectorUp _object)];     
	_object setPosATL [(_pos select 0)+_xDis, (_pos select 1)+_yDis, _zDis];
};
_object