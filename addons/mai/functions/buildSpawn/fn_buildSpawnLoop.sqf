 /*
	MAI_fnc_buildSpawnLoop

	Description:
		Initiate buildSpawn main loop

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/

params [["_logic",objNull]];

if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MAI_fnc_buildSpawnLoop] logic is objNull, exit sctipt";
};

private _tickets = _logic getVariable ["tickets",0];
if (_tickets <= 0) exitWith {
	diag_log text "[MAI_fnc_buildSpawnLoop] tickets reached 0, exit script.";
	_logic setVariable ["active", false, true];
};

private _spawnbuildings = _logic getVariable ["spawnbuildings",[]];

if (_spawnbuildings isEqualTo []) exitWith {
	diag_log text "[MAI_fnc_buildSpawnLoop] tickets reached 0, exit script.";
	_logic setVariable ["active", false, true];
};

private _activation = _logic getVariable ["activation",1000];
private _deactivation = _logic getVariable ["deactivation",-1];
private _stationaryGroup = _logic getVariable ["stationaryGroup",grpNull];
private _patrolGroups = _logic getVariable ["patrolGroups",[]];
private _customSpawn = _logic getVariable ["customSpawn",false];
//private _maxDist = _logic getVariable ["maxDist", _activation];
private _minDist = _logic getVariable ["minDist",35];
private _unitTypes = _logic getVariable ["unitTypes",[]];
private _spawnChance = _logic getVariable ["spawnChance",100];
private _stationaryTime = _logic getVariable ["stationaryTime",[45,90,150]];
private _spawnPerBuilding = _logic getVariable ["spawnPerBuilding",[1,1.5,3]];
private _spawnHalfLimit = _logic getVariable ["spawnHalfLimit",8];
private _executionCodeUnit = _logic getVariable ["executionCodeUnit",{}];

// check if there are any players in work area. If not, suspend loop for 1s
private _nearUnitsMax = _logic nearEntities ["AllVehicles", _activation];
if ((_nearUnitsMax findIf {isPlayer _x && {alive _x}}) isEqualTo -1) exitWith {
	// used for despawn
	_logic setVariable ["suspended", true];
	[
		{
			_this call MAI_fnc_buildSpawnLoop;
		},
		_this,
		1
	] call CBA_fnc_waitAndExecute;

	if (_deactivation < 0) exitWith {};
	private _nearUnitsDespawn = _logic nearEntities ["AllVehicles", _activation + _deactivation];
	if ((_nearUnitsDespawn findIf {isPlayer _x && {alive _x}}) isEqualTo -1) then {
		{
			[_x, _logic] call MAI_fnc_buildSpawnGroupDespawn;
		}forEach _patrolGroups;
		[_stationaryGroup, _logic] call MAI_fnc_buildSpawnGroupDespawn;
	};
};

// check this condition only every ~ 0.5s
private _lastPatrolCheck = _logic getVariable ["lastPatrolCheck", -1];
if (_lastPatrolCheck + 0.5 < time) then {
	[_logic] call MAI_fnc_buildSpawnLoopSpawnPatrol;
	_logic setVariable ["lastPatrolCheck", time];
	private _suspended = _logic getVariable ["suspended", false];
	if (_suspended) then {
		_logic setVariable ["suspended", false];
		if (_customSpawn) then {
			[_logic] call MAI_fnc_buildSpawnPatrolCustomPos;
		};
	};
};

private _buildingsPerFrame = count _spawnbuildings / diag_fpsMin;
// set max to 50 buildings per frame. it should usually stay around 1-5 buildings per frame
private _maxBuildings = ceil _buildingsPerFrame min count _spawnbuildings min 50;

for "_i" from 1 to _maxBuildings do {
	// find if there are players closer than minimal distance to each building
	// if there is a player, spawn unit and delete building from script
	private _buildingArray = _spawnbuildings deleteAt 0;
	_buildingArray params ["_building", "_buildingPositons", "_limitBuilding", ["_forceSpawn", false]];
	// delete damaged buildings
	if (damage _building < 0.2) then {
		// find if there are players closer to building than minimal threshold
		private _nearplayers = _building nearEntities ["allVehicles", _minDist];
		private _player = _nearplayers findIf {isPlayer _x};
		if (_player != -1) then {
			// check spawn chance for bots, defined in module settings
			if (!_forceSpawn && random 100 > _spawnChance) exitWith {};
			// maximum number of bots that can be spawned
			private _maxPositions = (round random _spawnPerBuilding) max 1 min _tickets;
			// shuffle positions to use on spawn
			private _buildingPositonsToSpawn = [];
			private _buildingPositonsWork = +_buildingPositons;
			if (count _buildingPositons > _maxPositions) then {
				for "_i" from 1 to _maxPositions do {
					private _randomPos = _buildingPositonsWork deleteAt (floor Random (count _buildingPositonsWork));
					_buildingPositonsToSpawn pushBack _randomPos;
				};
			} else {
				_buildingPositonsToSpawn = +_buildingPositons;
			};
			// half spawn positions when alive units above set threshold
			if ({alive _x} count units _stationaryGroup > _spawnHalfLimit) then {
				_maxPositions = (_maxPositions / 2) max 1;
			};
			// track spawned units
			_units = [];
			// how long units will be forced to stand still
			// prevents units go prone in buildings after spawn
			private _standTime = random _stationaryTime;
			{
				private _buildingPosition = _x;
				_buildingPosition params ["_pos","_dir"];
				// prevent spawning multiple units in same place
				private _list = _pos nearEntities ["Man", 1];
				if (_list isEqualTo []) then {
					// spawn AI, get first type/loadout from list and move it to end of array.
					if (_stationaryGroup isEqualTo grpNull) then {
						private _side = _logic getVariable ["side", EAST];
						private _stationaryGroup = createGroup [_side, true];
						_logic setVariable ["stationaryGroup", _stationaryGroup];
					};
					private _newUnit = [_logic, _stationaryGroup, _unitTypes, _pos, _dir, _standTime + 5] call MAI_fnc_buildSpawnAiSpawn;
					_tickets = _tickets - 1;
					// make unit stationary until timeout set in module settings
					_newUnit disableAI "FSM";
					_newUnit disableAI "PATH";
					[
						{
							params [["_newUnit",objNull]];
							if (!alive _newUnit) exitWith {};
							// variable used to despawn
							_newUnit setVariable ["MAI_isMoving", true];
							_newUnit enableAI "PATH";
							_newUnit enableAI "FSM";
						},
						[_newUnit],
						_standTime
					] call CBA_fnc_waitAndExecute;
					// call custom code set by user
					[_newUnit] call _executionCodeUnit;
					// track spawned units for despawn function
					_units pushBack _newUnit;
				};
			} forEach _buildingPositonsToSpawn;
			// despawn function
			if !(_units isEqualTo []) then {
				[
					{
						_this call MAI_fnc_buildSpawnUnitDespawn
					},
					[_units, _logic, _building, _buildingPositons, _limitBuilding],
					5
				] call CBA_fnc_waitAndExecute;
			};
		} else {
			// put building back to array if not used
			_spawnbuildings pushBack _buildingArray;
		};
	};
};

if (_spawnbuildings isEqualTo []) exitWith {
	diag_log text "[MAI_fnc_buildSpawnLoop] tickets reached 0, exit script.";
	_logic setVariable ["active", false, true];
};

if (_buildingsPerFrame > 0.6) then {
	// buildings per frame
	[
		{
			_this call MAI_fnc_buildSpawnLoop;
		},
		_this,
		0
	] call CBA_fnc_waitAndExecute;
} else {
	// frames per building
	[
		{
			_this call MAI_fnc_buildSpawnLoop;
		},
		_this,
		1 / count _spawnbuildings
	] call CBA_fnc_waitAndExecute;
};

nil