 /*
	MAI_fnc_AiForceFormation

	Description:
		Force units to move (formation) when zeus add new waypoint.
		Usefull when AI want's to hide behind tree, and Zeus want this AI to move.

	Arguments:
		None

	Return Value:
		None

*/
{
	_x addEventHandler ["CuratorWaypointPlaced", {
		if (MAI_AiForceFormation) then {
			params ["_curator", "_group", "_waypointID"];
			{
				[_x, leader _x] remoteExecCall ["doFollow", _x, false];
			}forEach units _group;
		};
	}];
}forEach allCurators;
Nil