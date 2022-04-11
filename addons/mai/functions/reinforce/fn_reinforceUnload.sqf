 /*
	MAI_fnc_reinforceUnload

	Description:
		Unload all AI from cargo

*/

params ["_veh", "_GroupVeh", "_GroupCargo", "_destination", "_despawn", "_distance", "_vehStartPos"];
_veh forceSpeed 0;
_veh allowCrewInImmobile false;

//systemChat format ["%1 / %2", _veh, _veh distance _destination];
 while {(count (waypoints _GroupVeh)) > 0} do
 {
  deleteWaypoint ((waypoints _GroupVeh) select 0);
 };
private _waypointdriver = _GroupVeh addWaypoint [getposATL _veh, 0];
_GroupCargo leaveVehicle _veh;
[units _GroupCargo, _veh] call MAI_fnc_reinforceUnloadUnits;

[
	{
		params [["_veh",objNull], "_GroupVeh", "_GroupCargo", "_destination", "_despawn", "_distance", "_vehStartPos"];
		if (!alive _veh) exitWith {true};
		(speed _veh) isEqualTo 0
	},
	{
		_this call MAI_fnc_reinforceUnloadFinish
	},
	_this,
	10,
	{
		_this call MAI_fnc_reinforceUnloadFinish
	}
]call CBA_fnc_waitUntilAndExecute;