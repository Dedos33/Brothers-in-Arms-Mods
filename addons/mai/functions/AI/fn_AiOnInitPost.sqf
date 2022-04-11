#include "../../script_components.hpp"
/*
    MadinAI_fnc_AiOnInit

    Description:
        No description added yet.

    Arguments:
        0: Argument <DATATYPE>

    Return Value:
        None
*/
params [["_unit", objNull, [objNull]]];

if (!local _unit || {isPlayer _unit}) exitWith {};

DEBUG("OnInit: AI Init");

// add skill to all bots on spawn
if (MAI_AiSkillAdjust) then {

	DEBUG_1("OnInit: AI Skill adjust, %1", _unit);

	[
		{
			params [["_unit", objNull, [objNull]]];

			_unit setSkill ["aimingAccuracy", (MAI_AimingAccuracy + 2*(random MAI_randomSkill) - MAI_randomSkill)];
			_unit setSkill ["aimingShake", (MAI_aimingShake + 2*(random MAI_randomSkill) - MAI_randomSkill)];
			_unit setSkill ["spotDistance", (MAI_spotDistance + 2*(random MAI_randomSkill) - MAI_randomSkill)];
			_unit setSkill ["spotTime", (MAI_spotTime + 2*(random MAI_randomSkill) - MAI_randomSkill)];
			_unit setSkill ["courage", (MAI_courage + 2*(random MAI_randomSkill) - MAI_randomSkill)];
			_unit setSkill ["commanding", (MAI_commanding + 2*(random MAI_randomSkill) - MAI_randomSkill)];
			_unit setSkill ["aimingSpeed", (MAI_aimingSpeed + 2*(random MAI_randomSkill) - MAI_randomSkill)];
			_unit setSkill ["general", (MAI_general + 2*(random MAI_randomSkill) - MAI_randomSkill)];
			_unit setSkill ["endurance", (MAI_endurance + 2*(random MAI_randomSkill) - MAI_randomSkill)];
			_unit setSkill ["reloadSpeed", (MAI_reloadSpeed + 2*(random MAI_randomSkill) - MAI_randomSkill)];

			group _unit allowFleeing 0;
		},
		_this
	] call CBA_fnc_execNextFrame;
};

nil
