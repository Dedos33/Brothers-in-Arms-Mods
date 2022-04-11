private _isOnFoot = isNull objectParent player;
if (_isOnFoot) then {
	private _mapObjects = nearestTerrainObjects [player, ["Tree","Bush"], MAI_camoObjDistance];
	private _numberObjects = count _mapObjects;
	private _camoCoef = MAI_defaultCamoCoef - (_numberObjects * MAI_camoCoefFactor)*0.01;
	player setUnitTrait ["camouflageCoef",_camoCoef];
}else
{
	player setUnitTrait ["camouflageCoef",MAI_defaultCamoCoef];
};
[
	{
		call MadinAI_fnc_playerCamoCoef;
	},
	[],
	5
]call CBA_fnc_waitUntilAndExecute;