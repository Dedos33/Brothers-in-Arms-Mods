 /*
	MadinAI_fnc_civiliansFirstState

	Description:
		Initiate civilians, waitUntil condition meet

	Arguments:
		0: Unit <OBJECT>

	Return Value:
		None

*/

//[format ["isServer - %1 / civiliansFirstState",isServer]] remoteExecCall ["systemChat",0];
params [["_logic",objNull,[objNull]],"_activation","_civiliansType","_civiliansCount","_unitTypes","_buildings","_includeAir","_addToZeus","_deActivation"];

_logic setVariable ["activation",_activation];
_logic setVariable ["civiliansType",_civiliansType];
_logic setVariable ["civiliansCount",_civiliansCount];
_logic setVariable ["unitTypes",_unitTypes];
_logic setVariable ["buildings",_buildings];
_logic setVariable ["includeAir",_includeAir];
_logic setVariable ["addToZeus",_addToZeus];
_logic setVariable ["deActivation",_deActivation];

[_logic] call MadinAI_fnc_civiliansSpawn;