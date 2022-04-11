#include "../../script_components.hpp"
 /*
	MAI_fnc_AiOnKilled

	Description:
		Handles AI death.

	Arguments:
		0: Target	<OBJECT>
		1: Killer	<STRING>

	Return Value:
		None

*/
params ["_unit", "_killer"];

private _group = group _unit;

if (!(_group getVariable ["MAI_enable", true]) || {!local _unit || {isPlayer _unit}}) exitWith {};

DEBUG_2("OnKilled: Ai %1 Killer %2", _unit, _killer);

private _currentPTSD = _group getVariable ["MAI_PTSD", 0];
private _PTSDfactor = _group getVariable ["MAI_PTSDfactor", 1];
private _newPTSD = _currentPTSD +  MAI_PTSDkilled + MAI_PTSDkilled / (count units _group + 1);

_group setVariable ["MAI_PTSD", _newPTSD];

nil
