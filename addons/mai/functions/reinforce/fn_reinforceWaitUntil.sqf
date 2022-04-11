 /*
	MAI_fnc_reinforceWaitUntil

	Description:
		Initiate vehSpawn on server, then wait until condition meet

*/
params [["_logic",objNull,[objNull]],["_activationTriggers",[],[[]]],["_modules",[],[[]]]];
if (_logic isEqualTo objNull) exitWith {
	diag_log text "[MAI_fnc_reinforceInit] module deleted, exit script.";
};
private _maxUnitsOnMap = _logic getVariable ["maxUnitsOnMap", 0];
private _expectedNewUnitsCount = missionNameSpace getVariable ["MAI_expectedNewUnitsCount", 0];

private _intervalVeh = _logic getVariable ["intervalVeh", 3];
private _lastModuleActivatedTime = missionNamespace getVariable ["MAI_lastModuleActivatedTime", -1000];

private _activateCondition = _logic getVariable ["activateCondition",{true}];
if (
	_lastModuleActivatedTime + _intervalVeh < time &&
	{(count allUnits - count allPlayers + _expectedNewUnitsCount) < _maxUnitsOnMap} &&
	{call _activateCondition} &&
	{(_activationTriggers select {!triggerActivated _x}) isEqualTo []} &&
	{(_modules select {!(_x isEqualTo objNull) && _x getVariable ["active",true]}) isEqualTo []}
) then {
	MAI_lastModuleActivatedTime = time;

	private _vehicles = _logic getVariable ["vehicles", 0];
	{
		_x  params ["_vehType", "_vehStartPos", "_vehicleDir", "_fullCrew", "_side", "_vehCustom", "_waypoints"];
		_expectedNewUnitsCount = _expectedNewUnitsCount + count _fullCrew;
	} forEach _vehicles;
	MAI_expectedNewUnitsCount = _expectedNewUnitsCount;

	["Reinforce at '%1' was activated", nearestLocation [_logic, ""]] call BIS_fnc_logFormat;
	_owner = call MAI_fnc_HCfind;
	private _params = [_logic];
	{
		private _variable = _logic getVariable [_x, 0];
		_params pushBack _variable;
	}forEach[
		"activationTriggers",
		"distance",
		"quantity",
		"minimalCrew",
		"despawn",
		"activateCondition",
		"maxUnitsOnMap",
		"executionCodeVehicle",
		"executionCodeUnit",
		"executionCodePatrol",
		"executionCodeVehicleCrew",
		"vehicles"
	];
	_params remoteExecCall ["MAI_fnc_reinforceFirstState", _owner, false];
	private _deleteTrigger = _logic getVariable ["deleteTrigger", true];
	if (_deleteTrigger) then {
		[
			{{deleteVehicle _x} forEach _this},
			_activationTriggers,
			5
		]call CBA_fnc_waitAndExecute;
	};
}else
{
	[
		{_this call MAI_fnc_reinforceWaitUntil},
		_this,
		0.5 + random 0.5
	]call CBA_fnc_waitAndExecute;
};