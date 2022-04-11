 /*
	MAI_fnc_reinforceUnloadStatements

	Description:

*/

params ["_leader"];
if !(local _leader) exitWith {};
private _veh = vehicle _leader;
if (_leader isEqualTo _veh) exitWith {};
private _vehStartPos = _veh getVariable ["MAI_vehStartPos", [0,0,0]];
if (_vehStartPos isEqualTo [0,0,0]) exitWith {};
private _despawn = _veh getVariable ["MAI_despawn", false];
[_veh, _vehStartPos, group _leader, _despawn] call MAI_fnc_reinforceDespawn;