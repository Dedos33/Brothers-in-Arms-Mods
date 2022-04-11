 /*
	MadinAI_fnc_AiLoopStart

	Description:
		Server AI loop, can be switch on/off mid game in CBA settings

	Arguments:
		None

	Return Value:
		None

*/

[
	{time > 1},
	{
		call MadinAI_fnc_AiLoopStart;
		if (!isServer)then {
			{
				_x addEventHandler ["CuratorWaypointPlaced", {
					params ["_curator", "_group", "_waypointID"];
					_group setVariable ["MAI_editWaypoints",false,0];
					//if (missionNamespace getVariable ["MAI_AiLoopStart",false])exitWith{};
					//MAI_AiLoopStart = true;
					//call MadinAI_fnc_AiLoopStart;
				}];
			}forEach allCurators;
		};
	}
] call CBA_fnc_waitUntilAndExecute;