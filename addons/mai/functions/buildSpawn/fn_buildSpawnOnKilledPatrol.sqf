MAI_MAI_ /*
	MAI_fnc_buildSpawnOnKilledPatrol

	Description:


	Arguments:
		0: 

	Return Value:
		None

*/

params [
	["_unit", objNull]
];

private _group = _unit getVariable ["MAI_group", group _unit];
if (_group isEqualTo grpNull) exitWith {};

private _firstKilledTime = _group getVariable ["firstKilledTime", -1];
if !(_firstKilledTime isEqualTo -1) exitWith {}; // already set on previous death in same group. set to nil on respawn.

_group setVariable ["firstKilledTime", time];