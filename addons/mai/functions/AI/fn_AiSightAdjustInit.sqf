 /*
	MAI_fnc_AiSightAdjustInit

	Description:
		Adjust AI sight distance by reducing it for each obstacle in it's surroundings.
		Calculate how much wait between each bot to fit every bot check in under ~5s.

	Arguments:
		None

	Return Value:
		None
		

*/

private _units = [];
{
	if (local _x && {!isPlayer _x})then {
		_units pushBack _x;
	};
}forEach allUnits;
if (_units isEqualTo [])then {
	[
		{call MAI_fnc_AiSightAdjustInit},
		[],
		10
	]call CBA_fnc_waitAndExecute;
	false
}else{
	private _wait = 5 / count _units;
	[_units,_wait] call MAI_fnc_AiSightAdjust;
	true
};

Nil