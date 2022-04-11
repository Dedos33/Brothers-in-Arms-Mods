 /*
	MadinAI_fnc_AiRestoreMagazines

	Description:
		 Unit AI loop, can be switch on/off mid game in CBA settings

	Arguments:
		0: Group <GROUP>

	Return Value:
		None

*/

params [["_unit",objNull,[objNull]]];
if (_unit isEqualTo objNull)exitWith {};

private _deletedMags = _unit getVariable ["MAI_deletedMags",[]];
if (_deletedMags isEqualTo [])exitWith {};
_unit setVariable ["MAI_deletedMags",nil];

{
	_x params ["_class","_ammoLeft","_loaded","_weaponType","_location"];
	if (_loaded) then {
		switch (_weaponType) do {
		//(-1 - n/a, 0 - grenade, 1 - primary mag, 2 - handgun mag, 4 - secondary mag, 65536 - vehicle mag) 
			case 1: {
				private _primaryWeapon = primaryWeapon _unit;
				if !(_primaryWeapon isEqualTo "") then {
					_unit removePrimaryWeaponItem _class;
					_unit addWeaponItem [_primaryWeapon,[_class, _ammoLeft],true];
				};
			};
			case 2: {
				private _handgun = handgunWeapon _unit;
				if !(_handgun isEqualTo "") then {
					_unit removePrimaryWeaponItem _class;
					_unit addWeaponItem [_handgun,[_class, _ammoLeft],true];
				};
			};
			default {
				/*
				arma don't support "addMagazine this amount to this vest/backpack",
				so ignore where it will go.

				switch (_condition) do {
					case "Uniform": {_class addItemToBackpack};
					case "Vest": { hint "2" };
					default "Backpack" { hint "default" };
				};
				*/
				_unit addMagazine [_class, _ammoLeft];
			};
		};
	}else
	{
		_unit addMagazine [_class, _ammoLeft];
	}
}forEach _deletedMags;