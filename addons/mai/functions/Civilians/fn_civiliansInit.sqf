 /*
	MadinAI_fnc_civiliansInit

	Description:
		Initiate civilians on server, then wait until condition meet

	Arguments:
		0: Logic <OBJECT>
		1: Trigger activated <BOLEAN>
		2: Placed by curator <BOLEAN>

	Return Value:
		None

*/
if (!isServer) exitWith {
	diag_log text "[MadinAI_fnc_civiliansInit] script intended to be only used on server, exit.";
};
//systemChat str _this;
params [
	["_logic",objNull,[objNull]],
	["_activated",true,[true]],
	["_isCuratorPlaced",true,[true]]
];

private _synchronizedObjects = synchronizedObjects _logic;
private _activationTriggers = _synchronizedObjects select {_x isKindOf "EmptyDetector"};
private _unitsSync = _synchronizedObjects select {!(_x isKindOf "EmptyDetector")};

[_this, _unitsSync, _activationTriggers] call BIS_fnc_log;

// Get objects in defined area
private _area = [getPosATL _logic];
_area append (_logic getVariable ["objectarea", []]);
_area params ["_logicPos", "_a", "_b"];

private _radius = (_a max _b) * 1.415;
private _activationAdd = _logic getVariable ["activationAdd",650];
private _activation = _radius + _activationAdd;
private _deActivationAdd = _logic getVariable ["deActivationAdd",100];
private _deActivation = _activation + _deActivationAdd;

_logic setVariable ["activation",_activation];
_logic setVariable ["deActivation",_deActivation];

private _buildings = nearestObjects [_logicPos, ["House", "CBA_BuildingPos"], _radius];
// exact area filter
_buildings = _buildings inAreaArray _area;
_logic setVariable ["buildings",_buildings];

// Save loadouts of synchronized units
private _unitTypes = [];
{
	private _group = group _x;
	_unitTypes pushBack [typeOf _x, getUnitLoadout _x];
	deleteVehicle _x;
	deleteGroup _group;
} forEach _unitsSync;
_logic setVariable ["unitTypes",_unitTypes];
private _location = nearestLocation [getposATL _logic, ""];

[_logic] call MadinAI_fnc_civiliansWaitUntil;
