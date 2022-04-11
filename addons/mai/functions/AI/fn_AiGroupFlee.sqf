 /*
	MAI_fnc_AiGroupFlee

	Description:
		Ai flee when under heavy fire (PTSD).

	Arguments:
		0: Group	<GROUP>

	Return Value:
		None

*/

params [["_group",grpNull,[grpNull]]];
private _flee = _group getVariable ["MAI_flee",false];
if (_flee) exitWith {false};

private _leader = leader _group;
_group setVariable ["MAI_flee",true];
_group setVariable ["MAI_groupAiTime",time + random [60,90,120]];

[_group] call MAI_fnc_AiPTSDamnesia;

{
	_x setFatigue 0;
	_x disableAi "FSM";
}forEach (units _group);
[
	{
		params [["_group",grpNull]];
		if (_group isEqualTo grpNull) exitWith {};
		{
			_x enableAI "FSM";
			_x doFollow leader _x;
		}forEach (units _group);
	},
	[_group],
	45 + random 15
]call CBA_fnc_waitAndExecute;

private _danger = _leader findNearestEnemy _leader;
private _runDir = 0;
if !(_danger isEqualTo objNull) then {
	_runDir = _danger getDir _leader;
}else
{
	_runDir = 180 + getDir _leader
};
private _runPosBuildings = _leader getPos [35,_runDir];
private _buildingFound = [_group, _runPosBuildings, 75] call MAI_fnc_AiGroupMoveToBuilding;
if (_buildingFound) exitWith {};
// if there is no nearby buildings, run in oposite direction to danger

private _runPos = _leader getPos [MAI_PTSDfleeDistance,_runDir];
_buildingFound = [_group, _runPos, 100] call MAI_fnc_AiGroupMoveToBuilding;
if (_buildingFound) exitWith {};
if (surfaceIsWater _runPos) exitWith {};
{_x doFollow leader _x}forEach units _group;
_group addWaypoint [_runPos,3,0];

Nil