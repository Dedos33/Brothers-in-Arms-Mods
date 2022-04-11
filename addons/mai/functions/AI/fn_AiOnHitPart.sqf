#include "../../script_components.hpp"
 /*
	MAI_fnc_AiOnHitPart

	Description:
		Handle AI hitting player.

	Arguments:
		0: Target	<OBJECT>
		1: Shooter	<STRING>

	Return Value:
		None

*/
(_this select 0) params ["_target", "_shooter"];

if (!local _shooter || {isPlayer _shooter}) exitWith {};

DEBUG_2("OnHitPart: Target %1, Shooter %2", _target, _shooter);

if (isPlayer _target) then {

	DEBUG_1("OnHitPart: Shooter %1, Penalty!", _shooter);

	[_shooter] call MAI_fnc_AiAimPenalty;
};

nil
