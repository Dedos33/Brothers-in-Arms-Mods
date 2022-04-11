 /*
	MAI_fnc_simpleSpawnInit

	Description:
		Initiate simple spawn on server, then wait until condition meet

	Arguments:
		0: Logic				<OBJECT>
		1: Trigger activated	<BOLEAN>
		2: Placed by curator	<BOLEAN>

	Return Value:
		None

*/
if (!isServer) exitWith {
	diag_log text "[MAI_fnc_buildSpawnInit] script intended to be only used on server, exit.";
};
params [
	["_logic",objNull,[objNull]],
	["_activated",true,[true]],
	["_isCuratorPlaced",true,[true]]
];

private _synchronizedObjects = synchronizedObjects _logic;

if (_synchronizedObjects isEqualTo []) exitWith {
	(format ["[%1] SIMPLE SPAWN - No units synchronized!", _logic]) call BIS_fnc_error;
};

_activationTriggers = [];
private _groupSync = [];
{
	if (_x isKindOf "EmptyDetector") then {
		_activationTriggers pushBack _x;
	}else{
		if (_x isKindOf "Man") then {
			_groupSync pushBackUnique group _x;
		}else{
			{
				_groupSync pushBackUnique group _x
			} forEach crew _x;
		};
	};
} forEach _synchronizedObjects;

_logic setVariable ["activationTriggers",_activationTriggers];

private _groupsArray = [_groupSync] call MAI_fnc_simpleSpawnGetGroups;
_groupsArray params ["_groups", "_vehiclesInfo", "_vehiclesToDelete"];
_logic setVariable ["vehiclesInfo", _vehiclesInfo];

private _deleteVehicles = _logic getVariable ["deleteVehicles", false];
if (_deleteVehicles) then {
	{deleteVehicle _x} forEach _vehiclesToDelete;
};

_logic setVariable ["groups", _groups];

[
	{_this call MAI_fnc_simpleSpawnWaitUntil},
	[_logic],
	1
]call CBA_fnc_waitAndExecute;

Nil