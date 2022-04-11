 /*
	MAI_fnc_playerInit

	Description:
		Init functions for players.
		Called post init.

	Arguments:
		None

	Return Value:
		None

*/

if (!hasInterface) exitWith {};
MAI_defaultCamoCoef = player getUnitTrait "camouflageCoef";
call MAI_fnc_playerCamoCoef;