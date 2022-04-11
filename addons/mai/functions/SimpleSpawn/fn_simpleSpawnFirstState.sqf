 /*
	MAI_fnc_simpleSpawnFirstState

	Description:
		wait until Resp Point condition meet to start script

	Arguments:
		0: Logic <OBJECT>
		1: 

	Return Value:
		None

*/

params [
	["_logic", objNull],
	"_activationTriggers",
	["_groups", []],
	["_vehiclesInfo", []],
	["_interval", 0.1],
	["_unitsPerInterval", 1],
	["_deleteVehicles", false],
	["_activation", 750],
	["_deactivation", -1],
	["_includeAir", false],
	["_forceActivate", true],
	["_checkBuildings", true],
	["_activateCondition", {true}],
	["_executionCodeUnit", {}],
	["_executionCodePatrol", {}],
	["_executionCodeVehicle", {}]
];

if (_logic isEqualTo objNull) exitWith {};
_logic setVariable ["activationTriggers", _activationTriggers];
_logic setVariable ["groups", _groups];
_logic setVariable ["vehiclesInfo", _vehiclesInfo];
_logic setVariable ["activation", _activation];
_logic setVariable ["deactivation", _deactivation];
_logic setVariable ["includeAir", _includeAir];
_logic setVariable ["forceActivate", _forceActivate];
_logic setVariable ["checkBuildings", _checkBuildings];
_logic setVariable ["activateCondition", _activateCondition];
_logic setVariable ["interval", _interval];
_logic setVariable ["deleteVehicles", _deleteVehicles];
_logic setVariable ["unitsPerInterval", _unitsPerInterval];
_logic setVariable ["executionCodeUnit", _executionCodeUnit];
_logic setVariable ["executionCodePatrol", _executionCodePatrol];
_logic setVariable ["executionCodeVehicle", _executionCodeVehicle];

[_logic, _groups, _vehiclesInfo] call MAI_fnc_simpleSpawnInterval;