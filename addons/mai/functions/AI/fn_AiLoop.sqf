 /*
	MAI_fnc_AiLoop

	Description:
		Main AI loop, can be switch on/off mid game in CBA settings.
		Calls this much groups to calculate AI / PTSD etc.

	Arguments:
		0: Group						<GROUP>
		0: Number of groups per frame	<NUMBER>

	Return Value:
		None

*/

params [["_allGroups",[],[[]]],["_groupsPerFrame",0,[0]]];
private _groupsLeft = _groupsPerFrame;
while {_groupsLeft > 0} do
{
	_groupsLeft = _groupsLeft - 1;
	private _group = _allGroups deleteAt 0;
	[_group] call MAI_fnc_AiGroupLoop;
	if (_allGroups isEqualTo []) exitWith {
		[
			{
				call MAI_fnc_AiLoopStart;
			},
			[],
			0
		] call CBA_fnc_waitAndExecute;
	};
};
if !(_allGroups isEqualTo []) then {
	[
		{
			_this call MAI_fnc_AiLoop;
		},
		[_allGroups,_groupsPerFrame],
		0
	] call CBA_fnc_waitAndExecute;
};

Nil