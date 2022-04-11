 /*
	MAI_fnc_playerCamoCoef

	Description:
		 Dynamically adjust player camo coef depends on how much
		 obstacles like trees/bushes is around him.
		 checks every 5s. Can be enabled/disabled in CBA.

	Arguments:
		None

	Return Value:
		None

*/
if (!hasInterface) exitWith {};

if !(MAI_dynamicCamoCoef) exitWith {
	player setUnitTrait ["camouflageCoef", MAI_defaultCamoCoef];
	MAI_dynamicCamoCoefLoopActive = false;
};

MAI_dynamicCamoCoefLoopActive = true;
private _isOnFoot = isNull objectParent player;
if (_isOnFoot) then {
	private _mapObjects = nearestTerrainObjects [player, ["Tree","Bush"], MAI_camoObjDistance];
	private _numberObjects = count _mapObjects;
	private _camoCoef = (MAI_defaultCamoCoef - (_numberObjects * MAI_camoCoefFactor) * 0.1) max 0;
	player setUnitTrait ["camouflageCoef", _camoCoef];
} else {
	player setUnitTrait ["camouflageCoef", MAI_defaultCamoCoef];
};
[
	{
		call MAI_fnc_playerCamoCoef;
	},
	[],
	3
]call CBA_fnc_waitAndExecute;

Nil