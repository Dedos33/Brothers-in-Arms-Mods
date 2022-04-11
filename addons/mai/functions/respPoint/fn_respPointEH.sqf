 /*
	MadinAI_fnc_respPointEH

	Description:
		Add EventHandlers for units from respPoint script

	Arguments:
		0: Unit <OBJECT>

	Return Value:
		None

*/

params [["_unit",objNull,[objNull]]];

if (!alive _unit) exitWith {
	diag_log text "[MadinAI_fnc_respPointEH] unit is dead or objNull";
};

_unit addEventHandler ["Killed",
{
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	private _group = group _unit;
	private _logic = _group getVariable ["logic",objNull];
	if (_logic isEqualTo objNull) exitWith {nil};
	//workaround to ACE double EH killed bug
	if (_unit getVariable ["MAI_killed", false]) exitWith {nil};
	_unit setVariable ["MAI_killed", true];
	private _tickets = _logic getVariable ["tickets",0];
	private _nearBuildings = _logic getVariable ["nearBuildings",[]];
	{
		if !(alive _x) exitWith{
			_tickets = 0;
		};
	}forEach _nearBuildings;
	//systemChat str _tickets;
	if (_tickets <= 0) exitWith {};
	private _pos = getposATL _logic;
	private _dir = _logic getVariable ["leaderDir",0];
	private _movePos = _logic getVariable ["leaderPos",_pos];
	private _unitTypes = _logic getVariable ["unitTypes",[]];
	private _typeArr = _unitTypes deleteAt 0;
	_typeArr params ["_type","_loadout"];
	private _newUnit =[
	_group,
	_type,
	_pos,
	_dir,
	20] call MadinAI_fnc_spawnAI;
	_newUnit setUnitLoadout _loadout;
	_unitTypes pushBack _typeArr;
	_logic setVariable ["unitTypes",_unitTypes];
	_newUnit disableAI "FSM";

	[
		{
			params ["_newUnit","_movePos"];
			_newUnit doMove _movePos;
		},
		[_newUnit,_movePos],
		3
	] call CBA_fnc_waitAndExecute;

	[
		{
			params ["_newUnit"];
			_newUnit enableAi "FSM";
		},
		[_newUnit],
		20
	] call CBA_fnc_waitAndExecute;

	_logic setVariable ["tickets",_tickets - 1];
	[
		{
			params [["_newUnit",objNull]];
			if (alive _newUnit) then{
				[_newUnit] call MadinAI_fnc_respPointEH;
			};
		},
		[_newUnit],
		3
	] call CBA_fnc_waitAndExecute;
}];

private _group = group _unit;
private _logic = _group getVariable ["logic",objNull];
private _executionCodeUnit = _logic getVariable ["executionCodeUnit",{}];
[_unit] call _executionCodeUnit;