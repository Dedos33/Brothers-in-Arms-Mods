 /*
	MadinAI_fnc_civiliansSpawn

	Description:
		Initiate civilians, waitUntil condition meet

	Arguments:
		0: Logic <OBJECT>

	Return Value:
		None

*/

//[format ["isServer - %1 / civiliansSpawn",isServer]] remoteExecCall ["systemChat",0];
params [["_logic",objNull,[objNull]]];

private _pos = getPosATL _logic;
private _distance = _logic getVariable ["distance",150];
private _activation = _logic getVariable ["activation",650];
private _civiliansType = _logic getVariable ["civiliansType","altis"];
//systemChat str _civiliansType;
private _civiliansCount = _logic getVariable ["civiliansCount",15];
private _unitTypes = _logic getVariable ["unitTypes",[]];
private _buildings = _logic getVariable ["buildings",[]];
private _executionCodeUnit = _logic getVariable ["executionCodeUnit",{}];

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

if (_unitsType isEqualTo []) exitWith {
	["civilians at '%1' was empty, exit script", nearestLocation [_logic, ""]] call BIS_fnc_logFormat;
};
[_buildings] call CBA_fnc_shuffle;
private _spawned = 0;
private _allAgents = [];
{
	if (_spawned >= _civiliansCount)exitWith{};

	_allpositions = _x buildingPos -1;
	if ((count _allpositions) > 0)then
	{
		private _posSpawn = selectRandom _allpositions;
		private _randomAgentArray = selectRandom _unitTypes;
		_randomAgentArray params ["_agentType",["_loadout",[]]];
		private _agent = createAgent [_agentType, _posSpawn, [], 0, "CAN_COLLIDE"];
		if !(_loadout isEqualTo [])then{
			_agent setUnitLoadout _loadout;
		};

		_agent disableAI "FSM";
		_agent setBehaviour "CARELESS";
		_agent forceWalk true;
		_allAgents pushBackUnique _agent;
		_spawned = _spawned + 1;
		_agent setVariable ["logic",_logic];

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
			_agent setVariable ["AI_panicTime",time];
			[_agent] call MadinAI_fnc_civiliansAiMove;

			private _ehFiredNear = _agent getVariable ["ehFiredNear",0];
			_agent removeEventHandler ["FiredNear", _ehFiredNear];
		}];
		[_agent] call MadinAI_fnc_civiliansAiMove;
		_agent setVariable ["ehFiredNear", _ehFiredNear];

		[_agent] call _executionCodeUnit;
	};
}forEach _buildings;

private _addToZeus = _logic getVariable ["addToZeus",false];
if (_addToZeus)then{
	{
		[_x, [_allAgents, true]] remoteExecCall ["addCuratorEditableObjects",2,false];
	}forEach allCurators;
};

_logic setVariable ["allAgents",_allAgents];

[_logic] call MadinAI_fnc_civiliansLoop;