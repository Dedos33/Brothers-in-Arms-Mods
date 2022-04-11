 /*
	MAI_fnc_buildSpawnGroupPatrol

	Description:
		Set first spawned group on patrol

	Arguments:
		0: Logic		<OBJECT>

	Return Value:
		0: New group	<GROUP>

*/

params [["_logic",objNull,[objNull]]];
if (_logic isEqualTo objNull) exitWith {};

private _groupCount = _logic getVariable ["groupCount",1];
private _waypoints = _logic getVariable ["waypoints",[]];
private _side = _logic getVariable ["side",EAST];

private _group = createGroup [_side, true];

_group setSpeedMode "LIMITED";

if !(_waypoints isEqualTo [])then {
	private _wpArr = _waypoints deleteAt 0;
	{
		_x params ["_wPos","_wType","_wTimeout"];
		private _wp =_group addWaypoint [_wPos, 0];
		_wp setWaypointType _wType;
		_wp setWaypointTimeout _wTimeout;
	}forEach _wpArr;
	_waypoints pushBack _wpArr;
}else{
	private _maxDist = _logic getVariable ["maxDist", 100];
	private _patrolDistance = _maxDist max 50;
	[_group, getposATL _logic, _patrolDistance, 6, true] call MAI_fnc_patrolRandomWaypoints;
};

_executionCodePatrol = _logic getVariable ["executionCodePatrol",{}];
[_group] call _executionCodePatrol;

[
	{
		params [["_group",grpNull]];
		if !(behaviour leader _group isEqualTo "COMBAT")then {
			_group setBehaviour "SAFE";
		};
	},
	[_group],
	3
]call CBA_fnc_waitAndExecute;

_group