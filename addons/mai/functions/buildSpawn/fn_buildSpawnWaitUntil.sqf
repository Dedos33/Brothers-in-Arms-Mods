 /*
	MadinAI_fnc_buildSpawnWaitUntil

	Description:
		wait until buildspawn is allowed to spawn units. Server side.
		Search HC and call script there, if not connected call script on server.

	Arguments:
		0: Logic <OBJECT>
		1: Activation <DISTANCE>
		2: Unit types and loadouts <ARRAY>
		3: Buildings used in script <ARRAY>
		4: Side of spawned units <SIDE>
		5: Triggers needed to be activated <ARRAY>

	Return Value:
		None

*/

params [["_logic",objNull,[objNull]],"_activation","_unitTypes","_spawnBuildings","_side", ["_activationTriggers", []]];

if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MadinAI_fnc_buildSpawnWaitUntil] logic is objNull, exit script"
};

private _nearUnits = _logic nearEntities ["AllVehicles", _activation];

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

	["Buildspawn at '%1' was activated", nearestLocation [_logic, ""]] call BIS_fnc_logFormat;

	_owner = call MadinAI_fnc_HCfind;
	// nothing to see here, just workaround, keep goin.
	private _newArr = +_this;
	private _logic = _newArr select 0;
	{
		private _variable = _logic getVariable [_x,0];
		_newArr pushBack _variable;
	}forEach ["tickets","minDist","patrolCount","limit"];
	//_logic setOwner _owner;
	_newArr remoteExecCall ["MadinAI_fnc_buildSpawnFirstState",_owner,false];
}else
{
	[
		{_this call MadinAI_fnc_buildSpawnWaitUntil},
		_this,
		random [0.9,1,1.1]// to prevent multiple modules check at the same time
	] call CBA_fnc_waitAndExecute;
};