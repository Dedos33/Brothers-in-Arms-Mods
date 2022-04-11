 /*
	MAI_fnc_reinforceDespawn

	Description:
		Unlocks vehicle / despawn after reinforces arrived

*/

params ["_veh", "_vehStartPos", "_GroupVeh", "_despawn"];
if (!alive _veh) exitWith {};
_veh forceSpeed -1;
if (!_despawn) exitWith {
	_GroupVeh setVariable ["MAI_enable", true, true];
};
// stop ai running around without vehicle when intended to despawn
_veh allowCrewInImmobile true;

 while {(count (waypoints _GroupVeh)) > 0} do
 {
 	deleteWaypoint ((waypoints _GroupVeh) select 0);
 };
private _waypointdriver = _GroupVeh addWaypoint [_vehStartPos, 0];
[
	{
		_this call MAI_fnc_reinforceDespawnLoop
	},
	[_veh, _vehStartPos],
	60
]call CBA_fnc_waitAndExecute
