 /*
	MadinAI_fnc_respPointFirstState

	Description:
		Initiate respawn Point, wait until condition meet

	Arguments:
		0: Logic <OBJECT>
		1: Group leader position <POS>
		2: Group leader direction <DIR>
		3: Unit types and loadouts <ARRAY>
		4: Group side <SIDE>
		5: Near allive buildings to check if destroyed <ARRAY>
		6: Starting positions of units <ARRAY>
		7: Tickets <NUMBER>
		8: Minimal distance to spawner to deactivate it <NUMBER>
		9: Activation distance <NUMBER>

	Return Value:
		None

*/
//[format ["isServer - %1 / respPointFirstState",isServer]] remoteExecCall ["systemChat",0];
params [
	"_logic",
	"_leaderPos",
	"_leaderDir",
	"_unitTypes",
	"_side",
	"_nearBuildings",
	["_positions",[]],
	"_tickets",
	"_minDist",
	"_activation",
	"_includeAir",
	"_group",
	"_behaviour",
	"_speed",
	"_waypoints"
];
//systemChat str _this;
_logic setVariable ["leaderPos",_leaderPos];
_logic setVariable ["leaderDir",_leaderDir];
_logic setVariable ["unitTypes",_unitTypes];
_logic setVariable ["nearBuildings",_nearBuildings];
_logic setVariable ["tickets",_tickets];
_logic setVariable ["minDist",_minDist];
_logic setVariable ["activation",_activation];
_logic setVariable ["includeAir",_includeAir];
_logic setVariable ["behaviour",_behaviour];
_logic setVariable ["speed",_speed];
_logic setVariable ["waypoints",_waypoints];

private _deadBuildings = false;
{
	if (!alive _x)exitWith{
		_deadBuildings = true
	}
}forEach _nearBuildings;
if (_deadBuildings) exitWith {false};

if !(_positions isEqualTo []) then{
	_group = createGroup [_side,true];
	{
		private _typeArr = _unitTypes deleteAt 0;
		_typeArr params ["_type","_loadout"];
		private _newUnit =
		[_group,
		_type,
		_x,
		_leaderDir,
		20] call MadinAI_fnc_spawnAI;
		_newUnit setUnitLoadout _loadout;
		_unitTypes pushBack _typeArr;
	}forEach _positions;
	{
		_x params ["_wPos","_wType","_wTimeout"];
		private _wp =_group addWaypoint [_wPos, 0];
		_wp setWaypointType _wType;
		_wp setWaypointTimeout _wTimeout;
	}forEach _waypoints;
	_group setSpeedMode _speed;
	_group setBehaviour _behaviour;
};
private _units = units _group;
{
	[
		{
			params [["_newUnit",objNull]];
			if (alive _newUnit) then{
				[_newUnit] call MadinAI_fnc_respPointEH;
			};
		},
		[_x],
		3
	] call CBA_fnc_waitAndExecute;
}forEach _units;

_group setVariable ["logic",_logic];
_logic setVariable ["group",_group];
[_logic,_minDist] call MadinAi_fnc_respPointNearLoop;