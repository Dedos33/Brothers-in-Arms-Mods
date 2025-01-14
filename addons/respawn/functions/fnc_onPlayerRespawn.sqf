#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function handles onPlayerRespawn event.
 *
 * Arguments:
 * 0: New player unit <OBJECT>
 * 1: Old player unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, ted] call bia_respawn_fnc_onPlayerRespawn
 *
 * Public: No
 */

params ["_newUnit", "_oldUnit"];

// Restore starting loadout
[{_this setUnitLoadout GVAR(savedEquipment)}, _newUnit] call CBA_fnc_execNextFrame;

// Reset time elapsed counter
GVAR(timeElapsed) = 0;

nil
