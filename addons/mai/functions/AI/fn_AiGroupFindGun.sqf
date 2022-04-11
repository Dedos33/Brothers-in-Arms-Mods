 /*
	MAI_fnc_AiGroupFindGun

	Description:
		Ai will search nearby static gun / vehicle that is facing enemy.
		One of unit from group will mount that gun.

	Arguments:
		0: Group	<GROUP>
		1: Gun		<OBJECT>	(optional)

	Return Value:
		None
*/

params [["_group",grpNull,[grpNull]],["_target",objNull,[objNull]]];
if (_group isEqualTo grpNull) exitWith {};

private _leader = leader _group;
if (!alive _leader) exitWith {};

if (_target isEqualTo objNull) then
{
	_target = _leader findNearestEnemy _leader;
};
if (_target isEqualTo objNull) exitWith {};

private _nearGuns = _leader nearEntities ["LandVehicle", 100];
[_nearGuns] call CBA_fnc_shuffle;

_units = units _group;
{
	private _lastTaken = _x getVariable ["MAi_timetaken",-1000];
	if (
		!((allTurrets _x) isEqualTo []) &&
		{((crew _x) findIf {alive _x}) == -1} &&
		{(_lastTaken + 120) < time}
	) exitWith {
		_ang = _x getRelDir _target;
		if ((_ang <= 90) || (_ang >= 270)) then
		{
			private _allunits = units _group;
			private _aliveUnit = _units findIf {(!(isFormationLeader _x) && alive _x)};
			if (_aliveUnit != -1) then
			{
				_x setVariable ["timetaken",time];
				private _unit = (_units select _aliveUnit);
				//[_unit] joinSilent grpNull;
				//(group _unit) setVariable ["MadinEnableAi", false];
				//private _wp = (group _unit) addWaypoint [position _x, 0];
				//_wp waypointAttachVehicle _x;
				//_wp setWaypointType "GETIN";
				[_unit] allowGetIn true;
				_unit assignAsGunner _x;
				[_unit] orderGetIn true;
				_unit addEventHandler ["GetInMan", {
					params ["_unit", "_role", "_vehicle", "_turret"];
					_unit assignAsGunner _vehicle;
				}];
			};
		};
	};
}forEach _nearGuns;

Nil