 /*
	MAI_fnc_buildSpawnPatrolCustomPos

	Description:
		Spawn patrol from build spawn on custom positions (units position in 3den)

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/

params [["_logic",objNull,[objNull]]];
if (_logic isEqualTo objNull) exitWith {};

private _patrolGroups = _logic getVariable  ["patrolGroups",[]];
private _groupCount = _logic getVariable  ["groupCount",0];
private _patrolCount = _logic getVariable  ["patrolCount",0];
private _customSpawnPositions = _logic getVariable  ["customSpawnPositions",[]];
private _unitTypes= _logic getVariable  ["unitTypes",[]];
private _executionCodeUnit = _logic getVariable ["executionCodeUnit",{}];
private _tickets = _logic getVariable  ["tickets",0];

private _customSpawnPositionsWork = +_customSpawnPositions;
{
	if ({alive _x} count units _x <= 0) then {
		deleteGroup _x;
		_patrolGroups deleteAt _forEachIndex;
	};
} forEach _patrolGroups;
private _aliveGroups = count _patrolGroups;
private _groupsLeft = _groupCount - _aliveGroups;
if (_groupsLeft <= 0) exitWith {};
for "_i" from 1 to _groupsLeft do {
	private _group = [_logic] call MAI_fnc_buildSpawnGroupPatrol;
	_patrolGroups pushBack _group;

	if (!(_customSpawnPositions isEqualTo [])) then {
		for "_i" from 1 to _patrolCount do {
			private _posParams = _customSpawnPositionsWork deleteAt 0;

			_posParams params ["_pos", "_dir"];
			private _newUnit = [_logic, _group, _unitTypes, _pos, _dir, 0] call MAI_fnc_buildSpawnAiSpawn;
			
			_newUnit addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				[_unit] call MAI_fnc_buildSpawnOnKilledPatrol;
			}];
			_newUnit addEventHandler ["Deleted", {
				params ["_entity"];
				[_entity] call MAI_fnc_buildSpawnOnKilledPatrol;
			}];


			_customSpawnPositionsWork pushBack _posParams;

			_tickets = _tickets - 1;

			[_newUnit] call _executionCodeUnit;

			if (_tickets <= 0) exitWith {};
		};
	};
};

_logic setVariable ["tickets",_tickets];

_logic setVariable ["patrolGroups",_patrolGroups];

Nil