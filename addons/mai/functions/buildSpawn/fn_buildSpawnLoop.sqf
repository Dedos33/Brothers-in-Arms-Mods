 /*
	MadinAI_fnc_buildSpawnLoop

	Description:
		Initiate buildSpawn main loop

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/

//systemChat "MadinAI_fnc_buildSpawnLoop";

params [["_logic",objNull]];
if (_logic isEqualTo objNull)exitWith {
	diag_log text "[MadinAI_fnc_buildSpawnLoop] logic is objNull, exit sctipt"
};
private _activation = _logic getVariable ["activation",10000];

// find if there are players nearby. If not, wait until they are.
private _nearUnits = _logic nearEntities ["AllVehicles", _activation];
if ((_nearUnits findIf {isPlayer _x && {alive _x}}) isEqualTo -1) exitWith{
	[{
		[_this] call MadinAI_fnc_buildSpawnLoop;
		},
		_logic,
		random [0.9,1,1.1]
	] call CBA_fnc_waitAndExecute;
};

private _spawnbuildings = _logic getVariable ["spawnbuildings",[]];
private _minDist = _logic getVariable ["minDist",35];
private _unitTypes = _logic getVariable ["unitTypes",[]];
private _tickets = _logic getVariable ["tickets",0];
private _patrolCount = _logic getVariable ["patrolCount",0];
private _stationaryGroup = _logic getVariable ["stationaryGroup",grpNull];
private _patrolGroup = _logic getVariable ["patrolGroup",grpNull];
private _executionCodeUnit = _logic getVariable ["executionCodeUnit",{}];

//systemChat str _tickets;

// find if there are players closer than minimal distance to each building.
// if there is a player, spawn unit and delete building from script.
{
	_x params ["_building", "_buildingPositons", "_limit"];
	if (damage _building < 0.2) then{
		_nearplayers = _building nearEntities ["allVehicles", _minDist];
		_player = _nearplayers findIf {isPlayer _x};
		if (_player != -1)then{
			private _randpos = selectRandom _buildingPositons;
			_randpos params ["_pos","_dir"];
			//systemChat format ["test %1 / %2",_pos,_dir];
			private _list = _pos nearEntities ["Man", 0.3];
			if (_list isEqualTo []) then{
				// spawn AI, get first type/loadout from list and move it to end of array.
				private _unitArr = _unitTypes deleteAt 0;
				_unitArr params ["_unitType","_unitLoadout"];
				private _standTime = random [45,60,75]; 
				private _newUnit = [_stationaryGroup,_unitType,_pos,_dir,_standTime] call MadinAI_fnc_spawnAI;
				_newUnit setUnitLoadout _unitLoadout;
				_unitTypes pushBack _unitArr;
				_tickets = _tickets - 1;
				_newUnit disableAI "FSM";
				_newUnit disableAI "PATH";
				[
					{
						params ["_newUnit"];
						_newUnit enableAI "PATH";
						_newUnit enableAI "FSM";
					},
					[_newUnit],
					_standTime - 30
				] call CBA_fnc_waitAndExecute;
				[_newUnit] call _executionCodeUnit;
			};
			// delete building from list, as it was "checked" by player.
			_spawnbuildings deleteAt _forEachIndex;
		};
	}else{
		// remove dammged/destroyed buildings from script.
		_spawnbuildings deleteAt _forEachIndex;
	};
}forEach _spawnbuildings;

if (_tickets < 0 || _spawnbuildings isEqualTo []) exitWith {
	diag_log text "[MadinAI_fnc_buildSpawnLoop] tickets reached 0, exit script.";
};
// spawn new units to patrol, if total count lower than defined
if ((({alive _x} count units _patrolGroup) + ({alive _x} count units _stationaryGroup)) < _patrolCount) then{
	private _randomBuild = floor random (count _spawnbuildings);
	private _build = _spawnbuildings select _randomBuild;
	_build params ["_building", "_buildingPositons", "_limit"];
	{
		_x params ["_pos","_dir"];
		private _list =_pos nearEntities ["Man", 0.3];
		if (_list isEqualTo []) then
		{
			// spawn AI, get first type/loadout from list and move it to end of array.
			private _unitArr = _unitTypes deleteAt 0;
			_unitArr params ["_unitType","_unitLoadout"];
			private _newUnit = [_patrolGroup,_unitType,_pos,_dir,30] call MadinAI_fnc_spawnAI;
			_newUnit disableAI "FSM";

			[
				{
					params ["_newUnit"];
					_newUnit enableAI "FSM";
				},
				[_newUnit],
				20
			] call CBA_fnc_waitAndExecute;

			_newUnit setUnitLoadout _unitLoadout;
			_unitTypes pushBack _unitArr;
			_tickets = _tickets - 1;
			[_newUnit] call _executionCodeUnit;
		};
	}forEach _buildingPositons;
	_limit = _limit - 1;
	if (_limit <= 0) then {
		_spawnbuildings deleteAt _randomBuild;
	}else{
		_build set [3,_limit];
	};

	/*
	// AI are "sometimes" blind/deaf fuking retards, need some help to not stay in place forever.
	if ((count (waypoints _patrolGroup)) < 2) then{
		_nearPlayers = [];
		{
			if (isPlayer _x && {alive _x && {_x isKindOf "Man"}}) then
			{
				_nearPlayers pushBack _x;
			};
		}forEach _nearUnits;
		if !(_nearPlayers isEqualTo []) then {
			private _victim = selectRandom _nearPlayers;
			[
				{
					params ["_patrolGroup","_victimPos"];
					private _waypoint = _patrolGroup addWaypoint [_victimPos, 5];
					_waypoint setWaypointCompletionRadius random [15,30,45];

				},
				[_patrolGroup, getposATL _victim],
				0.5
			] call CBA_fnc_waitAndExecute;
		};
	};
	*/
};

if (_tickets <= 0) exitWith {
	diag_log text "[MadinAI_fnc_buildSpawnLoop] tickets reached 0, exit script.";
};
if (_spawnbuildings isEqualTo []) exitWith {
	diag_log format ["[MadinAI_fnc_buildSpawnLoop] all possible buildings used with %1 tickets left, exit script.",_tickets];
};

_logic setVariable ["spawnbuildings",_spawnbuildings];
_logic setVariable ["tickets",_tickets];
_logic setVariable ["unitTypes",_unitTypes];

[{
	[_this] call MadinAI_fnc_buildSpawnLoop;
	},
	_logic,
	random [0.9,1,1.1]
] call CBA_fnc_waitAndExecute;