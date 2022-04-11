 /*
	MAI_fnc_expectedNewUnitsCountReturn

	Description:
		

	Arguments:
		0: Number	<GROUP>

	Return Value:

*/
params [["_unitsCountChange", 0]];
private _expectedNewUnitsCount = missionNameSpace getVariable ["MAI_expectedNewUnitsCount", 0];
MAI_expectedNewUnitsCount = _expectedNewUnitsCount + _unitsCountChange;