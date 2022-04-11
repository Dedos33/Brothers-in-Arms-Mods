 /*
	MAI_fnc_buildSpawnWaitUntil

	Description:
		wait until buildspawn is allowed to spawn units. Server side.
		Search HC and call script there, if not connected call script on server.

	Arguments:
		0: Logic							<OBJECT>
		1: Activation						<DISTANCE>
		2: Unit types and loadouts			<ARRAY>
		3: Predefined waypoints array		<ARRAY>
		3: Buildings used in script			<ARRAY>
		4: Side of spawned units			<SIDE>
		5: Triggers needed to be activated	<ARRAY>

	Return Value:
		None

*/

params [["_logic",objNull,[objNull]]];

if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MAI_fnc_buildSpawnWaitUntil] logic is objNull, exit script"
};

private _activate = [_logic] call MAI_fnc_checkActivateConditions;
if (_activate) then {
	["Buildspawn at '%1' was activated", nearestLocation [_logic, ""]] call BIS_fnc_logFormat;

	_owner = call MAI_fnc_HCfind;
	private _params = [_logic];
	{
		private _variable = _logic getVariable [_x,0];
		_params pushBack _variable;
	}forEach[
		"activationTriggers",
		"activation",
		"deactivation",
		"unitTypes",
		"waypoints",
		"spawnBuildings",
		"side",
		"tickets",
		"minDist",
		"groupCount",
		"patrolCount",
		"limitBuilding",
		"spawnChance",
		"stationaryTime",
		"spawnPerBuilding",
		"spawnHalfLimit",
		"executionCodeUnit",
		"executionCodePatrol",
		"executionCodeStationary",
		"customSpawn",
		"customSpawnPositions",
		"minimalCount",
		"maxWait",
		"defendOnly"
	];
	//_logic setOwner _owner;
	_params remoteExecCall ["MAI_fnc_buildSpawnFirstState",_owner,false];
}else
{
	[
		{_this call MAI_fnc_buildSpawnWaitUntil},
		_this,
		random [0.9,1,1.1]// to prevent multiple modules check at the same time
	] call CBA_fnc_waitAndExecute;
};

Nil