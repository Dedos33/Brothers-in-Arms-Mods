 /*
	MAI_fnc_buildSpawnInitCall

	Description:
		Initiate buildSpawn from 3den

	Arguments:
		predefined by arma https://community.bistudio.com/wiki/Modules
		synchronized units are used

	Return Value:
		None

*/
if (!isServer) exitWith {};

private _mode = param [0,"",[""]];
private _input = param [1,[],[[]]];

switch _mode do {
	// Default object init
	case "init": {
		//if (is3DEN) exitWith {
		//["init", 0] call BIS_fnc_3DENNotification;
		//};
		[
			{_this call MAI_fnc_buildSpawnInit},
			_input
		] call CBA_fnc_execNextFrame;
	};
	// When some attributes were changed (including position and rotation)
	case "attributesChanged3DEN": {
		//_logic = _input param [0,objNull,[objNull]];
		//["attributesChanged3DEN", 0] call BIS_fnc_3DENNotification;
	};
	// When added to the world (e.g., after undoing and redoing creation)
	case "registeredToWorld3DEN": {
		//_logic = _input param [0,objNull,[objNull]];
		//["registeredToWorld3DEN", 0] call BIS_fnc_3DENNotification;
	};
	// When removed from the world (i.e., by deletion or undoing creation)
	case "unregisteredFromWorld3DEN": {
		//_logic = _input param [0,objNull,[objNull]];
		//["unregisteredFromWorld3DEN", 0] call BIS_fnc_3DENNotification;
	};
	// When connection to object changes (i.e., new one is added or existing one removed)
	case "connectionChanged3DEN": {
		//_logic = _input param [0,objNull,[objNull]];
		//["connectionChanged3DEN", 0] call BIS_fnc_3DENNotification;
	};
	// When object is being dragged
	case "dragged3DEN": {
		//_logic = _input param [0,objNull,[objNull]];
		//["dragged3DEN", 0] call BIS_fnc_3DENNotification;
	};
};
Nil