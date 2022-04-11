 /*
	MadinAI_fnc_buildSpawnInit

	Description:
		Initiate buildSpawn on server, then wait until condition meet

	Arguments:
		0: Logic <OBJECT>
		1: Trigger activated <BOLEAN>
		2: Placed by curator <BOLEAN>

	Return Value:
		None

*/
if (!isServer) exitWith {
	diag_log text "[MadinAI_fnc_buildSpawnInit] script intended to be only used on server, exit.";
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

private _minDist = _logic getVariable ["minDist",35];
private _limit = _logic getVariable ["limit",2];

[_this, _unitsSync, _activationTriggers, _minDist, _limit] call BIS_fnc_log;

if (_unitsSync isEqualTo []) exitWith {
	(format ["[%1] BUILDSPAWN - No units synchronized!", _logic]) call BIS_fnc_error;
};

// do przeniesiena do cfg
private _knownBuildings = [
	["Land_House_L_6_EP1",[[[4,0,-1.4],0]]],
	["Land_House_L_7_EP1",[[[-4,-6,-0.7],0],[[5,3,0],0]]],
	["Land_House_L_4_EP1",[[[3,1,-1],0],[[-3.5,0,-1.3],0]]],
	["Land_House_L_8_EP1",[[[4.3,3.5,-0.5],0],[[3.7,3.5,1.8],0]]],
	["Land_House_K_8_EP1",[[[-2,1,3.5],0],[[3,-1,0.3],0]]],
	["Land_House_K_1_EP1",[[[3.7,2,1.5],0],[[-3.4,2,1.5],180]]],
	["Land_House_K_6_EP1",[[[1,3,-1.6],0],[[0.5,2.5,1.5],0],[[1.5,2,4.5],0]]],
	["Land_House_K_3_EP1",[[[1.5,-1.5,-0.8],0],[[-0.5,4.2,3],0]]],
	["Land_House_C_5_V2_EP1",[[[-3.5,1.5,-1.3],0],[[-1.3,-4.3,1.3],0]]],
	["Land_House_C_5_V3_EP1",[[[-3.5,1.5,-1.3],0],[[-1.3,-4.3,1.3],0],[[0.9,1.5,1.4],0]]],
	["Land_House_C_4_EP1",[[[5.00,4.30,-0.24],346.15],[[-0.91,-4.69,-0.23],176.36],[[-1.51,4.40,2.18],267.48]]],
	["Land_House_C_9_EP1",[[[1.68,4.79,-0.15],261.66],[[4.26,-5.14,-0.15],273.88],[[-3.13,-1.49,-0.15],250.18]]],
	["Land_House_C_12_EP1",[[[-3.08,-7.37,0.14],269.86]]],
	["Land_A_Mosque_small_1_EP1",[[[-3.10,0.96,-1.97],262.98],[[2.26,2.50,-2.05],262.98]]],
	["Land_House_K_7_EP1",[[[-0.58,1.31,3.29],183.94],[[-0.62,1.30,-0.22],349.55]]],
	["Land_House_C_5_EP1",[[[-3.26,1.34,-0.80],266.13]]],
	["Land_House_C_11_EP1",[[[7.54,0.81,1.11],269.07],[[3.23,-1.84,-2.08],281.79]]],
	["Land_House_C_10_EP1",[[[-2.46,-6.60,-0.87],257.37],[[-2.41,2.48,-0.87],256.14],[[4.06,2.21,-0.87],83.28],[[0.83,7.29,-4.17],195.43],[[1.69,-6.08,-4.18],354.51]]],
	["Land_House_C_2_EP1",[[[3.63,-0.97,0.79],163.36],[[-3.51,2.89,0.66],348.48]]],
	["Land_House_C_3_EP1",[[[-6.35,-2.44,0.58],164.50],[[0.00,-2.89,1.95],189.62],[[5.81,-2.94,-0.53],179.03],[[-6.46,3.09,0.58],342.36],[[6.43,3.24,-0.51],1.15]]],
	["Land_Mil_Barracks_EP1",[[[6.28,3.96,-1.98],180.20],[[6.01,-3.36,-1.98],356.15]]],
	["Land_i_House_Big_01_V1_F",[[[-3.06,5.43,0.86],261.03],[[3.41,-5.25,0.86],88.06],[[-2.94,1.95,-2.56],88.75],[[-1.42,-0.94,0.86],39.12]]],
	["Land_i_House_Big_02_V2_F",[[[0.33,-2.80,0.78],166.11],[[3.41,3.88,0.78],349.39]]],
	["Land_i_House_Big_01_V2_F",[[[-3.06,5.43,0.86],261.03],[[3.41,-5.25,0.86],88.06],[[-2.94,1.95,-2.56],88.75],[[-1.42,-0.94,0.86],39.12]]],
	["Land_u_House_Big_01_V1_F",[[[-2.90,1.98,-2.56],88.75],[[-0.10,-2.00,0.86],11.87]]],
	["Land_i_House_Big_02_V1_F",[[[0.21,-2.87,0.78],160.28],[[3.58,3.87,0.78],321.53]]],
	["Land_i_House_Big_01_V3_F",[[[-3.06,5.43,0.86],261.03],[[3.41,-5.25,0.86],88.06],[[-2.94,1.95,-2.56],88.75],[[-1.42,-0.94,0.86],39.12]]],
	["Land_i_House_Small_01_V3_F",[[[0.49,3.45,-1.04],263.68]]],
	["Land_u_House_Small_01_V1_F",[[[0.49,3.45,-1.04],263.68]]],
	["Land_i_House_Small_01_V2_F",[[[0.49,3.45,-1.04],263.68]]],
	["Land_i_House_Small_01_V1_F",[[[0.49,3.45,-1.04],263.68]]],
	["Land_i_Stone_HouseSmall_V3_F",[[[2.05,0.02,-0.62],43.91]]],
	["Land_i_Stone_HouseSmall_V2_F",[[[2.05,0.02,-0.62],43.91]]],
	["Land_i_Stone_HouseSmall_V1_F",[[[2.05,0.02,-0.62],43.91]]],
	["Land_i_Shop_01_V1_F",[[[0.07,5.93,1.11],355.10],[[0.39,5.93,-2.76],67.98]]],
	["Land_u_House_Big_02_V1_F",[[[3.89,4.16,-2.39],248.45],[[-0.10,-3.38,-2.39],274.79]]],
	["Land_u_Shop_01_V1_F",[[[3.14,5.97,0.99],178.93]]],
	["Land_Cargo_House_V1_F",[[[-2.01,1.03,-0.10],80.95]]],
	["Land_Cargo_House_V3_F",[[[-2.01,1.03,-0.10],80.95]]], // small cargo house
	["Land_Cargo_House_V4_F",[[[-2.01,1.03,-0.10],80.95]]], // small cargo house tanoa
	["Land_i_Shed_Ind_F",[[[-2.64,-1.11,-1.51],68.76]]],
	["Land_i_Shop_02_V3_F",[[[-3.72,3.74,-2.67],180.10]]],
	["Land_i_House_Big_02_V3_F",[[[0.30,-2.77,0.78],175.69],[[3.53,3.74,0.78],334.65]]],
	["Land_i_Shop_01_V2_F",[[[0.07,5.93,1.11],355.10],[[0.39,5.93,-2.76],67.98]]],
	["Land_Dum_olez_istan1",[[[3.79,0.98,1.37],57.25],[[5.93,-1.17,-1.84],261.10]]],
	["Land_Dum_istan3_pumpa",[[[1.04,2.93,-0.49],271.90],[[3.86,-0.61,1.47],273.60]]],
	["Land_Dum_istan3_hromada",[[[-1.66,-0.02,-3.24],242.60]]],
	["Land_Dum_istan3_hromada2",[[[0.27,1.33,-1.62],97.15],[[5.90,2.15,2.09],352.15]]],
	["Land_Cargo_HQ_V1_F",[[[3.52,1.24,-3.27],230.63],[[-2.94,3.05,-3.27],160.63]]],
	["Land_Research_house_V1_F",[[[-1.86,1.18,-0.11],106.18]]],
	["Land_MilOffices_V1_F",[[[14.30,9.57,-2.79],253.50],[[14.35,5.63,-2.79],263.50],[[8.58,-1.63,-2.79],83.50],[[-14.92,-3.12,-2.79],48.50],[[-5.77,7.13,-2.79],173.50],[[-2.26,-1.93,-2.79],338.50]]],
	["Land_i_House_Big_02_V1_F",[[[0.21,-2.87,0.78],160.28],[[3.58,3.87,0.78],321.53]]],
	["Land_i_Barracks_V2_F",[[[12.51,2.69,3.89],338.77],[[3.77,-3.28,3.89],151.22],[[-5.22,-4.54,3.89],61.22],[[0.13,3.16,3.89],356.22],[[-12.64,-3.41,0.54],146.22],[[-8.72,3.50,0.54],1.22]]],
	["Land_i_Shop_02_V2_F",[[[-3.88,3.51,-2.67],172.79]]],
	//["Land_MBG_GER_RHUS_2",[[[-0.22,-3.68,-0.47],328.02],[[3.00,2.38,-0.47],313.34],[[-2.60,-0.37,-3.37],118.70],[[-2.55,-3.74,-3.37],91.08]]],
	["Land_MBG_GER_HUS_4",[[[-4.65,-6.64,-0.11],8.71],[[-4.58,5.90,-0.11],233.58],[[2.47,3.42,-0.11],74.56],[[5.43,-1.99,-0.11],333.82],[[4.68,0.83,-3.11],258.95]]],
	["Land_HouseV2_04_interier",[[[3.46,1.21,-4.85],90.79],[[3.10,6.68,-5.74],178.67],[[-5.22,6.83,-5.74],125.06]]],
	["Land_Hag_barn_1",[[[5.18,3.27,-2.20],241.17],[[-4.18,-0.25,-2.20],61.72]]],
	["Land_Stodola_old_open",[[[1.66,10.37,-5.08],199.68],[[2.46,-10.74,-5.08],353.95],[[0.49,-5.92,-1.02],353.36],[[1.20,5.47,-0.99],176.22]]],
	["Land_HouseV2_02_Interier",[[[6.20,-0.71,-5.53],1.96],[[-8.13,-1.49,-5.53],34.55]]],
	["Land_MBG_GER_ESTATE_1",[[[7.46,-0.94,-2.13],286.54],[[7.67,6.12,-2.13],217.54],[[-1.69,6.77,-2.13],178.82],[[-7.97,6.57,-2.13],138.29],[[-7.71,-5.74,-2.13],39.32],[[7.89,-5.86,-2.13],318.08]]],
	["Land_Dum_mesto2",[[[2.48,7.22,-0.94],228.23],[[2.81,-7.01,-0.94],298.92],[[-2.69,-3.43,-0.94],58.88],[[-1.26,7.29,-0.94],130.79]]],
	["Land_MBG_GER_HUS_2",[[[-4.81,6.72,-0.11],210.21],[[-2.39,-1.95,-0.11],44.98],[[5.32,-6.17,-0.11],331.50],[[4.81,0.98,-3.11],241.95],[[5.76,-5.95,-3.11],327.51],[[5.20,6.96,-3.11],208.59],[[-4.70,-6.73,-3.11],18.97],[[-5.25,6.58,-3.11],132.78]]],
	["Land_MBG_GER_HUS_1",[[[-0.71,-4.12,-0.11],297.72],[[-2.27,4.13,-0.11],129.82],[[3.01,3.62,-0.11],144.88],[[5.97,-6.75,-0.11],317.93],[[5.70,1.00,-3.11],251.75],[[6.30,-5.94,-3.11],335.21]]],
	["Land_Warehouse_03_F",[[[6.59,-1.63,0.14],257.60],[[6.72,1.54,0.13],265.11],[[6.39,3.52,-2.36],179.13]]],
	["Land_SM_01_shed_F",[[[-1.59,-0.87,-1.67],350.83],[[-5.14,-0.85,-1.63],280.29]]],
	["Land_MBG_GER_RHUS_3",[[[2.50,-1.32,-0.47],266.98],[[-0.32,-3.76,-0.47],339.28],[[-2.69,1.73,-0.47],45.52],[[-2.56,-4.01,-3.37],88.51],[[-2.78,-0.50,-3.37],84.88]]],
	["Land_Farm_Cowshed_a",[[[9.34,-5.82,-3.09],270.06],[[-0.83,-5.98,-3.09],90.02]]],
	["Land_i_House_Small_02_V1_F",[[[1.96,-0.96,-0.71],27.00]]],
	["Land_i_House_Big_02_b_blue_F",[[[0.21,-2.87,0.78],160.28],[[3.58,3.87,0.78],321.53]]],
	["Land_i_Shop_02_V1_F",[[[-3.88,3.51,-2.67],172.79]]],
	["Land_i_House_Big_01_b_pink_F",[[[-3.06,5.43,0.86],261.03],[[3.41,-5.25,0.86],88.06],[[-2.94,1.95,-2.56],88.75],[[-1.42,-0.94,0.86],39.12]]],
	["Land_i_House_Small_01_b_pink_F",[[[0.49,3.45,-1.04],263.68]]],
	["Land_i_House_Big_02_b_whiteblue_F",[[[0.33,-2.80,0.78],166.11],[[3.41,3.88,0.78],349.39]]],
	["Land_i_House_Small_01_b_blue_F",[[[0.49,3.45,-1.04],263.68]]],
	["Land_i_House_Small_02_b_blue_F",[[[1.96,-0.96,-0.71],27.00]]],
	["Land_i_House_Big_01_b_blue_F",[[[-3.06,5.43,0.86],261.03],[[3.41,-5.25,0.86],88.06],[[-2.94,1.95,-2.56],88.75],[[-1.42,-0.94,0.86],39.12]]],
	["Land_i_Shop_02_b_whiteblue_F",[[[-3.72,3.74,-2.67],180.10]]],
	["Land_i_House_Big_01_b_yellow_F",[[[-3.06,5.43,0.86],261.03],[[3.41,-5.25,0.86],88.06],[[-2.94,1.95,-2.56],88.75],[[-1.42,-0.94,0.86],39.12]]],
	["Land_FuelStation_01_shop_F",[[[-1.73,3.36,-2.01],244.48]]],
	["Land_Supermarket_01_malden_F",[[[5.67,11.76,-1.48],265.82]]],
	["Land_i_House_Big_02_b_pink_F",[[[0.33,-2.80,0.78],166.11],[[3.41,3.88,0.78],349.39]]],
	["Land_i_House_Small_01_b_whiteblue_F",[[[0.49,3.45,-1.04],263.68]]],
	["Land_i_Shop_02_b_yellow_F",[[[-3.72,3.74,-2.67],180.10]]],
	["Land_i_House_Big_01_b_whiteblue_F",[[[-3.06,5.43,0.86],261.03],[[3.41,-5.25,0.86],88.06],[[-2.94,1.95,-2.56],88.75],[[-1.42,-0.94,0.86],39.12]]],
	["Land_i_House_Big_02_b_brown_F",[[[0.33,-2.80,0.78],166.11],[[3.41,3.88,0.78],349.39]]],

	//Jbad

	["Land_jbad_House_1",[[[3.7,2,1.5],0],[[-3.4,2,1.5],180]]],
    ["Land_jbad_House_c_2",[[[3.63,-0.97,0.79],163.36],[[-3.51,2.89,0.66],348.48]]],
    ["Land_jbad_House_c_3",[[[-6.35,-2.44,0.58],164.50],[[0.00,-2.89,1.95],189.62],[[5.81,-2.94,-0.53],179.03],[[-6.46,3.09,0.58],342.36],[[6.43,3.24,-0.51],1.15]]],
    ["Land_jbad_House_c_5_v2",[[[-3.5,1.5,-1.3],0],[[-1.3,-4.3,1.3],0]]],
    ["Land_jbad_House_c_5_v3",[[[-3.5,1.5,-1.3],0],[[-1.3,-4.3,1.3],0],[[0.9,1.5,1.4],0]]],
    ["Land_jbad_House_c_10",[[[-2.46,-6.60,-0.87],257.37],[[-2.41,2.48,-0.87],256.14],[[4.06,2.21,-0.87],83.28],[[0.83,7.29,-4.17],195.43],[[1.69,-6.08,-4.18],354.51]]],
    ["Land_jbad_House_c_11",[[[7.54,0.81,1.11],269.07],[[3.23,-1.84,-2.08],281.79]]],
    ["Land_jbad_House_c_12",[[[-3.08,-7.37,0.14],269.86]]],

	["land_ffaa_casa_af_7",[[[-2.33,-1.51,-1.47],2.95],[[2.42,1.61,-1.47],92.95],[[4.33,2.92,-1.47],287.95],[[-4.76,-3.37,-1.47],62.95]]],
	["Land_Slum_House03_F",[[[-1.78,2.08,-1.26],123.47]]],
	["Land_Slum_House02_F",[[[-0.08,0.46,-0.80],211.80]]],
	["land_ffaa_casa_af_10",[[[-0.63,0.57,3.21],97.77],[[5.59,1.37,0.24],217.77],[[-5.59,-1.62,0.24],37.77]]],
	["Land_Jbad_A_Mosque_small_1",[[[1.71,1.23,-1.98],280.29],[[1.95,3.65,-2.05],250.29]]],
	["Land_Jbad_A_Mosque_small_2",[[[1.00,-2.02,-2.40],327.74]]],
	["land_ffaa_casa_af_11",[[[-1.61,-1.79,0.73],15.39],[[1.79,-1.91,0.70],345.39],[[-1.63,-1.80,5.09],60.39]]],
	["land_ffaa_casa_af_2",[[[-2.30,-2.33,-1.70],2.89]]],
	["Land_jbad_House_3_old",[[[1.04,2.68,-0.22],140.63],[[-5.26,1.01,-0.17],140.63]]],
	["Land_jbad_House_7_old",[[[4.51,3.11,-0.26],264.56],[[-2.87,-6.36,-0.93],339.56],[[-5.49,3.58,-0.65],159.56]]],
	["Land_jbad_House3",[[[-4.45,1.66,-0.80],161.04],[[-1.95,5.87,-0.54],161.04],[[-0.29,3.51,2.82],161.04]]],
	["land_ffaa_casa_af_1",[[[0.14,-3.43,-2.87],21.71],[[-1.63,1.08,-2.87],261.71],[[-5.50,0.91,-2.87],81.71],[[2.31,1.69,-0.48],81.71],[[-1.56,1.74,-0.48],201.71],[[0.06,-0.93,-0.48],81.71]]],

	["CBA_BuildingPos",[[[0, 0, 0], 0]]]
];

// Get objects in defined area
private _area = [getPosATL _logic];
_area append (_logic getVariable ["objectarea", []]);
_area params ["_logicPos", "_a", "_b"];

private _radius = (_a max _b) * 1.415;
//systemChat format ["radius %1",_radius];
if (_radius < 10) then{
	private _text = format ["WARNING! It looks like you didn't update Build Spawn parameters after last update (location %1). You need to specify area in module Atributes > Transformation > Size", getposATL _logic];
	[_text] remoteExecCall ["systemchat",0,true];
};

private _buildings = nearestObjects [_logicPos, ["House", "CBA_BuildingPos"], _radius];
// exact area filter
_buildings = _buildings inAreaArray _area;

private _group = group (_unitsSync select 0);
private _side = side _group;
// Save loadouts of units in the group
private _unitTypes = [];
{
	//_time = time + 10;
	//waitUntil {(uniform _x) != "" || time > _time};
	_unitTypes pushBack [typeOf _x, getUnitLoadout _x];
	deleteVehicle _x;
} forEach (units _group);
deleteGroup _group;

// Find suitable buildings and save their spawn positions
private _spawnBuildings = [];
private _countPos = 0;
{
	private _building = _x;
	// Check if we have spawn position for this building type
	{
		_x params ["_buildingClass", "_positionsData"];

		if ((typeOf _building) == _buildingClass) exitWith {
			private _buildingPositons = [];
			{
				_x params ["_position", "_lookDir"];
				_buildingPositons pushBack [_building modelToWorld _position, _lookDir + getDir _building];
				_countPos = _countPos + 1;
			} forEach _positionsData;

			_spawnBuildings pushBack [_building, _buildingPositons, _limit];
		};
	} forEach _knownBuildings;
} forEach _buildings;

private _activationAdd = _logic getVariable ["activationAdd",50];
private _activation = _radius + _activationAdd;

private _location = nearestLocation [_logicPos, ""];

private _tickets = _logic getVariable ["tickets",1000];
systemChat format ["[BUILDSPAWN] %1 buildings | %2 spawners | %3 tickets | %4 activation | %5", count _spawnBuildings, _countPos, _tickets, _activation, _location];

[_logic,_activation,_unitTypes,_spawnBuildings,_side, _activationTriggers] call MadinAI_fnc_buildSpawnWaitUntil;
