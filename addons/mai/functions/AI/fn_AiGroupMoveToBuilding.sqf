 /*
	MAI_fnc_AiGroupMoveToBuilding

	Description:
		Find empty building for AI to hide, place waypoint there.

	Arguments:
		0: Group			<GROUP>

	Return Value:
		0: Building found	<BOOLEAN>

*/

params [["_group",grpNull,[grpNull]],["_position",[0,0,0],[[],objNull]],["_distance",30,[0]]];
if (_group isEqualTo grpNull) exitWith {false};

// find buildings that AI can go inside.
private _buildings = (nearestObjects [_position, ["House", "Building"], _distance]);
if (_buildings isEqualTo []) exitWith {false};
private _interiorPositions = [];
{
	private _building = _x;
	private _buildingPositions = _building buildingPos -1;
	{
		_interiorPositions pushBack [_building, _x];
	}forEach _buildingPositions;
}forEach _buildings;

if (_interiorPositions isEqualTo []) exitWith {false};

private _firstPosASL = AGLToASL ((_interiorPositions select 0) select 1);
_group addWaypoint [_firstPosASL, -1];

_takenBuildings = [];
{
	if (_interiorPositions isEqualTo []) exitWith {};
	private _interiorPos = _interiorPositions deleteAt 0;
	_interiorPos params ["_building","_pos"];
	private _timeTaken = _building getVariable ["MAI_buildingTakenTime",-1000];
	if (time > _timeTaken + 180) then {
		_x doMove _pos;
		_x setFatigue 0;
		_x setSpeedMode "FULL";
		_takenBuildings pushBackUnique _building;
	};
}forEach units _group;

{
	_x setVariable ["MAI_buildingTakenTime",time];
}forEach _takenBuildings;

true