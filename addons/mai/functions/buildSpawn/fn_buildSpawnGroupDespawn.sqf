 /*
	MAI_fnc_buildSpawnGroupDespawn

	Description:
		Despawn unit that was spawned when player goes nerby building, but goes away from it.

	Arguments:
		0: Group			<GROUP>
		1: Logic			<OBJECT>

	Return Value:
		0: despawn called	<BOOL>

*/

params [["_group",grpNull],["_logic",objNull]];

if (_group isEqualTo grpNull) exitWith {};
if (_logic isEqualTo objNull) exitWith {};
if (_group getVariable ["despawnActive",false]) exitWith {};
_group setVariable ["despawnActive",true];

_group setVariable ["MAI_enable", false];

[_group] call CBA_fnc_clearWaypoints;

// all default buildings
_baseSpawnBuildings = _logic getVariable ["baseSpawnBuildings",[]];

private _nearest = [objNull, 999999];
private _leader = getposATL leader _group;
{
	private _building = _x select 0;
	if (alive _building) then {
		private _distance = _leader distance2D _building;
		if (_distance < (_nearest select 1)) then {
			_nearest = [_building, _distance];
		};
	};
}forEach _baseSpawnBuildings;

_nearest params ["_building", "_distance"];
private _pos = getposATL _building;
if (_building isEqualTo objNull) then {
	_pos = getposATL _logic;
}else{
	_pos = getposATL _building;
};
_group setVariable ["despawnPos",_pos];

private _wp =_group addWaypoint [_pos, 0];
_wp setWaypointTimeout [6000, 6000, 6000];
{
	private _unit = _x;
	_unit doFollow leader _unit;
	{
		_unit disableAI _x
	}forEach[
		"FSM",
		"COVER",
		"AUTOCOMBAT"
	];
}forEach units _group;
_group setBehaviour "AWARE";
_group setSpeedMode "FAST";

_this call MAI_fnc_buildSpawnGroupDespawnLoop;