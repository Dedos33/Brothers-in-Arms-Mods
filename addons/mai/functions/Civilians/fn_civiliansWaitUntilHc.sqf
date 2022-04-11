 /*
	MadinAI_fnc_civiliansWaitUntilHc

	Description:
		wait until civilians module is allowed to spawn units. HC/server side.
		Search HC and call script there, if not connected call script on server.

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/

params [["_logic",objNull,[objNull]]];

if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MadinAI_fnc_civiliansWaitUntilHc] logic is objNull, exit script."
};

//systemChat str "MadinAI_fnc_civiliansWaitUntilHc";


private _activation = _logic getVariable ["activation",10000];
private _nearUnits = _logic nearEntities ["AllVehicles", _activation];

private _synchronizedObjects = synchronizedObjects _logic;
private _activationTriggers = _synchronizedObjects select {_x isKindOf "EmptyDetector"};

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

	["civilians at '%1' was re-activated", nearestLocation [_logic, ""]] call BIS_fnc_logFormat;

	[_logic] call MadinAI_fnc_civiliansSpawn;
}else
{
	[
		{_this call MadinAI_fnc_civiliansWaitUntilHc},
		_this,
		random [0.9,1,1.1]// to prevent multiple modules check at the same time
	] call CBA_fnc_waitAndExecute;
};