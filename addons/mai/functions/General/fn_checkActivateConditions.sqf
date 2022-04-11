 /*
	MAI_fnc_checkActivateConditions

	Description:
		

	Arguments:
		0: 

	Return Value:
		

*/

params [
	["_logic",objNull,[objNull]]
];

if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MAI_fnc_checkActivateConditions] logic is objNull, exit script"
};

private _forceActivate = _logic getVariable ["forceActivate", false];
private _activationTriggers = _logic getVariable ["activationTriggers",[]];
private _activateCondition = _logic getVariable ["activateCondition", {true}];
private _activation = _logic getVariable ["activation", 1000];
private _includeAir = _logic getVariable ["includeAir", false];

private _activated = false;
if (_forceActivate) then {
	if (!(_activationTriggers isEqualTo []) && (_activationTriggers select {!triggerActivated _x}) isEqualTo []) exitWith {_activated = true};
	if (call _activateCondition) exitWith {_activated = true};
	private _activateByDistance = true;
	if (_activation > 0) then {
		private _nearUnits = _logic nearEntities ["AllVehicles", _activation];
		if (_includeAir) then {
			_activateByDistance = ((_nearUnits findIf {isPlayer _x}) != -1);
		} else {
			_activateByDistance = ((_nearUnits findIf {isPlayer _x && {!(_x isKindOf "Air")}}) != -1);
		};
	};
	if (_activateByDistance) exitWith {_activated = true};
} else {
	if !((_activationTriggers select {!triggerActivated _x}) isEqualTo []) exitWith {_activated = false};
	if !(call _activateCondition) exitWith {_activated = false};
	private _activateByDistance = true;
	if (_activation > 0) then {
		private _nearUnits = _logic nearEntities ["AllVehicles", _activation];
		if (_includeAir) then {
			_activateByDistance = ((_nearUnits findIf {isPlayer _x}) != -1);
		} else {
			_activateByDistance = ((_nearUnits findIf {isPlayer _x && {!(_x isKindOf "Air")}}) != -1);
		};
	};
	if !(_activateByDistance) exitWith {_activated = false};
	_activated = true;
};

if (_activated) then {
	private _deleteTrigger = _logic getVariable ["deleteTrigger", false];
	if (_deleteTrigger) then {
		[
			{
				{deleteVehicle _x} forEach _this;
			},
			_activationTriggers,
			5
		] call CBA_fnc_waitAndExecute;
	};
};

_activated