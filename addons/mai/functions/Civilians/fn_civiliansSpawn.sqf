 /*
	MAI_fnc_civiliansSpawn

	Description:
		Spawn civilians with basic "AI".

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/

params [["_logic", objNull, [objNull]]];

private _pos = getPosATL _logic;
private _distance = _logic getVariable ["distance", 150];
private _activation = _logic getVariable ["activation", 650];
private _civiliansType = _logic getVariable ["civiliansType", "altis"];
private _civiliansCount = _logic getVariable ["civiliansCount", 15];
private _unitTypes = _logic getVariable ["unitTypes", []];
private _buildings = _logic getVariable ["buildings", []];
private _executionCodeUnit = _logic getVariable ["executionCodeUnit", {}];

private _spawnedUnits = _logic getVariable ["spawnedUnits", 0];
private _unitsPerInterval = _logic getVariable ["unitsPerInterval", 1];
private _interval = _logic getVariable ["interval", 0.25];

private _spawnedNowCount = (_civiliansCount - _unitsPerInterval) min _unitsPerInterval;

// move this to cfg soon*
private _baseCivilians = [];
switch (_civiliansType) do {
    case "altis": {
		_baseCivilians = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_Man_casual_4_F","C_Man_casual_5_F","C_Man_casual_6_F","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_sport_1_F","C_man_sport_2_F","C_man_sport_3_F"];
	};
    case "workers": {
		_baseCivilians = ["C_man_w_worker_F","C_Man_UtilityWorker_01_F","C_Man_ConstructionWorker_01_Black_F","C_Man_ConstructionWorker_01_Red_F","C_Man_ConstructionWorker_01_Blue_F"];
	};
    default {};
};
{
	_unitTypes pushBack _x;
}forEach _baseCivilians;

if (_unitTypes isEqualTo []) exitWith {
	["civilians at '%1' was empty, exit script", nearestLocation [_logic, ""]] call BIS_fnc_logFormat;
};
//[_buildings, true] call CBA_fnc_shuffle;
private _allAgents = _logic getVariable ["allAgents", []];
for "_i" from 1 to _spawnedNowCount do {
	private _building = selectRandom _buildings;
	_allpositions = _building buildingPos -1;

	_spawnedUnits = _spawnedUnits + 1;
	// added BEFORE condition, so if building was somehow corrupted it won't be stuck in infinite loop.

	if !(_allpositions isEqualTo []) then
	{
		private _posSpawn = selectRandom _allpositions;
		private _randomAgentArray = selectRandom _unitTypes;
		_randomAgentArray params ["_agentType", ["_loadout", []]];
		private _agent = createAgent [_agentType, _posSpawn, [], 0, "CAN_COLLIDE"];
		if !(_loadout isEqualTo [])then {
			_agent setUnitLoadout _loadout;
		};

		_agent disableAI "FSM";
		_agent setBehaviour "CARELESS";
		_agent forceWalk true;
		_allAgents pushBack _agent;
		_agent setVariable ["logic", _logic];

		// eventhandler for civilians to panic
		private _ehFiredNear = _agent addEventHandler ["FiredNear",
		{
			params ["_agent"];
			_agent forceWalk false;
			doStop _agent;
			switch(round(random 2))do{
				case 0:{ [_agent,"ApanPercMstpSnonWnonDnon_G01"] remoteExec ["switchMove", 0]};
				case 1:{_agent playMoveNow "ApanPknlMstpSnonWnonDnon_G01"};
				case 2:{_agent playMoveNow "ApanPpneMstpSnonWnonDnon_G01"};
				default{_agent playMoveNow "ApanPknlMstpSnonWnonDnon_G01"};
			};
			_agent forceSpeed (_agent getSpeed "FAST");
			_agent setVariable ["AI_panicTime", time];
			[_agent] call MAI_fnc_civiliansAiMove;

			private _ehFiredNear = _agent getVariable ["ehFiredNear", 0];
			_agent removeEventHandler ["FiredNear", _ehFiredNear];
		}];
		[_agent] call MAI_fnc_civiliansAiMove;
		_agent setVariable ["ehFiredNear", _ehFiredNear];

		[_agent] call _executionCodeUnit;

		private _addToZeus = _logic getVariable ["addToZeus", false];
		if (_addToZeus) then {
			{
				[_x, [[_agent], true]] remoteExecCall ["addCuratorEditableObjects", 2, false];
			}forEach allCurators;
		};
	};
};

_logic setVariable ["allAgents", _allAgents];
_logic setVariable ["spawnedUnits", _spawnedUnits];

if (_spawnedUnits >= _civiliansCount) then {
	[_logic] call MAI_fnc_civiliansLoop;
}else {
	[
		{
			_this call MAI_fnc_civiliansSpawn;
		},
		_this,
		_interval
	] call CBA_fnc_waitAndExecute;
};

Nil