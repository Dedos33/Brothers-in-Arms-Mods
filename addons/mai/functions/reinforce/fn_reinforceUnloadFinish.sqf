 /*
	MAI_fnc_reinforceUnloadFinish

	Description:
		Unload all AI from cargo, second phase

*/

params ["_veh", "_GroupVeh", "_GroupCargo", "_destination", "_despawn", "_distance", "_vehStartPos"];

{_x enableAI "FSM"} forEach units _GroupCargo;
{_x enableAI "FSM"} forEach units _GroupVeh;
_GroupVeh setVariable ["MAI_enable", nil, true];
_GroupCargo setVariable ["MAI_enable", nil, true];
if (!alive _veh) exitWith {};
// force vehicle to unload and stop
if (units _GroupCargo isEqualTo []) exitWith {_veh forceSpeed -1};
[_GroupVeh] call CBA_fnc_clearWaypoints;
private _waypointdriver = _GroupVeh addWaypoint [getposATL _veh, 0];
_waypointdriver setWaypointType "TR UNLOAD";
_waypointdriver setWaypointStatements ["true", "this call MAI_fnc_reinforceUnloadStatements"];
(units _GroupCargo) allowGetIn false;

// set unloaded units to patrol area
//private _leader = leader _GroupCargo;
//private _behaviour = behaviour _leader;
[_GroupCargo, _destination, 100, 6, true] call MAI_fnc_patrolRandomWaypoints;
_GroupCargo setVariable ["MAI_enable", true, true];

[
	{
		params [["_group",grpNull,[grpNull]]];
		[units _GroupCargo] call MAI_fnc_reinforceUnloadUnits;
	},
	[_GroupCargo],
	2 + random 1
]call CBA_fnc_waitAndExecute;