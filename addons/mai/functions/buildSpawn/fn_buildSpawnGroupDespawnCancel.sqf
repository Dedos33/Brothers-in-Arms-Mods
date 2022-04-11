 /*
	MAI_fnc_buildSpawnGroupDespawnCancel

	Description:
		Despawn unit that was spawned when player goes nerby building, but goes away from it.

	Arguments:
		0: Group						<GROUP>

	Return Value:
		None

*/

params [["_group",grpNull]];
{
	private _unit = _x;
	{
		_unit enableAI _x
	}forEach[
		"FSM",
		"COVER",
		"AUTOCOMBAT"
	];
}forEach units _group;

while {(count (waypoints _group)) > 0} do
{
	deleteWaypoint ((waypoints _group) select 0);
};
_group setVariable ["despawnActive",nil];