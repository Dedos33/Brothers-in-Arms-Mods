 /*
	MAI_fnc_createVehicleFromInfo

	Description:
		

*/

params [
	["_vehType", ""],
	["_vehPos", [0,0,0]],
	["_vehDir", [[0,0,0], [0,0,0]]],
	["_vehFuel", 1],
	["_vehDamage", 0],
	["_vehicleHitPoints", []],
	["_vehCustom", []],
	["_vehAmmo", []],
	["_cargo", []]
];
private _vehicle = createVehicle [_vehType, _vehPos, [], 0, "CAN_COLLIDE"];
_vehicle setVectorDirAndUp _vehDir;

[_vehicle, _vehCustom] call BIS_fnc_initVehicle;

_vehicle setFuel _vehFuel;
_vehicle setDamage _vehDamage;
_vehicleHitPoints params ["_hitPointsNames", "_hitPointsValues"];
{
	_vehicle setHitPointDamage [_x, _hitPointsValues select _forEachIndex, false];
} forEach _hitPointsNames;

// remove all magazines
private _allTurrets = allTurrets _vehicle; 
{ 
	private _turret = _x; 
	{ 
		_vehicle removeMagazinesTurret [_x, _turret]; 
	} forEach (_vehicle magazinesTurret _turret); 
} forEach _allTurrets;

// add saved magazines
{
	_x params ["_magazineInfo", "_magazineCount"];
	for "_i" from 1 to _magazineCount do {
		_vehicle addMagazineTurret _magazineInfo;
	};
}forEach _vehAmmo;

//remove cargo
clearItemCargoGlobal _vehicle;

// add saved cargo
_cargo params ["_weapons", "_magazines", "_items", "_backpacks"];
{
	_vehicle addWeaponWithAttachmentsCargoGlobal  _x;
} forEach _weapons;
{
	_x params ["_magazineInfo", "_magazineCount"];
	_magazineInfo params ["_magazineName", "_ammoCount"];
	_vehicle addMagazineAmmoCargo [_magazineName, _magazineCount, _ammoCount];
} forEach _magazines;
_items params ["_itemsTypes", "_itemsCount"];
{
	_vehicle addItemCargoGlobal [_x, _itemsCount select _forEachIndex];
} forEach _itemsTypes;
{[_x, [[_vehicle],true]] remoteExec ["addCuratorEditableObjects", 0]} forEach allCurators;
_vehicle