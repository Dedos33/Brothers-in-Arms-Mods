 /*
	MadinAI_fnc_buildSpawnFirstState

	Description:
		Initiate buildSpawn, waitUntil condition meet

	Arguments:
		0: Unit <OBJECT>

	Return Value:
		None

*/

//systemChat "respPointInit";
params [
	["_logic",objNull,[objNull]],
	["_activated",true,[true]],
	["_isCuratorPlaced",true,[true]]
];
private _unitsSync = synchronizedObjects _logic;
if (_unitsSync isEqualTo [])exitWith {
	// logi
};
private _group = group (_unitsSync select 0);
private _side = side _group;
private _leader = leader _group;
private _leaderPos = getposATL _leader;
private _leaderDir = getDir _leader;
private _units = units _group;
private _activation = _logic getVariable ["activation",10000];
private _buildingsDistance = _logic getVariable ["buildingsDistance",8];

private _unitTypes = [];
{
	_unitTypes pushBack [typeOf _x, getUnitLoadout _x];
} forEach _units;

_nearBuildings = [];
_findNearbuildings = nearestObjects [getposATL _logic, ["House", "Building"], _buildingsDistance];//change that
{
	if (alive _x) then{
		_nearBuildings pushBack _x;
	};
}forEach _findNearbuildings;
_owner = call MadinAI_fnc_HCfind;

private _tickets = _logic getVariable ["tickets",0];
private _minDist = _logic getVariable ["minDist",35];
private _activation = _logic getVariable ["activation",10000];
private _includeAir = _logic getVariable ["includeAir",false];

private _behaviour = behaviour leader _group;
private _speed = speedMode _group;

private _waypoints = [];
private _positions = [];
if (_activation > 0) then{

	{
		private _wPos = waypointPosition _x;
		private _wType = waypointType _x;
		private _wTimeout = waypointTimeout _x;
		_waypoints pushBack [_wPos, _wType, _wTimeout];
	}forEach (waypoints _group);

	{
		_positions pushBack (getposATL _x);
		deleteVehicle _x;
	} forEach _units;
	deleteGroup _group;
	[_logic,
	_leaderPos,
	_leaderDir,
	_unitTypes,
	_side,
	_nearBuildings,
	_positions,
	_tickets,
	_minDist,
	_activation,
	_includeAir,
	_group,
	_behaviour,
	_speed,
	_waypoints
	] call MadinAI_fnc_respPointWaitUntil;
	//systemChat str _positions;
}else
{
	if !(_owner isEqualTo 2)then
	{
		_group setGroupOwner _owner;
	};
	{
		_x setVariable ["acex_headless_blacklist", true, 0];
	}forEach _units;
	[_logic,
	_leaderPos,
	_leaderDir,
	_unitTypes,
	_side,
	_nearBuildings,
	_positions,
	_tickets,
	_minDist,
	_activation,
	_includeAir,
	_group,
	_behaviour,
	_speed,
	_waypoints
	] remoteExecCall ["MadinAI_fnc_respPointFirstState",_owner,false];
};
if (_nearBuildings isEqualTo []) exitWith{};