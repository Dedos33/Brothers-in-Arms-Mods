 /*
	MAI_fnc_buildSpawnLoopSpawnPatrol

	Description:
		

	Arguments:
		0:

	Return Value:


*/

params [["_logic",objNull]];
if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MAI_fnc_buildSpawnLoopSpawnPatrol] logic is objNull, exit sctipt";
	false
};

private _patrolGroups = _logic getVariable ["patrolGroups",[]];
private _spawnbuildings = _logic getVariable ["spawnbuildings",[]];
private _unitTypes = _logic getVariable ["unitTypes",[]];
private _tickets = _logic getVariable ["tickets",0];
private _patrolCount = _logic getVariable ["patrolCount",0];
private _executionCodeUnit = _logic getVariable ["executionCodeUnit",{}];
private _minimalCount = _logic getVariable ["minimalCount", 1];
private _maxWait = _logic getVariable ["maxWait", 180];
private _defendOnly = _logic getVariable ["defendOnly", false];

private _group = _patrolGroups deleteAt 0;
// check if group was deleted. If so, spawn new group and update array.
if (_group isEqualTo grpNull) then {
	_group = [_logic] call MAI_fnc_buildSpawnGroupPatrol;
	_group setVariable ["MAI_logic", _logic];
	_group setVariable ["MAI_defendOnly", _defendOnly];
};
// to track if any unit was spawned
private _currentTickets = _tickets;

private _neededMan = _patrolCount - ({alive _x} count units _group);
// check when unit was first killed after last spawn wave
if (_neededMan > 0) then {
	private _minimalUnitsReached = _group getVariable ["minimalUnitsReached", false];
	private _spawnTimeout = _group getVariable ["firstKilledTime", -1];
	// sorted buildings for group
	private _groupBuildings = _group getVariable ["groupBuildings", []];
	if (
		!_minimalUnitsReached && {_patrolCount - _neededMan <= _minimalCount} ||
		_spawnTimeout != -1 && {_spawnTimeout + _maxWait < time}
	) then {
		_minimalUnitsReached = true;
		// sort buildings
		private _buildingArray = selectRandom _spawnbuildings;
		_buildingArray params ["_building", "_buildingPositons", "_limitBuilding"];
		_groupBuildings = [];
		{
			private _newBuilding = _x select 0;
			_groupBuildings pushBack [_building distance _newBuilding, _newBuilding];
		} forEach _spawnbuildings;
		_groupBuildings sort true;
		_group setVariable ["groupBuildings", _groupBuildings];
	};
	if (_minimalUnitsReached) then {
		// restart timer on spawn wave, intend to track first kill after end of spawn wave
		_group setVariable ["firstKilledTime", nil];
		// get random building from array to spawn unit
		private _wantedBuildingArray = objNull;
		private _index = floor random count _spawnbuildings;
		if !(_groupBuildings isEqualTo []) then {
			_wantedBuildingArray = _groupBuildings deleteAt 0;
			_groupBuildings pushBack _wantedBuildingArray;
			private _wantedBuilding = _wantedBuildingArray select 1;
			private _indexSearch = _spawnbuildings findIf {_x select 0 isEqualTo _wantedBuilding};
			if (_indexSearch != -1) then {
				_index = _indexSearch;
			};
		};
		private _buildingArray = _spawnbuildings select _index;
		_buildingArray params ["_building", "_buildingPositons", "_limitBuilding"];
		private _maxPositions = _neededMan min count _buildingPositons min _tickets;
		// shuffle new positions, if there are more than needed
		private _buildingPositonsToSpawn = [];
		if (count _buildingPositons > _maxPositions) then {
			for "_i" from 1 to _maxPositions do {
				_buildingPositonsToSpawn pushBack (_buildingPositons deleteAt floor Random count _buildingPositons);
			};
		} else {
			_buildingPositonsToSpawn = _buildingPositons;
		};
		{
			_x params ["_pos","_dir"];
			// check if there are units in same position, suspend spawn if true
			private _list =_pos nearEntities ["Man", 1];
			if (_list isEqualTo []) then
			{
				// spawn AI, get first type/loadout from list and move it to end of array
				private _newUnit = [_logic, _group, _unitTypes, _pos, _dir, 0] call MAI_fnc_buildSpawnAiSpawn;
				// EH deleted don't support group check
				_newUnit setVariable ["MAI_group", _group];
				// track when first unit was killed, to initiate new spawn wave
				_newUnit addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					[_unit] call MAI_fnc_buildSpawnOnKilledPatrol;
				}];
				_newUnit addEventHandler ["Deleted", {
					params ["_entity"];
					[_entity] call MAI_fnc_buildSpawnOnKilledPatrol;
				}];

				// prevent unit stuck in building after start
				_newUnit disableAI "FSM";
				[
					{
						params ["_newUnit"];
						_newUnit enableAI "FSM";
					},
					[_newUnit],
					15
				] call CBA_fnc_waitAndExecute;

				_tickets = _tickets - 1;
				_newUnit doFollow leader _newUnit;

				[_newUnit] call _executionCodeUnit;
			};
		}forEach _buildingPositonsToSpawn;
		// limit how many units can be spawned from one building
		if (_tickets < _currentTickets) then {
			_limitBuilding = _limitBuilding - 1;
		};
		if (_limitBuilding > 0) then {
			_buildingArray set [2,_limitBuilding];
		} else {
			_spawnbuildings deleteAt _index;
		};
		// check for end spawn wave
		if (({alive _x} count units _group) >= _patrolCount) then {
			_group setVariable ["minimalUnitsReached", false];
		} else {
			_group setVariable ["minimalUnitsReached", true];
		};
	};
	// prevent spawn multiple groups on same time, so spawners won't shuffle every spawn
};
_patrolGroups pushBack _group;

_logic setVariable ["tickets",_tickets];

true