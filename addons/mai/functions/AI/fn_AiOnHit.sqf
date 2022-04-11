#include "../../script_components.hpp"
 /*
	MAI_fnc_AiOnHitPart

	Description:
		Handles AI being HIT.

	Arguments:
		0: Target	<OBJECT>
		1: Shooter	<STRING>

	Return Value:
		None

*/
params [["_unit", objNull], "", "_damage"];

private _group = group _unit;

if (!(_group getVariable ["MAI_enable", true]) || {!local _unit || {isPlayer _unit}}) exitWith {};

DEBUG_2("OnHit: Ai %1 Source %2", _unit, _group);

// add PTSD to group on hit
private _currentPTSD = _group getVariable ["MAI_PTSD", 0];
private _PTSDfactor = _group getVariable ["MAI_PTSDfactor", 1];
private _addedPTSD = _damage * MAI_PTSDhit * _PTSDfactor;

_group setVariable ["MAI_PTSD", _currentPTSD + _addedPTSD];
_unit setSuppression 1;

Nil
