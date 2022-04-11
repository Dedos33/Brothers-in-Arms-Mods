 /*
	MAI_fnc_buildSpawnInit

	Description:
		Initiate buildSpawn on server, then wait until condition meet

	Arguments:
		0: Logic				<OBJECT>
		1: Trigger activated	<BOLEAN>
		2: Placed by curator	<BOLEAN>

	Return Value:
		None

*/
if (!isServer) exitWith {
	diag_log text "[MAI_fnc_buildSpawnInit] script intended to be only used on server, exit.";
};
//systemChat str _this;
params [
	["_logic",objNull,[objNull]],
	["_activated",true,[true]],
	["_isCuratorPlaced",true,[true]]
];

private _synchronizedObjects = synchronizedObjects _logic;
private _activationTriggers = _synchronizedObjects select {_x isKindOf "EmptyDetector"};
private _unitsSync = _synchronizedObjects select {_x isKindOf "Man"};

private _minDist = _logic getVariable ["minDist",35];
private _limitBuilding = _logic getVariable ["limitBuilding",2];
private _includeNotSupported = _logic getVariable ["includeNotSupported",false];

[_this, _unitsSync, _activationTriggers, _minDist, _limitBuilding] call BIS_fnc_log;

if (_unitsSync isEqualTo []) exitWith {
	(format ["[%1] BUILDSPAWN - No units synchronized!", _logic]) call BIS_fnc_error;
};

// Get objects in defined area
private _area = [getPosATL _logic];
_area append (_logic getVariable ["objectarea", []]);
_area params ["_logicPos", "_a", "_b"];

private _radius = (_a max _b) * 1.415;

private _buildings = nearestObjects [_logicPos, ["House", "CBA_BuildingPos"], _radius];
// exact area filter
_buildings = _buildings inAreaArray _area;

private _unitTypes = [];
private _waypoints = [];
private _side = side group (_unitsSync select 0);
private _customSpawnPositions = [];
{
	private _group = group _x;
	private _wp = [];
	{
		private _wPos = waypointPosition _x;
		if (_wPos distance2D leader _group > 0.5) then {
			private _wType = waypointType _x;
			private _wTimeout = waypointTimeout _x;
			_wp pushBack [_wPos, _wType, _wTimeout];
		};
	}forEach (waypoints _group);
	if !(_wp isEqualTo []) then {
		_waypoints pushBack _wp;
	};

	// Save loadouts of units in the group
	{
		_unitTypes pushBack [typeOf _x, getUnitLoadout _x];
		deleteVehicle _x;
		_customSpawnPositions pushBack [getposATL _x, getDir _x];
	} forEach (units _group);
	deleteGroup _group;
}forEach _unitsSync;
_logic setVariable ["customSpawnPositions", _customSpawnPositions];

// Find suitable buildings and save their spawn positions
private _spawnBuildings = [];
private _countPos = 0;
{
	private _building = _x;
	private _buildingClass = typeOf _building;
	// Check if CBA_BuildingPos have object under / above its position.
	// If have, this building will be added to this module instad of CBA_BuildingPos.
	if (_buildingClass isEqualTo "CBA_BuildingPos") then {
		private _buildingPos = getposATL _building;
		private _buildingDir = getDir _building;
		private _posASL = getposASL _building;
		private _objects = lineIntersectsWith [_posASL vectorAdd [0,0,0.5], _posASL vectorAdd [0,0,50], _building, objNull, true];
		if (_objects isEqualTo []) then {
			_objects = lineIntersectsWith [_posASL vectorAdd [0,0,0.5], _posASL vectorAdd [0,0,-1.5], _building, objNull, true];
		};
		if !(_objects isEqualTo [])then {
			_building = _objects select 0;
		};
		private _findIndex = _spawnBuildings findIf {_x select 1 isEqualTo _building};
		if (_findIndex == -1) then {
			// add new building
			_spawnBuildings pushBack [_building, [[_buildingPos, _buildingDir]], _limitBuilding];
		}else{
			// add new position to existing building
			((_spawnBuildings select _findIndex) select 2) pushBack [_buildingPos, _buildingDir];
		};
		_countPos = _countPos + 1;
	// Check if we have spawn position for this building type
	}else {
		if (isClass (configFile >> "CfgBuildspawn" >> _buildingClass)) then {
			private _buildingPositions = getArray (configFile >> "CfgBuildspawn" >> _buildingClass >> "spawnPositions");
			private _spawnPositions = [];
			{
				_x params ["_position", "_lookDir"];
				_spawnPositions pushBack [_building modelToWorld _position, _lookDir + getDir _building];
				_countPos = _countPos + 1;
			} forEach _buildingPositions;
			_spawnBuildings pushBack [_building, _spawnPositions, _limitBuilding];
		}else{
			if (_includeNotSupported) then {
				_allpositions = _building buildingPos -1;
				if !(_allpositions isEqualTo [])then {
					_spawnPositions = [];
					{
						_spawnPositions pushBack [_x, getDir _building];
						_countPos = _countPos + 1;
					}forEach _allpositions;
					_spawnBuildings pushBack [_building, _spawnPositions, _limitBuilding];
				};
			};
		}
	};
} forEach _buildings;

private _activationAdd = _logic getVariable ["activationAdd",100];
private _activation = _radius + _activationAdd;
private _deactivation = _logic getVariable ["deactivation",100];


private _location = nearestLocation [_logicPos, ""];

private _tickets = _logic getVariable ["tickets",1000];
if (is3DEN || is3DENMultiplayer) then {
	systemChat format ["[BUILDSPAWN] %1 buildings | %2 spawners | %3 tickets | %4 activation | %5", count _spawnBuildings, _countPos, _tickets, _activation, _location];
};
_logic setVariable ["activation",_activation];
_logic setVariable ["deactivation",_deactivation];
_logic setVariable ["unitTypes",_unitTypes];
_logic setVariable ["waypoints",_waypoints];
_logic setVariable ["spawnBuildings",_spawnBuildings];
_logic setVariable ["side",_side];
_logic setVariable ["activationTriggers",_activationTriggers];

[_logic] call MAI_fnc_buildSpawnWaitUntil;

Nil