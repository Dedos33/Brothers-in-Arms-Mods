 /*
	MAI_fnc_getVehicleInfo

	Description:
		

*/

params [
	["_vehicle",objNull,[objNull]]
];

if !(_vehicle isKindOf "AllVehicles" && !(typeOf _vehicle isEqualTo "Man")) exitWith {};

private _vehType = typeOf _vehicle;
private _vehPos = getPosATL _vehicle;
private _vehDir =[vectorDir _vehicle, vectorUp _vehicle];
// veh status
private _vehFuel = fuel _vehicle;
private _vehDamage = damage _vehicle;
private _vehicleHitPoints = getAllHitPointsDamage _vehicle;
_vehicleHitPoints deleteAt 1;
// vehicle skin
private _vehCustom = ([_vehicle] call BIS_fnc_getVehicleCustomization) select 0;
// ammunition
private _vehAmmo = magazinesAllTurrets vehicle player; 
{
	_x resize 3;
} forEach _vehAmmo;
_vehAmmo = _vehAmmo call BIS_fnc_consolidateArray;
// cargo items
private _weapons = weaponsItemsCargo _vehicle call BIS_fnc_consolidateArray;
private _magazines = magazinesAmmoCargo _vehicle call BIS_fnc_consolidateArray;
private _items = getItemCargo _vehicle;
private _backpacks = getBackpackCargo _vehicle;
private _cargo = [_weapons, _magazines, _items, _backpacks];

[_vehType, _vehPos, _vehDir, _vehFuel, _vehDamage, _vehicleHitPoints, _vehCustom, _vehAmmo, _cargo];