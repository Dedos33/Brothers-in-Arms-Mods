 /*
	MadinAI_fnc_AiGroupCombat

	Description:
		Group AI loop, can be switch on/off mid game in CBA settings

	Arguments:
		0: Group <GROUP>

	Return Value:
		None

*/

params [["_group",grpNull,[grpNull]]];

private _leader = leader _group;
if (vehicle _leader isKindOf "AIR")exitWith {};

private _danger = _leader findNearestEnemy _leader;
private _units = units _group;
private _isInfantry = (vehicle _leader) == _leader;

// suppress and other unit specific scripts
[
	{
		[_this] call MadinAi_fnc_AiUnits},
	_units,
	0
] call CBA_fnc_waitAndExecute;

private _groupAiTime = _group getVariable ["MAI_groupAiTime",-1];
if (_groupAiTime > time)exitWith {};
_group setVariable ["MAI_groupAiTime",time + random [60,90,120]];
_group setVariable ["MAI_flee",nil];

// hide group when under fire, but enemy pos is unknown
if (isNull _danger) exitWith
{
	if (_isInfantry) then
	{
		[_group,getposATL _leader, 50] call MadinAI_fnc_AiGroupMoveToBuilding;
	};
};

// what to do when tank was spotted
if ((vehicle _danger) isKindOf "tank")exitWith
{
	// hide units when tank was spotted near
	if (_isInfantry) exitWith
	{
		[_group,getposATL _leader, 50] call MadinAI_fnc_AiGroupMoveToBuilding;
	};
	if !(vehicle _leader isKindOf "tank")exitWith
	{
		// something
	};
};

private _leader = leader _group;
if (!alive _leader)exitWith {};

private _distanceToEnemy = _leader distance _danger;

if !(_isInfantry) exitWith{
	private _dangerDir = _leader getDir _danger;
	private _movePosCenter = _leader getPos [_distanceToEnemy/3,_dangerDir];

	private _randomPos = [[[_movePosCenter, _distanceToEnemy/3]],[]] call BIS_fnc_randomPos;
	if (_randomPos isEqualTo [0,0])exitWith {};

	private _veh = vehicle _leader;
	_veh engineOn true;
	
	{_x doFollow leader _x}forEach _units;
	private _wp = _group addWaypoint [_randomPos, 0, 0];
	_wp setWaypointCompletionRadius 10;
};

// find nearby static veapons/vehicle with weapons to enter
[_group,_danger] call MadinAi_fnc_AigroupFindGun;

// check if units can edit its waypoints
private _editWaypoints = _group getVariable ["MAI_editWaypoints",true];
if (!_editWaypoints && {!(waypoints _group isEqualTo [])})exitWith {};

_group setVariable ["MAI_editWaypoints",nil];
 while {(count (waypoints _group)) > 0} do
 {
  deleteWaypoint ((waypoints _group) select 0);
 };

private _PTSD = _group getVariable ["MAI_PTSD",0];
if (_PTSD >= MAI_PTSDstopMove) exitWith {};

private _moveDistance = _group getVariable ["MAI_moveDistance",MAI_moveDistance];
private _PTSDfactor = _group getVariable ["MAI_PTSDfactor",1];
private _moveDistance = (_moveDistance - _PTSD * 2) * _PTSDfactor;

if (_distanceToEnemy < _moveDistance) then
{
	private _dir = _leader getDir _danger;
	private _halfDistance = _leader getRelPos [_distanceToEnemy/2, _dir];
	//_group addWaypoint [position _danger, 10];
	private _enemyPos = getPosATL _danger;
	private _buildingsFound = [_group,_enemyPos, 100] call MadinAI_fnc_AiGroupMoveToBuilding;
	if !(_buildingsFound) then{
		private _runDir = _leader getDir _danger;
		private _wantedPos = _leader getPos [_distanceToEnemy / 4, _runDir];
		private _mapObjects = nearestTerrainObjects [_wantedPos, ["TREE","BUSH","HIDE","ROCK"], (50 + _distanceToEnemy / 5) min 150];
		if (_mapObjects isEqualTo [])exitWith {};
		private _movePos = getposATL (selectRandom _mapObjects);
		{_x doFollow leader _x}forEach _units;
		_group addWaypoint [_movePos, 0, 0];
	};
}else
{
	[_group,getposATL _leader, 50] call MadinAI_fnc_AiGroupMoveToBuilding;
};