 /*
	MadinAI_fnc_AiLoopStart

	Description:
		Server AI loop, can be switch on/off mid game in CBA settings

	Arguments:
		None

	Return Value:
		None

*/

if (MAI_AiEnable) then{
	private _allGroups = +allGroups;
	private _groupsCount = count _allGroups;
	//get how many groups per frame can be calculated, to compute every group in ~1s.
	private _groupsPerFrame = floor((count _allGroups / diag_fps)max 1);
	[_allGroups,_groupsPerFrame] call MadinAI_fnc_AiLoop;
}else{
// if switched off, check every 1s if switched on again.
	[
		{call MadinAI_fnc_AiLoopStart},
		[],
		1
	] call CBA_fnc_waitAndExecute;
}