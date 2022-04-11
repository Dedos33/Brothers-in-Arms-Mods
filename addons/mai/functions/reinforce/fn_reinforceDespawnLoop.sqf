 /*
	MAI_fnc_reinforceDespawnLoop

	Description:
		Loop to check if there are no players nearby to despawn vehicle.

*/

params [["_veh", objNull], ["_vehStartPos",[0,0,0]]];
if !(alive _veh) exitWith {};
if !(canMove _veh) exitWith {};
if !(alive driver _veh) exitWith {};

if ((_veh distance _vehStartPos) < 50) exitWith {
	private _crew = crew _veh;
	{
		private _group = group _x;
		deleteVehicle _x;
		deleteGroup _group;
	} forEach _crew;
	deleteVehicle _veh;
};

private _playerFound = false;
private _nearList = _veh nearEntities 1500;
{
	if (isPlayer _x && {alive _x}) exitWith {
		_playerFound = true;
	};
} forEach _nearList;

if (_playerFound) exitWith {
	[
		{
			_this call MAI_fnc_reinforceDespawnLoop
		},
		[_veh, _vehStartPos],
		10
	]call CBA_fnc_waitAndExecute
};

private _crew = crew _veh;
{
	private _group = group _x;
	deleteVehicle _x;
	deleteGroup _group;
} forEach _crew;
deleteVehicle _veh;