 /*
	MAI_fnc_simpleSpawnInterval

	Description:
		Sequential units spawn

	Arguments:
		0: Logic <OBJECT>
		1: 

	Return Value:
		None

*/

params [
	["_logic", objNull],
	["_groups", []],
	["_vehiclesInfo", []]
];
if (_logic isEqualTo objNull) exitWith {};
if (_groups isEqualTo []) exitWith {};

private _deleteVehicles = _logic getVariable ["deleteVehicles", false];
private _vehicles = _logic getVariable ["vehicles", []];
private _unitsPerInterval = _logic getVariable ["unitsPerInterval", 1];
private _interval = _logic getVariable ["interval", 0.1];
private _executionCodeVehicle = _logic getVariable ["executionCodeVehicle", {}];
private _checkBuildings = _logic getVariable ["checkBuildings", true];

// spawn vehicles
if (_deleteVehicles && !(_vehiclesInfo isEqualTo [])) exitWith {
	private _vehiclesInfoNew = +_vehiclesInfo;
	for "_i" from 1 to (_unitsPerInterval min count _vehiclesInfoNew) do {
		private _vehInfo = _vehiclesInfoNew deleteAt 0;
		private _vehicle = _vehInfo call MAI_fnc_createVehicleFromInfo;
		[_vehicle] call _executionCodeVehicle;
		_vehicles pushBack _vehicle;
		_logic setVariable ["vehicles", _vehicles];
	};
	[
		{
			_this call MAI_fnc_simpleSpawnInterval;
		},
		[_logic, _groups, _vehiclesInfoNew],
		_interval
	] call CBA_fnc_waitAndExecute;
};

private _executionCodeUnit = _logic getVariable ["executionCodeUnit", {}];
private _executionCodePatrol = _logic getVariable ["executionCodePatrol", {}];

private _spawnedUnits = _logic getVariable ["spawnedUnits", 0];

private _groupArray = _groups select 0;

_groupArray params ["_side", "_units", "_waypoints", "_behaviour", "_formation", "_combatmode", ["_group", grpNull]];

// create group when not present
if (_group isEqualTo grpNull) then {
	_group = createGroup [_side, true];
	_groupArray set [6, _group];
	_group setFormation _formation;
	_group setCombatMode _combatmode;
	[_group] call _executionCodePatrol;
	private _spawnedGroups = _logic getVariable ["spawnedGroups", []];
	_spawnedGroups pushBack _group;
	_logic setVariable ["spawnedGroups", _spawnedGroups];
	{
		_x params ["_wPos", "_wType", "_wTimeout", "_behaviour"];
		private _wp =_group addWaypoint [_wPos, 0];
		_wp setWaypointType _wType;
		_wp setWaypointTimeout _wTimeout;
		_wp setWaypointBehaviour _behaviour;
	} forEach _waypoints;
};

while {_spawnedUnits < _unitsPerInterval && !(_units isEqualTo [])} do {
	private _unit = objNull;
	private _unitArray = _units deleteAt 0;
	_unitArray params ["_type", "_loadout", "_pos", "_dir", "_stance", "_disabledAiFeatures", "_vehicleArray", "_building", "_buildingStatus"];
	if !(_vehicleArray isEqualTo []) then {
		_vehicleArray params ["_vehicle", "_role", "_cargoIndex", "_vehicleIndex"];
		if (_deleteVehicles && {_vehicle isEqualTo objNull}) then {
			_vehicle = _vehicles select _vehicleIndex;
		};
		if (alive _vehicle) then {
			// check if vehicle is static and _checkBuildings option is set
			if (
				_checkBuildings && {
				_vehicle isKindOf "StaticWeapon" &&
				{!(alive _building isEqualTo _buildingStatus)}
			}) exitWith {};
			_unit = [_group, _type, _pos, _dir, 0, false] call MAI_fnc_spawnAI;
			_spawnedUnits = _spawnedUnits + 1;
			_unit setUnitLoadout _loadout;
			_group addVehicle _vehicle;
			[_unit, _vehicle, _role, _cargoIndex] call MAI_fnc_moveInVehicleRole;
		};
	} else {
		if (!_checkBuildings || alive _building isEqualTo _buildingStatus) then {
			_unit = [_group, _type, _pos, _dir] call MAI_fnc_spawnAI;
			_spawnedUnits = _spawnedUnits + 1;
			_unit setUnitLoadout _loadout;
			_unit setUnitPos _stance;
		};
	};

	{
		[_unit, _x] remoteExecCall ["disableAI", 0, _unit];
	} forEach _disabledAiFeatures;

	[_unit] call _executionCodeUnit;

	if (_units isEqualTo []) then {
		_groups deleteAt 0;
	};
};

if (_groups isEqualTo []) exitWith {
	private _deactivation = _logic getVariable ["deactivation", -1];
	if (_deactivation >= 0) then {
		[
			{_this call MAI_fnc_simpleSpawnDespawn},
			[_logic],
			1
		]call CBA_fnc_waitAndExecute;
	};
};

[
	{
		_this call MAI_fnc_simpleSpawnInterval;
	},
	_this,
	_interval
] call CBA_fnc_waitAndExecute;

Nil