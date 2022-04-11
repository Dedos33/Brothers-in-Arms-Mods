 /*
	MAI_fnc_buildSpawnAiSpawn

	Description:
		Initiate buildSpawn main loop

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/

params [
	["_logic",objNull],
	["_group",grpNull],
	["_unitTypes",[]],
	["_pos",[0,0,0]],
	["_dir",0],
	["_standTime",0]
];
if (_logic isEqualTo objNull) exitWith {};

private _unitIndex = _group getVariable ["unitIndex", 0];
if (_unitIndex isEqualTo count _unitTypes) then {
	_unitIndex = 0;
};
private _unitArr = _unitTypes select _unitIndex;
_group setVariable ["unitIndex", _unitIndex + 1];

_unitArr params ["_unitType","_unitLoadout"];
private _newUnit = [_group,_unitType,_pos,_dir,_standTime] call MAI_fnc_spawnAI;
_newUnit setUnitLoadout _unitLoadout;

_newUnit