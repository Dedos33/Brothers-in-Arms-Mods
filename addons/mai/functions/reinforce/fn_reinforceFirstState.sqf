 /*
	MAI_fnc_reinforceFirstState

	Description:
		First stete of module, when conditions met.
		Spawns all vehicles for reinforcements.

*/

params [
	["_logic", objNull, [objNull]],
	"_activationTriggers",
	"_distance",
	"_quantity",
	"_minimalCrew",
	"_despawn",
	"_activateCondition",
	"_maxUnitsOnMap",
	"_executionCodeVehicle",
	"_executionCodeUnit",
	"_executionCodePatrol",
	"_executionCodeVehicleCrew",
	"_vehicles"
];
if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MAI_fnc_reinforceDeploy] module deleted, exit script.";
};
_logic setVariable ["activationTriggers", _activationTriggers];
_logic setVariable ["distance", _distance];
_logic setVariable ["quantity", _quantity];
_logic setVariable ["minimalCrew", _minimalCrew];
_logic setVariable ["despawn", _despawn];
_logic setVariable ["activateCondition", _activateCondition];
_logic setVariable ["executionCodeVehicle", _executionCodeVehicle];
_logic setVariable ["executionCodeUnit", _executionCodeUnit];
_logic setVariable ["executionCodePatrol", _executionCodePatrol];
_logic setVariable ["executionCodeVehicleCrew", _executionCodeVehicleCrew];
_logic setVariable ["vehicles", _vehicles];
_logic setVariable ["maxUnitsOnMap", _maxUnitsOnMap];

{
	_x params ["_vehType", "_vehStartPos", "_vehicleDir", "_fullCrew", "_side", "_vehCustom", "_waypoints"];
	[
		_logic,
		_vehType,
		_vehStartPos,
		_vehicleDir,
		_fullCrew,
		_side,
		_vehCustom,
		_waypoints,
		_quantity
	] call MAI_fnc_reinforceSpawnVeh
} forEach _vehicles;