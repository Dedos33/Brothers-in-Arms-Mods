 /*
	MAI_fnc_reinforceInit

	Description:
		Initiate vehSpawn on server, then wait until condition meet

*/

//params ["_logic","_trigger","_sleep","_count","_interval","_radius",["_dist",100],["_minimal",100]];
params [
	["_logic",objNull,[objNull]],
	["_activated",true,[true]],
	["_isCuratorPlaced",true,[true]]
];

private _synchronizedObjects = synchronizedObjects _logic;
if (_synchronizedObjects isEqualTo []) exitWith {
	//
};
private _vehicles = _logic getVariable ["vehicles",[]];
private _activationTriggers = [];
private _modules = [];

{
	private _vehicle = vehicle _x;
	if (_vehicle isKindOf "AllVehicles" && !(typeOf _vehicle isEqualTo "Man")) then {
		private _crew = crew _vehicle;
		private _side = side (_crew select 0);
		// get all units and loadouts from vehicle
		private _fullCrew = [];
		{
			private _typeUnit = typeOf _x;
			private _assignedRole = assignedVehicleRole _x;
			private _cargoIndex = _vehicle getCargoIndex _x;
			private _loadout = getUnitLoadout _x;
			_fullCrew pushBack [_typeUnit, _assignedRole, _cargoIndex, _loadout];
		} forEach _crew;
		// garage specs of vehicle

		private _waypoints = [];
		private _driver = driver _vehicle;
		if !(_driver isEqualTo objNull) then {
			private _driverGroup = group driver _vehicle;
			{
				private _wPos = waypointPosition _x;
				if (_driver distance _wPos > 5) then {
					private _wType = waypointType _x;
					private _wTimeout = waypointTimeout _x;
					private _behaviour = waypointBehaviour _x;
					_waypoints pushBack [_wPos, _wType, _wTimeout, _behaviour];
				};
			} forEach waypoints _driverGroup;
		};

		{
			private _grDel = group _x;
			deleteVehicle _x;
			deleteGroup _grDel;
		} forEach (crew _vehicle);
		private _vehicleInfo = [_vehicle] call MAI_fnc_getVehicleInfo;
		deleteVehicle _vehicle;

		_vehicles pushBack [_vehicleInfo, _fullCrew, _side, _waypoints];
	}else{		
		if (_x isKindOf "EmptyDetector") then {
			_activationTriggers pushBack _x;
		}else{
			if (_x isKindOf "Module_F") then {
				_modules pushBack _x;
			};
		};
	};
} forEach _synchronizedObjects;

_logic setVariable ["activationTriggers",_activationTriggers];

if (_vehicles isEqualTo []) exitWith {};
_logic setVariable ["vehicles", _vehicles];

[
	{
		time > 1
	},
	{
		_this call MAI_fnc_reinforceWaitUntil;
	},
	[_logic , _activationTriggers, _modules]
]call CBA_fnc_waitUntilAndExecute;