 /*
	MAI_fnc_AiShootRpg

	Description:
		 Force AI to shoot rocket launcher by removing all other ammo.

	Arguments:
		0: Group <GROUP>

	Return Value:
		0: Can fire <BOOLEAN>

*/

params [["_unit",objNull,[objNull]],["_launcherTime",15,[0]]];
if (isPlayer _unit) exitWith {false};

// check if allready called / variable exist.
private _fncArray = _unit getVariable ["MAI_deletedMags",[]];
if !(_fncArray isEqualTo []) exitWith {false};

private _ammoArray = secondaryWeaponMagazine _unit;
if (_ammoArray isEqualTo []) exitWith {false};
private _currentMag = _ammoArray select 0;

private _ammo = getText (configfile >> "CfgMagazines" >> _currentMag >> "ammo");
private _allowAgainstInfantry = getNumber (configfile >> "CfgAmmo" >> _ammo >> "allowAgainstInfantry");
if (_allowAgainstInfantry < 1) exitWith {false};

private _allMags = magazinesAmmoFull _unit;

// delete all mags that is not for launcher. Best way to be sure that AI will use launchers.

private _compatibileMags = [secondaryWeapon _unit] call CBA_fnc_compatibleMagazines;
private _deletedMags = [];
{
	_x params ["_class","_ammoLeft","_loaded","_weaponType","_location"];
	private _magToLauncher = _compatibileMags findIf {_x isEqualTo _class};
	if (_magToLauncher == -1) then {
		_deletedMags pushBack _x;
		_unit removeMagazines _class;
	};
}forEach _allMags;
_unit setVariable ["MAI_deletedMags",_deletedMags];

private _primaryWeapon = primaryWeapon _unit;
if !(_primaryWeapon isEqualTo "") then {
	private _primaryMag = primaryWeaponMagazine _unit;
	{
		_unit removePrimaryWeaponItem _x;
		_unit addWeaponItem [_primaryWeapon,[_x, 0],true];
	}forEach _primaryMag;
};
private _handgun = handgunWeapon _unit;
if !(_handgun isEqualTo "") then {
	private _handgunMag = handgunMagazine _unit;
	{
		_unit removePrimaryWeaponItem _x;
		_unit addWeaponItem [_handgun,[_x, 0],true];
	}forEach _handgunMag;
};

// wait time to restore "normal" AI magazines
[
	{
		params [["_unit",objNull,[objNull]]];
		_unit call MAI_fnc_AiRestoreMagazines;
	},
	[_unit],
	_launcherTime
]call CBA_fnc_waitAndExecute;
true