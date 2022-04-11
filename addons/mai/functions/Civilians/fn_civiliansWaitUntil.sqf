 /*
	MAI_fnc_civiliansWaitUntil

	Description:
		wait until civilians module is allowed to spawn units. Server side.
		Search HC and call script there, if HC not connected call script on server.

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/

params [["_logic",objNull,[objNull]]];

//systemChat "MAI_fnc_civiliansWaitUntil";

if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MAI_fnc_civiliansWaitUntil] logic is objNull, exit script.";
	//systemChat "MAI_fnc_civiliansWaitUntil logic null";
};

private _activate = [_logic] call MAI_fnc_checkActivateConditions;

if (_activate) then {

	["civilians at '%1' was activated", nearestLocation [_logic, ""]] call BIS_fnc_logFormat;

	if (!isServer && !hasInterface) exitWith {
		[_logic] call MAI_fnc_civiliansSpawn;
	};

	private _owner = call MAI_fnc_HCfind;
	//_logic setOwner _owner;
	private _activationTriggers = _logic getVariable ["activationTriggers" ,[]];
	private _activation = _logic getVariable ["activation", 650];
	private _civiliansType = _logic getVariable ["civiliansType","altis"];
	private _civiliansCount = _logic getVariable ["civiliansCount",15];
	private _buildings = _logic getVariable ["buildings",[]];
	private _includeAir = _logic getVariable ["_includeAir", false];
	private _unitTypes = _logic getVariable ["unitTypes",[]];
	private _addToZeus = _logic getVariable ["addToZeus",false];
	private _deActivation = _logic getVariable ["deActivation",1000];

	[_logic,_activationTriggers,_activation,_civiliansType,_civiliansCount,_unitTypes,_buildings,_includeAir,_addToZeus,_deActivation] remoteExecCall ["MAI_fnc_civiliansFirstState",_owner,false];
}else
{
	[
		{_this call MAI_fnc_civiliansWaitUntil},
		_this,
		random [0.9,1,1.1]// to prevent multiple modules check at the same time
	] call CBA_fnc_waitAndExecute;
};

Nil