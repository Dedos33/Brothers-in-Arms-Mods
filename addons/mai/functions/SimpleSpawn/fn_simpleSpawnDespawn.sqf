 /*
	MAI_fnc_simpleSpawnDespawn

	Description:
		Despawn units

	Arguments:
		0: Logic <OBJECT>
		1: 

	Return Value:
		None

*/

params [
	["_logic", objNull, [objNull]]
];

if (_logic isEqualTo objNull) exitWith {};

private _spawnedGroups = _logic getVariable ["spawnedGroups", []];
// check for every group if there are any allive units.
private _aliveGroupIndex = _spawnedGroups findIf {
	(units _x findIf {alive _x}) != -1
};
if (_aliveGroupIndex == -1) exitWith {}; // no alive units left.

private _activation = _logic getVariable ["activation", 750];
private _deactivation = _logic getVariable ["deactivation", 750];
private _deactivationDistance = _activation + _deactivation;

private _nearUnits = _logic nearEntities ["AllVehicles", _deactivationDistance];

private _playersNear = (_nearUnits findIf {isPlayer _x && {alive _x}}) != -1;

private _activateByDistance = ((_nearUnits findIf {isPlayer _x}) != -1);

if !(_activateByDistance) exitWith {
	{
		{
			if (alive _x && stance _x == "STAND") then {
				[_x,"AmovPercMstpSrasWrflDnon_AinvPknlMstpSlayWrflDnon"] remoteExec ["switchMove", 0];
			};
		} forEach units _x;
	} forEach _spawnedGroups;
	[
		{
			params [["_logic", objNull, [objNull]]];
			private _spawnedGroups = _logic getVariable ["spawnedGroups", []];
			private _groupsArray = [_spawnedGroups] call MAI_fnc_simpleSpawnGetGroups;
			_groupsArray params ["_groups", "_vehiclesInfo", "_vehiclesToDelete"];
			_logic setVariable ["groups", _groups];
			_logic setVariable ["vehiclesInfo", _vehiclesInfo];
			private _vehicles = _logic getVariable ["vehicles", []];
			{
				deleteVehicle _x;
			} forEach _vehicles;
			_logic setVariable ["vehicles", nil];
			[
				{_this call MAI_fnc_simpleSpawnWaitUntil},
				_this,
				random [0.9,1,1.1]
			] call CBA_fnc_waitAndExecute;
		},
		_this,
		0.5
	] call CBA_fnc_waitAndExecute;
};

[
	{_this call MAI_fnc_simpleSpawnDespawn},
	_this,
	random [0.9,1,1.1]
] call CBA_fnc_waitAndExecute;

Nil