if (!hasInterface)exitWith {};
[
	{
		time > 1
	},
	{
		MAI_defaultCamoCoef = player getUnitTrait "camouflageCoef";
		call MadinAI_fnc_playerCamoCoef;
	},
	[]
]call CBA_fnc_waitUntilAndExecute;