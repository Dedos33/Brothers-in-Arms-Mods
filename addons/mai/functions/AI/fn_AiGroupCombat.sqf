 /*
	MAI_fnc_AiGroupCombat

	Description:
		Group AI loop, can be switch on/off mid game in CBA settings

	Arguments:
		0: Group	<GROUP>

	Return Value:
		None

*/

params [["_group",grpNull,[grpNull]]];

private _leader = leader _group;
if (vehicle _leader isKindOf "AIR") exitWith {};

private _danger = _leader findNearestEnemy _leader;
private _units = units _group;
private _isInfantry = (vehicle _leader) == _leader;

// suppress and other unit specific scripts
[
	{
		[_this] call MAI_fnc_AiUnits},
	_units,
	0
] call CBA_fnc_waitAndExecute;

private _groupAiTime = _group getVariable ["MAI_groupAiTime",-1];
if (_groupAiTime > time) exitWith {};
_group setVariable ["MAI_groupAiTime",time + random [60,90,120]];
_group setVariable ["MAI_flee",nil];

// use "radio" to tell nearby units about nearest enemy
if (MAI_useRadio) then {
	[
		{
			params[["_group", grpNull]];
			if (_group isEqualTo grpNull) exitWith {};
			if !(alive leader _group) exitWith {};
			{
				private _danger = _x findNearestEnemy _x;
				if !(isNull _danger) exitWith {
					private _side = side _group;
					private _nearestUnits = nearestObjects [_x, ["MAN"], MAI_radioDistance];
					{
						if (side _x isEqualTo _side) then {
							_x reveal [_danger, 2];
						};
					}forEach _nearestUnits;
				};
			}forEach units _group;
		},
		[_group],
		3 + random 7
	]call CBA_fnc_waitAndExecute;
};

// check if bots from buildspawn are forced to stay in area
if (_group getVariable ["MAI_defendOnly", false]) exitWith {
	private _logic = _group getVariable ["MAI_logic", []];
	private _baseSpawnBuildings = _logic getVariable ["baseSpawnBuildings", []];
	if (_baseSpawnBuildings isEqualTo []) exitWith {};
	// check if group can delete waypoints
	private _editWaypoints = _group getVariable ["MAI_editWaypoints",true];
	if (!_editWaypoints && {!(waypoints _group isEqualTo [])}) exitWith {};

	_group setVariable ["MAI_editWaypoints",nil];
	while {(count (waypoints _group)) > 0} do
	{
		deleteWaypoint ((waypoints _group) select 0);
	};

	private _position = [0, 0, 0];

	if (isNull _danger) then {
		private _buildingArray = selectRandom _baseSpawnBuildings;
		_position = getposATL (_buildingArray select 0);
	} else {
		private _buildingClosest = (_baseSpawnBuildings select 0) select 0;
		private _distanceClosest = 100000;
		{
			private _distance = _x select 0 distance _danger;
			if (_distance < _distanceClosest) then {
				_buildingClosest = _x select 0;
				_distanceClosest = _distance;

			};
		} forEach _baseSpawnBuildings;
		_position = getposATL _buildingClosest;
	};
	_group addWaypoint [_position, 0, 0];
};

// hide group when under fire, but enemy pos is unknown
if (isNull _danger) exitWith
{
	if (_isInfantry) then
	{
		[_group,getposATL _leader, 50] call MAI_fnc_AiGroupMoveToBuilding;
	};
};

// what to do when tank was spotted
if ((vehicle _danger) isKindOf "tank")exitWith
{
	// hide units when tank was spotted near
	if (_isInfantry) exitWith
	{
		[_group,getposATL _leader, 50] call MAI_fnc_AiGroupMoveToBuilding;
	};
	if !(vehicle _leader isKindOf "tank")exitWith
	{
		// something
	};
};

private _leader = leader _group;
if (!alive _leader) exitWith {};

private _distanceToEnemy = _leader distance _danger;

if !(_isInfantry) exitWith {
	if !(MAI_editWaypoints) exitWith {};
	private _dangerDir = _leader getDir _danger;
	private _movePosCenter = _leader getPos [_distanceToEnemy/3,_dangerDir];

	private _randomPos = [[[_movePosCenter, _distanceToEnemy/3]],[]] call BIS_fnc_randomPos;
	if (_randomPos isEqualTo [0,0]) exitWith {};

	private _veh = vehicle _leader;
	_veh engineOn true;
	
	{_x doFollow leader _x}forEach _units;
	private _wp = _group addWaypoint [_randomPos, 0, 0];
	_wp setWaypointCompletionRadius 10;
};

// find nearby static veapons/vehicle with weapons to enter
[_group,_danger] call MAI_fnc_AigroupFindGun;

//check global if can edit its waypoints
if !(MAI_editWaypoints) exitWith {};

// check if group can edit its waypoints
private _editWaypoints = _group getVariable ["MAI_editWaypoints",true];
if (!_editWaypoints && {!(waypoints _group isEqualTo [])}) exitWith {};

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
	private _buildingsFound = [_group,_enemyPos, 100] call MAI_fnc_AiGroupMoveToBuilding;
	if !(_buildingsFound) then {
		private _runDir = _leader getDir _danger;
		private _wantedPos = _leader getPos [_distanceToEnemy / 4, _runDir];
		private _mapObjects = nearestTerrainObjects [_wantedPos, ["TREE","BUSH","HIDE","ROCK"], (50 + _distanceToEnemy / 5) min 150];
		if (_mapObjects isEqualTo []) exitWith {};
		private _movePos = getposATL (selectRandom _mapObjects);
		{_x doFollow leader _x}forEach _units;
		_group addWaypoint [_movePos, 0, 0];
	};
}else
{
	[_group,getposATL _leader, 50] call MAI_fnc_AiGroupMoveToBuilding;
};

Nil