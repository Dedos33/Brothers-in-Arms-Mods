 /*
	MAI_fnc_simpleSpawnWaitUntil

	Description:
		wait until Resp Point condition meet to start script

	Arguments:
		0: Logic <OBJECT>
		1: 

	Return Value:
		None

*/

params [["_logic",objNull]];

if (_logic isEqualTo objNull) exitWith {};

private _activate = [_logic] call MAI_fnc_checkActivateConditions;

if (_activate) then {
	private _groups = _logic getVariable ["groups", []];
	private _vehiclesInfo = _logic getVariable ["vehiclesInfo" ,[]];

	if (!isServer && !hasInterface) exitWith {
		[_logic, _groups, _vehiclesInfo] call MAI_fnc_simpleSpawnInterval;
	};
	
	private _activationTriggers = _logic getVariable ["activationTriggers" ,[]];
	private _interval = _logic getVariable ["interval" ,[]];
	private _unitsPerInterval = _logic getVariable ["unitsPerInterval", []];
	private _deleteVehicles = _logic getVariable ["deleteVehicles", false];
	private _activation = _logic getVariable ["activation", 750];
	private _deactivation = _logic getVariable ["deactivation", -1];
	private _includeAir = _logic getVariable ["includeAir", false];
	private _forceActivate = _logic getVariable ["forceActivate", false];
	private _checkBuildings = _logic getVariable ["checkBuildings", true];
	private _activateCondition = _logic getVariable ["activateCondition", {true}];
	private _executionCodeUnit = _logic getVariable ["executionCodeUnit", {}];
	private _executionCodePatrol = _logic getVariable ["executionCodePatrol", {}];
	private _executionCodeVehicle = _logic getVariable ["executionCodeVehicle", {}];

	private _owner = call MAI_fnc_HCfind;
	[
		_logic,
		_activationTriggers,
		_groups,
		_vehiclesInfo,
		_interval,
		_unitsPerInterval,
		_deleteVehicles,
		_activation,
		_deactivation,
		_includeAir,
		_forceActivate,
		_checkBuildings,
		_activateCondition,
		_executionCodeUnit,
		_executionCodePatrol,
		_executionCodeVehicle
	] remoteExecCall ["MAI_fnc_simpleSpawnFirstState",_owner,false];
}else
{
	[{_this call MAI_fnc_simpleSpawnWaitUntil},
	_this,
	random [0.9,1,1.1]
	] call CBA_fnc_waitAndExecute;
};

Nil