 /*
	MAI_fnc_patrolRandomWaypoints

	Description:
		Add random waypoints for group.

	Arguments:
		0: Group						<GROUP>
		1: Position ATL center			<POS>
		2: Max waypoint distance		<STRING>	(OPTIONAL)
		3: Number of Waypoints			<NUMBER>	(OPTIONAL)
		4: Delete existing Waypoints	<BOOL>		(OPTIONAL)

	Return Value:
		None

*/

params [
	["_group",grpNull],
	["_pos",[0,0,0]],
	["_distance",100],
	["_quantity",6],
	["_deleteExistingWaypoints",false]
];

if (_deleteExistingWaypoints) then {
	while {(count (waypoints _group)) > 0} do
	{
		deleteWaypoint ((waypoints _group) select 0);
	};
};
for "_i" from 1 to _quantity -1 do {
	_group addWaypoint [_pos, _distance]
};
private _loopWaypoint = _group addWaypoint [_pos, _distance];
_loopWaypoint setWaypointType "CYCLE";

Nil