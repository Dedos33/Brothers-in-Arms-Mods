 /*
	MAI_fnc_reinforceVehAI

	Description:
		Simple "AI" for vehicle to respond to events on the way to destination.

*/

params ["_veh", "_GroupVeh", "_GroupCargo", "_destination", "_despawn", "_distance", "_vehStartPos"];
if (!alive _veh) exitWith {};
if (!canMove _veh) exitWith {
	_this call MAI_fnc_reinforceUnload;
};
private _destinationDistance = _veh distance _destination;
//systemChat str _destinationDistance;
if (_destinationDistance <= _distance) exitWith {
	_this call MAI_fnc_reinforceUnload;
};
private _leader = leader _GroupVeh;
private _enemy = _leader findNearestEnemy _leader;
if (isNull _enemy) exitWith {
	[
		{_this call MAI_fnc_reinforceVehAI},
		_this,
		1 + random 2
	]call CBA_fnc_waitAndExecute;
};

private _enemyPos = getposATL _enemy;
private _enemyDistance = _veh distance _enemyPos;
if (_enemyDistance < 250) exitWith
{
	_this call MAI_fnc_reinforceUnload;
};
if (_enemyDistance < 350 && {speed _veh < 0.1}) exitWith {
	_this call MAI_fnc_reinforceUnload;
};
if (_enemyDistance < 500 && {speed _veh < 0.1}) then {
	private _timesStopped = _veh getVariable ["MAI_timesStopped",0];
	_timesStopped = _timesStopped + 1;
	if (_timesStopped > 3) then {
		_this call MAI_fnc_reinforceUnload;
	};
	_veh setVariable ["MAI_timesStopped",_timesStopped];
};
[
	{_this call MAI_fnc_reinforceVehAI},
	_this,
	1 + random 2
]call CBA_fnc_waitAndExecute;