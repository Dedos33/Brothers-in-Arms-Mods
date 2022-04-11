 /*
	MadinAI_fnc_buildSpawnFirstState

	Description:
		Initiate buildSpawn, waitUntil condition meet

	Arguments:
		0: Unit <OBJECT>

	Return Value:
		None

*/

//[format ["isServer - %1 / buildSpawnFirstState",isServer]] remoteExecCall ["systemChat",0];
params [["_logic",objNull,[objNull]],"_activation","_unitTypes","_spawnBuildings","_side","_activationTriggers","_tickets","_minDist","_patrolCount","_limit"];

//systemChat format ["FisrtState %1/%2",_logic,_activation];

_logic setVariable ["activation",_activation];
_logic setVariable ["unitTypes",_unitTypes];
_logic setVariable ["spawnBuildings",_spawnBuildings];
_logic setVariable ["side",_side];
_logic setVariable ["tickets",_tickets];
_logic setVariable ["minDist",_minDist];
_logic setVariable ["patrolCount",_patrolCount];
_logic setVariable ["limit",_limit];

private _side = _logic getVariable ["side",WEST];
private _stationaryGroup = createGroup [_side, false];
private _patrolGroup = createGroup [_side, false];
_logic setVariable ["stationaryGroup",_stationaryGroup];
_logic setVariable ["patrolGroup",_patrolGroup];
[_logic] call MadinAI_fnc_buildSpawnLoop;

_patrolGroup setBehaviour "SAFE";
_patrolGroup setSpeedMode "LIMITED";
[
	{
		params ["_logic","_patrolGroup","_activation"];
		//systemChat str _this;
		[_logic,_patrolGroup,_activation] call MadinAI_fnc_buildSpawnGroupPatrol
	},
	[_logic,_patrolGroup,_activation],
	1
] call CBA_fnc_waitAndExecute;