 /*
	MAI_fnc_AiGroupFlee

	Description:
		Sets behaviour for AI when its fleeing.
		loop while unit is in "flee mode".

	Arguments:
		0: Group <GROUP>

	Return Value:
		None

*/

params [["_group",grpNull,[grpNull]]];
if (_group isEqualTo grpNull) exitWith {Nil};

private _flee = _group getVariable ["MAI_flee",false];
if !(_flee) exitWith {
	{_x doFollow leader _x}forEach units _group;
	Nil
};

{_group forgetTarget _x}forEach allPlayers;
// using allPlayers as it is much faster than allUnits. Noone cares if AI knows about other AI.
// This mod is for user experience, not bot experience.
// Loop for AI to stops firing and gtfo from the fire.
// Ai still recognize enemy in visible area, so it's much better than setting it to careless.

[
	{
		_this call MAI_fnc_AiPTSDamnesia;
	},
	[_group],
	5 + random 5
]call CBA_fnc_waitAndExecute;

Nil