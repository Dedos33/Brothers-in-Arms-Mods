#include "script_component.hpp"
/*
 * Author: veteran29
 * Adds custom button to debug console
 *
 * Arguments:
 * 0: Name <STRING, ARRAY>
 *  0: Name     <STRING>
 *  1: Tooltip <STRING
 * 1: Code to execute on button click <CODE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [["Test", "This is a button"], {hint "Button was clicked"}] call bia_debug_console_fnc_addButton
 *
 * Public: Yes
 */

params [["_name", "", ["", []]], ["_code", "", [{}]]];
_name params [["_displayName", "", [""]], ["_tooltip", "", [""]]];

GVAR(buttons) pushBack [_displayName, _tooltip, _code];

nil
