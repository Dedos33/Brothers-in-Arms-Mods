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
params [["_logic",objNull,[objNull]],["_patrolGroup",grpNull,[grpNull]],["_activation",50,[0]]];

private _patrolDistance = random [15,25,35] + _activation/10;

[_patrolGroup, getposATL _logic, _patrolDistance] call CBA_fnc_taskPatrol;