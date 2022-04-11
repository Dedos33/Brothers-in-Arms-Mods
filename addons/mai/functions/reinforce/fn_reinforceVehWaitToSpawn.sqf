 /*
	MAI_fnc_reinforceVehWaitToSpawn

	Description:
		Spawns vehicle with crew and simple "AI", to repond to enemy fire.

*/

params [
	["_logic", objNull, [objNull]],
	["_vehType", "", [""]],
	["_vehStartPos", [0,0,0], [[]]],
	["_vehicleDir",0, [0]],
	["_fullCrew", [], [[]]],
	["_side", civilian, [civilian]],
	["_vehCustom", [], [[]]],
	["_waypoints", [], [[]]],
	["_quantity", 1, [1]],
	["_units", [], [[]]]
];

if (_logic isEqualTo objNull) exitWith {};

private _minimalCrew = _logic getVariable ["minimalCrew", 2];
private _maxUnitsOnMap = _logic getVariable ["maxUnitsOnMap", 0];

if (({alive _x} count _units) > _minimalCrew || (count allUnits - count allPlayers) >= _maxUnitsOnMap) exitWith {
	[
		{_this call MAI_fnc_reinforceVehWaitToSpawn},
		_this,
		1 + random 1
	]call CBA_fnc_waitAndExecute;
};
[_logic, _vehType, _vehStartPos, _vehicleDir, _fullCrew, _side, _vehCustom, _waypoints, _quantity] call MAI_fnc_reinforceSpawnVeh;

Nil