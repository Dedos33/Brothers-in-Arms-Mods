#include "../../script_components.hpp"
/*
	MadinAI_fnc_AiOnReloaded

	Description:
		Handle AI reload.

	Arguments:
		0: Unit			<OBJECT>
		1: Weapon		<STRING>
		2: Muzzle		<STRING>
		3: Magazine		<STRING>
		4: Old Magazine	<STRING>

	Return Value:
		None

*/
params ["_unit"];

if (!local _unit || {isPlayer _unit}) exitWith {};

DEBUG_1("OnReload: Reload %1", _unit);

if (MAI_AiBonusMags >= random 100) then {

	DEBUG_1("OnReload: Bonus mag %1", _unit);

	private _deletedMags = _unit getVariable ["MAI_deletedMags", []];
	// do not restore mags if unit has them temprarily removed (eg. shooting RPG)
	if !(_deletedMags isEqualTo []) exitWith {};

	[
		{
			params ["_unit", "", "", "", "_oldMagazine"];
			_unit addMagazine (_oldMagazine select 0);
		},
		_this,
		1 + random 1
		// i encouter some bugs/weird behaviour on instant mag add
	] call CBA_fnc_waitAndExecute;
};

nil
