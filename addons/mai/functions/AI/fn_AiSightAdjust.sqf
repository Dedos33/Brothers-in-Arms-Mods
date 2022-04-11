 /*
	MadinAI_fnc_AiSightAdjust

	Description:
		yes

	Arguments:
		None

	Return Value:
		None

*/

params [["_units",[],[[]]],["_wait",0,[0]]];
if (_units isEqualTo [])exitWith {
	call MadinAI_fnc_AiSightAdjustInit
};
private _unit = _units deleteAt 0;
if (alive _unit)then{
	private _mapObjects = nearestTerrainObjects [_unit, ["Tree","Bush"], MAI_objSightDistance];
	private _numberObjects = count _mapObjects;
	private _sightBlock = _numberObjects * MAI_AiSightCoefFactor;
	_unit setVariable ["MAI_sightBlock",_sightBlock];
	if !(behaviour _unit isEqualTo "COMBAT")then
	{
		{
			private _baseSkill = _unit getVariable [_x,-1];
			if (_baseSkill isEqualTo -1) then{
				_baseSkill = _unit skill _x;
				_unit setVariable [_x,_baseSkill];
			};
				_unit setSkill [_x,_baseSkill - _sightBlock];
		}forEach [
			"spotDistance",
			"spotTime"
		];
	};
};
[
	{_this call MadinAI_fnc_AiSightAdjust},
	[_units,_wait],
	_wait
]call CBA_fnc_waitAndExecute;