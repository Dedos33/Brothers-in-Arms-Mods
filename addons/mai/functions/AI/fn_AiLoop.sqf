 /*
	MadinAI_fnc_AiLoop

	Description:
		Main AI loop, can be switch on/off mid game in CBA settings

	Arguments:
		None

	Return Value:
		None

*/

params [["_allGroups",[],[[]]],["_groupsPerFrame",0,[0]]];
private _groupsLeft = _groupsPerFrame;
while {_groupsLeft > 0} do
{
	_groupsLeft = _groupsLeft - 1;
	private _group = _allGroups deleteAt 0;
	[_group] call MadinAI_fnc_AiGroupLoop;
	if (_allGroups isEqualTo [])exitWith{
		[
			{
				call MadinAi_fnc_AiLoopStart;
			},
			[],
			0
		] call CBA_fnc_waitAndExecute;
	};
};
if !(_allGroups isEqualTo []) then {
	[
		{
			_this call MadinAI_fnc_AiLoop;
		},
		[_allGroups,_groupsPerFrame],
		0
	] call CBA_fnc_waitAndExecute;
};