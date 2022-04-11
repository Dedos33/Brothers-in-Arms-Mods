 /*
	MAI_fnc_buildSpawnFirstState

	Description:
		Initiate buildSpawn, waitUntil condition meet.

	Arguments:
		0: Unit <OBJECT>

	Return Value:
		None

*/

//[format ["isServer - %1 / buildSpawnFirstState",isServer]] remoteExecCall ["systemChat",0];
params [
	["_logic",objNull,[objNull]],
	"_activationTriggers",
	"_activation",
	"_deactivation",
	"_unitTypes",
	"_waypoints",
	"_spawnBuildings",
	"_side",
	"_tickets",
	"_minDist",
	"_groupCount",
	"_patrolCount",
	"_limitBuilding",
	"_spawnChance",
	"_stationaryTime",
	"_spawnPerBuilding",
	"_spawnHalfLimit",
	"_executionCodeUnit",
	"_executionCodePatrol",
	"_executionCodeStationary",
	"_customSpawn",
	"_customSpawnPositions",
	"_minimalCount",
	"_maxWait",
	"_defendOnly"
	];

if (_logic isEqualTo objNull) exitWith {};

//systemChat format ["FisrtState %1/%2",_logic,_activation];
_logic setVariable ["activationTriggers", _activationTriggers];
_logic setVariable ["activation", _activation];
_logic setVariable ["deactivation", _deactivation];
_logic setVariable ["unitTypes", _unitTypes];
_logic setVariable ["waypoints", _waypoints];
_logic setVariable ["spawnBuildings", _spawnBuildings];
_logic setVariable ["side", _side];
_logic setVariable ["tickets", _tickets];
_logic setVariable ["minDist", _minDist];
_logic setVariable ["groupCount", _groupCount];
_logic setVariable ["patrolCount", _patrolCount];
_logic setVariable ["limitBuilding", _limitBuilding];
_logic setVariable ["spawnChance", _spawnChance];
_logic setVariable ["stationaryTime", _stationaryTime];
_logic setVariable ["spawnPerBuilding",_spawnPerBuilding];
_logic setVariable ["spawnHalfLimit", _spawnHalfLimit];
_logic setVariable ["executionCodeUnit", _executionCodeUnit];
_logic setVariable ["executionCodePatrol", _executionCodePatrol];
_logic setVariable ["executionCodeStationary", _executionCodeStationary];
_logic setVariable ["customSpawn", _customSpawn];
_logic setVariable ["customSpawnPositions", _customSpawnPositions];
_logic setVariable ["minimalCount", _minimalCount];
_logic setVariable ["maxWait", _maxWait];
_logic setVariable ["defendOnly", _defendOnly];

private _maxDist = 0;
{
	_maxDist = _maxDist max ((_x select 0) distance _logic);
}forEach _spawnBuildings;

_logic setVariable ["maxDist", _maxDist + _minDist];

private _baseSpawnBuildings = +_spawnBuildings;
_logic setVariable ["baseSpawnBuildings", _baseSpawnBuildings];

private _side = _logic getVariable ["side",WEST];
private _stationaryGroup = createGroup [_side, false];
[_stationaryGroup] call _executionCodeStationary;
_logic setVariable ["stationaryGroup",_stationaryGroup];

if (_customSpawn) then {
	[_logic] call MAI_fnc_buildSpawnPatrolCustomPos;
}else {
	private _patrolGroups = [];
	for "_i" from 1 to _groupCount do {
		_patrolGroups pushBack grpNull;
	};
	_logic setVariable ["patrolGroups",_patrolGroups];
};

[_logic] call MAI_fnc_buildSpawnLoop;

Nil