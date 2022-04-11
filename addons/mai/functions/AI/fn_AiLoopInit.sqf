 /*
	MAI_fnc_AiLoopInit

	Description:
		Init AI loop, can be switch on/off mid game in CBA settings.
		Adds EventHandler for zeus.

	Arguments:
		None

	Return Value:
		None

*/

[
	{time > 1},
	{
		call MAI_fnc_AiLoopStart;
		if (!isServer) then {
			{
				_x addEventHandler ["CuratorWaypointPlaced", {
					params ["_curator", "_group", "_waypointID"];
					_group setVariable ["MAI_editWaypoints",false,0];
				}];
			}forEach allCurators;
		};
	}
] call CBA_fnc_waitUntilAndExecute;

Nil