 /*
	MadinAI_fnc_AiSightAdjustInit

	Description:
		yes

	Arguments:
		None

	Return Value:
		

*/

private _units = [];
{
	if (local _x && {!isPlayer _x})then{
		_units pushBack _x;
	};
}forEach allUnits;
if (_units isEqualTo [])then {
	[
		{call MadinAI_fnc_AiSightAdjustInit},
		[],
		10
	]call CBA_fnc_waitAndExecute;
	false
}else{
	private _wait = 5 / count _units;
	[_units,_wait] call MadinAI_fnc_AiSightAdjust;
	true
};