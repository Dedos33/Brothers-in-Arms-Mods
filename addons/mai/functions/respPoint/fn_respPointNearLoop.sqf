 /*
	MadinAI_fnc_RespPointNearLoop

	Description:
		Check if there are no units nearby to stop script

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/
params [["_logic",objNull,[objNull]],["_minDist",30,[0]]];
if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MadinAI_fnc_RespPointNearLoop] logic is objNull, exit sctipt"
};
private _tickets = _logic getVariable ["tickets",0];
if (_tickets <= 0)exitWith {};
private _nearUnits = _logic nearEntities ["allVehicles", _minDist];
private _player = _nearUnits findIf {isPlayer _x};
if (_player != -1)exitWith{
	_logic setVariable ["tickets",0];
	diag_log text "[MadinAI_fnc_RespPointNearLoop] player is too close, exit sctipt"
};
[
	{_this call MadinAi_fnc_respPointNearLoop},
	_this,
	random [0.9,1,1.1]
] call CBA_fnc_waitAndExecute;