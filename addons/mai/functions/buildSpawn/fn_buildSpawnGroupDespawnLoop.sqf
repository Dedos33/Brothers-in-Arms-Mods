 /*
	MAI_fnc_buildSpawnGroupDespawnLoop

	Description:
		Despawn unit that was spawned when player goes nerby building, but goes away from it.

	Arguments:
		0: Group						<GROUP>
		1: Logic						<OBJECT>

	Return Value:
		None

*/

params [["_group",grpNull],["_logic",objNull]];

if (units _group findIf {alive _x} isEqualTo -1) exitWith {};

if (_logic isEqualTo objNull) exitWith {
	_group call MAI_fnc_buildSpawnGroupDespawnCancel;
};

private _suspended = _logic getVariable ["suspended",false];
// exit script when units 
if !(_suspended) exitWith {
	_group call MAI_fnc_buildSpawnGroupDespawnCancel;
};


if (_group getVariable ["despawnActive",false]) then {
	[
		{
			_this call MAI_fnc_buildSpawnGroupDespawnLoop;
		},
		_this,
		random [2.5,3,3.5]
	]call CBA_fnc_waitAndExecute;
};

private _waypoints = waypoints _group;
private _despawnPos = _group getVariable ["despawnPos",[0,0,0]];
if (count _waypoints <= 1) then {
	_despawnPos = getposATL _logic;
	private _wp = _group addWaypoint [_despawnPos, 0];
	_wp setWaypointTimeout [6000, 6000, 6000];
	_group setVariable ["despawnPos",_despawnPos];
};

private _tickets = _logic getVariable ["tickets",0];
private _limitBuilding = _logic getVariable ["limitBuilding",0];
{
	private _toDespawn = _x distance _despawnPos;
	if (_toDespawn < 15) then {
		deleteVehicle _x;
		_tickets = _tickets + 1;
		deleteGroup _group;
	}else{
		private _nearUnits = _x nearEntities ["AllVehicles", 350];
		if ((_nearUnits findIf {isPlayer _x && {alive _x}}) isEqualTo -1) then {

			_buildingArray = _x getVariable ["buildingArray",[]];
			if !(_buildingArray isEqualTo []) then {
				_buildingArray params ["_building", "_buildingPositons", "_limitBuilding"];

				private _spawnbuildings = _logic getVariable ["spawnbuildings",[]];
				private _index = _spawnbuildings findIf {_x select 0 isEqualTo _building};
				if (_index isEqualTo -1) then {
					_spawnbuildings pushBack _buildingArray;
				}else{
					private _buildingTickets = (_spawnbuildings select _index) select 2;
					_spawnbuildings select _index set [2, (_buildingTickets + 1) max _limitBuilding];
				};
			};
			deleteVehicle _x;
			_tickets = _tickets + 1;
			deleteGroup _group;
		};
	};
}forEach units _group;

_logic setVariable ["tickets",_tickets];

Nil