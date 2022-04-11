 /*
	MAI_fnc_civiliansLoop

	Description:
		Initiate civilians main loop.

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/

params [["_logic",objNull]];
if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MAI_fnc_civiliansLoop] logic is objNull, exit sctipt"
};
private _activation = _logic getVariable ["activation",1000];
private _deActivation = _logic getVariable ["deActivation",1000];

// find if there are players nearby. If not, wait until they are.
private _nearUnits = _logic nearEntities ["AllVehicles", _activation + _deActivation];
if !((_nearUnits findIf {isPlayer _x && {alive _x}}) isEqualTo -1) exitWith{
	[{
		_this call MAI_fnc_civiliansLoop;
		},
		_this,
		random [4,5,6]
	] call CBA_fnc_waitAndExecute;
};

// delete civilians when there are no players near 
_allAgents = _logic getVariable ["allAgents",[]];
{
	deleteVehicle _x;
}forEach _allAgents;
_logic setVariable ["spawnedUnits", nil];

[_logic] call MAI_fnc_civiliansWaitUntil;

Nil