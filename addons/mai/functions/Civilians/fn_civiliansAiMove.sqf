 /*
	MAI_fnc_civiliansAiMove

	Description:
		"AI" for civilians to move / hide under fire.

	Arguments:
		0: _agent <OBJECT>

	Return Value:
		None

*/

params [["_agent",objNull,[objNull]]];
if (!alive _agent) exitWith {Nil};

private _logic = _agent getVariable ["logic",objNull];
private _buildings = _logic getVariable ["buildings",[]];
if (_building isEqualTo [])exitWith {};

private _building = (selectRandom _buildings);
_allpositions = _building buildingPos -1;
if ((count _allpositions) > 0) then
{
	_pos = selectRandom _allpositions;
	_agent moveTo _pos;
}else
{
	_agent moveTo getPosATL _building;
};

private _panicTime = _agent getVariable ["AI_panicTime",-1];
private _AiInterval = random [60,90,150];

if (_panicTime >= 0) then {
	_AiInterval = random [90,240,360];
};
[
	{_this call MAI_fnc_civiliansAiMove},
	_this,
	_AiInterval
] call CBA_fnc_waitAndExecute;

Nil