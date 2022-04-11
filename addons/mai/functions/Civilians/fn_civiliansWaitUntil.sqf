 /*
	MadinAI_fnc_civiliansWaitUntil

	Description:
		wait until civilians module is allowed to spawn units. Server side.
		Search HC and call script there, if not connected call script on server.

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/

params [["_logic",objNull,[objNull]]];

//systemChat "MadinAI_fnc_civiliansWaitUntil";

if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MadinAI_fnc_civiliansWaitUntil] logic is objNull, exit script.";
	//systemChat "MadinAI_fnc_civiliansWaitUntil logic null";
};

private _pos = getPosATL _logic;
private _activation = _logic getVariable ["activation",10000];

private _nearUnits = _logic nearEntities ["AllVehicles", _activation];

private _synchronizedObjects = synchronizedObjects _logic;
private _activationTriggers = _synchronizedObjects select {_x isKindOf "EmptyDetector"};
private _playersNear = (_nearUnits findIf {isPlayer _x && {alive _x}}) != -1;

private _includeAir = _logic getVariable ["includeAir", false];
private _activate = false;

if (_includeAir) then
{
	_activate = ((_nearUnits findIf {isPlayer _x}) != -1);
}else
{
	_activate = ((_nearUnits findIf {isPlayer _x && {!(_x isKindOf "Air")}}) != -1);
};
if (_activate) then{

	["civilians at '%1' was activated", nearestLocation [_logic, ""]] call BIS_fnc_logFormat;

	_owner = call MadinAI_fnc_HCfind;
	//_logic setOwner _owner;

	private _civiliansType = _logic getVariable ["civiliansType","altis"];
	private _civiliansCount = _logic getVariable ["civiliansCount",15];
	private _buildings = _logic getVariable ["buildings",[]];
	private _unitTypes = _logic getVariable ["unitTypes",[]];
	private _addToZeus = _logic getVariable ["addToZeus",false];
	private _deActivation = _logic getVariable ["deActivation",1000];

	[_logic,_activation,_civiliansType,_civiliansCount,_unitTypes,_buildings,_includeAir,_addToZeus,_deActivation] remoteExecCall ["MadinAI_fnc_civiliansFirstState",_owner,false];
}else
{
	[
		{_this call MadinAI_fnc_civiliansWaitUntil},
		_this,
		random [0.9,1,1.1]// to prevent multiple modules check at the same time
	] call CBA_fnc_waitAndExecute;
};
(_playersNear && {(_activationTriggers select {!triggerActivated _x}) isEqualTo []})