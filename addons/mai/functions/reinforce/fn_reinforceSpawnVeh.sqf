 /*
	MAI_fnc_reinforceSpawnVeh

	Description:
		Spawns vehicle with crew and simple "AI", to repond to enemy fire.

*/

params [
	["_logic", objNull, [objNull]],
	["_vehicleInfo", [], [[]]],
	["_fullCrew", [], [[]]],
	["_side", civilian, [civilian]],
	["_waypoints", [], [[]]],
	["_quantity", 1, [1]]
];

private _destination = _logic getVariable ["destination",getPosATL _logic];
private _despawn = _logic getVariable ["despawn", false];
private _distance = _logic getVariable ["distance", 300];
private _minimalCrew = _logic getVariable ["minimalCrew", 2];
private _executionCodeVehicle = _logic getVariable ["executionCodeVehicle", {}];
private _executionCodeUnit = _logic getVariable ["executionCodeUnit", {}];
private _executionCodePatrol = _logic getVariable ["executionCodePatrol", {}];
private _executionCodeVehicleCrew = _logic getVariable ["executionCodeVehicleCrew", {}];

private _veh = _vehicleInfo call MAI_fnc_createVehicleFromInfo;
[_veh] call _executionCodeVehicle;
private _GroupVeh = createGroup [_side, true];
private _GroupCargo = createGroup [_side, true];
_GroupVeh setVariable ["MAI_enable", false, true];
_GroupCargo setVariable ["MAI_enable", false, true];
[_GroupVeh] call _executionCodeVehicleCrew;
[_GroupCargo] call _executionCodePatrol;

/*
	["_vehType", ""],
	["_vehPos", [0,0,0]],
	["_vehDir", 0],
	["_vehFuel", 1],
	["_vehDamage", 0],
	["_vehicleHitPoints", []],
	["_vehCustom", []],
	["_vehAmmo", []],
	["_cargo", []]
*/
private _vehStartPos = _vehicleInfo select 1;
private _newUnits = [];
{
	_x params ["_typeUnit", "_role", "_cargoIndex", "_loadout"];
	private _unit = objNull;
	private _seat = toLower (_role select 0);
	if (_seat == "cargo") then
	{
		_unit = _GroupCargo createUnit [_typeUnit, _vehStartPos, [], 5, "NONE"];
	}else{
		_unit = _GroupVeh createUnit [_typeUnit, _vehStartPos, [], 5, "NONE"];
	};
	_newUnits pushBack _unit;
	_unit setUnitLoadout _loadout;
	_unit setVariable ["acex_headless_blacklist", true];
	{[_x, [[_unit],true]] remoteExec ["addCuratorEditableObjects", 0]} forEach allCurators;
	[_unit] call _executionCodeUnit;
} forEach _fullCrew;

_GroupVeh addVehicle _veh;
_GroupCargo addVehicle _veh;

(units _GroupVeh) orderGetIn true;
(units _groupCargo) orderGetIn true;

{
	_x params ["_typeUnit", "_role", "_cargoIndex", "_loadout"];
	private _unit = _newUnits select _forEachIndex;
	[_unit, _veh, _role, _cargoIndex] call MAI_fnc_moveInVehicleRole;
} forEach _fullCrew;
if !(_veh isKindOf "LandVehicle") then {
	_GroupVeh setBehaviourStrong "SAFE";
};

_veh engineOn true;
_veh setUnloadInCombat [false, false];
//(units _groupCargo) orderGetIn true;
//_veh allowCrewInImmobile true;

if ((units _GroupCargo) isEqualTo []) then {
	deleteGroup _GroupCargo;
}else{
	private _waypointCargo = _GroupCargo addWaypoint [position _veh, 0];
	_waypointCargo setWaypointType "GETIN";
	_waypointCargo waypointAttachVehicle _veh;
};


[
	{
		params [
			["_logic", objNull, [objNull]],
			["_vehicleInfo", [], [[]]],
			["_fullCrew", [], [[]]],
			["_side",civilian, [civilian]],
			["_waypoints", [], [[]]],
			"_quantity",
			"_veh",
			"_GroupVeh",
			"_GroupCargo",
			"_destination",
			"_despawn",
			"_distance",
			"_minimalCrew"
		];
		// stops script when veh got deleted or killed
		if (!alive _veh) exitWith {};
		// despawn and spawn again if veh got stuck and won't move
		private _vehStartPos = _vehicleInfo select 1;
		private _vehDistFromSpawn = _veh distance _vehStartPos;
		if (_vehDistFromSpawn < 20) exitWith {
			[count _fullCrew] remoteExecCall ["MAI_fnc_expectedNewUnitsCountReturn", 2, false];
			[
				{
					params [
						["_logic", objNull, [objNull]],
						["_vehicleInfo", [], [[]]],
						["_fullCrew", [], [[]]],
						["_side",civilian, [civilian]],
						["_waypoints", [], [[]]],
						"_quantity",
						"_veh",
						"_GroupVeh",
						"_GroupCargo",
						"_destination",
						"_despawn",
						"_distance",
						"_minimalCrew"
					];
					{deleteVehicle _x} forEach units _GroupVeh;
					{deleteVehicle _x} forEach units _GroupCargo;
					{deleteGroup _x} forEach [_GroupVeh, _GroupCargo];
					deleteVehicle _veh;
					[
						{
							_this call MAI_fnc_reinforceSpawnVeh;
						},
						[_logic, _vehicleInfo, _fullCrew, _side, _waypoints, _quantity]
					] call CBA_fnc_execNextFrame;
				},
				_this,
				1
			]call CBA_fnc_waitAndExecute;
		};
		if (_veh isKindOf "LandVehicle") then {
			[_veh, _GroupVeh, _GroupCargo, _destination, _despawn, _distance, _vehStartPos] call MAI_fnc_reinforceVehAI;
		} else {
			[_veh, _GroupVeh, _GroupCargo, _destination, _despawn, _distance, _vehStartPos] call MAI_fnc_reinforceVehAirAI;
		};
		// check if there will be more than 1 vehicle to spawn
		_quantity = _quantity -1;
		if (_quantity > 0) then {
			private _units = crew _veh;
			[
				_logic,
				_vehicleInfo,
				_fullCrew,
				_side,
				_waypoints,
				_quantity,
				_units
			] call MAI_fnc_reinforceVehWaitToSpawn;
		}
	},
	[
		_logic,
		_vehicleInfo,
		_fullCrew,
		_side,
		_waypoints,
		_quantity,
		_veh,
		_groupVeh,
		_groupCargo,
		_destination,
		_despawn,
		_distance,
		_minimalCrew
	],
	30
]call CBA_fnc_waitAndExecute;

_veh setVariable ["MAI_vehStartPos", _vehStartPos];
_veh setVariable ["MAI_despawn", _despawn];

// delete all units that somehow aren't in vehicle
[
	{
		params [["_veh", objNull], ["_GroupCargo",grpNull], ["_GroupVeh",grpNull], ["_destination", [0,0,0]], ["_waypoints", []]];
		{
			if (vehicle _x isEqualTo _x) then {
				deleteVehicle _x
			};
		} forEach (units _GroupCargo);
		{
			if (vehicle _x isEqualTo _x) then {
				deleteVehicle _x
			};
		} forEach (units _GroupVeh);

		{
			_x params ["_wPos", "_wType", "_wTimeout", "_behaviour"];
			private _wp =_groupVeh addWaypoint [_wPos, 0];
			_wp setWaypointType _wType;
			_wp setWaypointTimeout _wTimeout;
			_wp setWaypointBehaviour _behaviour;
			if (_wType isEqualTo "TR UNLOAD") then {
				_wp setWaypointStatements ["true", "this call MAI_fnc_reinforceUnloadStatements"];
				private _wpCargo =_GroupCargo addWaypoint [_wPos, 0];
				_wpCargo setWaypointType "GETOUT";
			};
		} forEach _waypoints;

		if (_veh isKindOf "LandVehicle") then {
			private _waypointdriver = _GroupVeh addWaypoint [_destination, 0];
			//_waypointdriver setWaypointCompletionRadius 50;
		};
	},
	[_veh, _GroupCargo, _GroupVeh, _destination, _waypoints],
	5
]call CBA_fnc_waitAndExecute;

// return to server that new units was spawned.
[- (count _fullCrew)] remoteExecCall ["MAI_fnc_expectedNewUnitsCountReturn", 2, false];