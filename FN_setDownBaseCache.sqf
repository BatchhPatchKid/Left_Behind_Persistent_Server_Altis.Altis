// Check if there's already a flag placed
	if (!isNil "baseFlagObject") then {
		deleteVehicle baseFlagObject; // Delete the existing sleeping bag
	};

	// Create and position the new sleeping bag
	_flag = "Flag_Red_F" createVehicle [(getPosATL player select 0), (getPosATL player select 1), (getPosATL player select 2)];
	_flag setPos [(getPosATL player select 0), (getPosATL player select 1), (getPosATL player select 2)];
	_flag setDir (getDir player);
	
	// Assign the new sleeping bag object to a global variable for tracking
	baseFlagObject = _flag;
	hintSilent "Flag has been planted. Everything in a radius of a 150m is your base and will now not despawn.";
	
	[
		{
			baseFlagObject addAction
			[
				"Take down flag pole",	// title
				{
					params ["_target", "_caller", "_actionId", "_arguments"]; // script
					deleteVehicle _target;
				},nil,1.5,true,true,"","true",3,false,"",""];
		}
	] remoteExec ["call", 0];