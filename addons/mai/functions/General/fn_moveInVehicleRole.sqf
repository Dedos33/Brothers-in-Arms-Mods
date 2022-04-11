 /*
	MAI_fnc_moveInVehicleRole

	Description:
		

	Arguments:
		0: 
		1: 

	Return Value:
		None

*/

params [
	["_unit", objNull],
	["_vehicle", objNull],
	["_assignedRole", [""]],
	["_cargoIndex", -1]
];
if (!alive _unit || !alive _vehicle) exitWith {};
if !(isNull objectParent _unit) exitWith {}; // unit in vehicle;

private _timesTried = _unit getVariable ["timesTried", 0];
if (_timesTried >= 5) exitWith {};
_unit setVariable ["timesTried", _timesTried + 1];
private _role = toLower (_assignedRole select 0);

if (_role isEqualTo "driver") exitWith {
	_unit assignAsDriver _vehicle;
	_unit moveInDriver _vehicle;
};
if (_role isEqualTo "gunner") exitWith {
	_unit assignAsGunner [_vehicle, _assignedRole select 1];
	_unit moveInGunner [_vehicle, _assignedRole select 1];
};
if (_role isEqualTo "turret") exitWith {
	_unit assignAsTurret [_vehicle, _assignedRole select 1];
	_unit moveInTurret [_vehicle, _assignedRole select 1];
};
if (_role isEqualTo "commander") exitWith {
	_unit assignAsCommander _vehicle;
	_unit moveInCommander _vehicle;
};
if (_timesTried > 0) then {
	_unit assignAsCargo _vehicle;
	_unit moveInCargo _vehicle;
} else {
	_unit assignAsCargoIndex [_vehicle, _cargoIndex];
	_unit moveInCargo [_vehicle, _cargoIndex];
};
[
	{
		_this call MAI_fnc_moveInVehicleRole;
	},
	_this,
	1
] call CBA_fnc_waitAndExecute;


Nil