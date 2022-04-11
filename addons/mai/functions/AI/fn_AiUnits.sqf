 /*
	MadinAI_fnc_AiUnits

	Description:
		 Unit AI loop, can be switch on/off mid game in CBA settings

	Arguments:
		0: Group <GROUP>

	Return Value:
		None

*/
params [["_units",[]]];

private _unit = objNull;
while {!(_units isEqualTo [])}do {
	private _newUnit = _units deleteAt 0;
	if (alive _newUnit)exitWith {
		_unit = _newUnit;
	};
};
if (_unit isEqualTo objNull)exitWith {};

private _group = group _unit;

private _PTSDfactor = _group getVariable ["MAI_PTSDfactor",1];

private _currentSuppress = getSuppression _unit;

if (_currentSuppress > 0) then {
	private _maxSupress = _group getVariable ["MAI_maxSupress",0];
	if (_currentSuppress > _maxSupress)then {
		_group setVariable ["MAI_maxSupress",_currentSuppress];
	};
	private _lastsuppress = _unit getVariable ["MAI_lastsuppress",0];
	private _lastLoop = _group getVariable ["MAI_lastLoop",time - 1];
	private _PTSD = _group getVariable ["MAI_PTSD",0];
	_PTSD = _PTSD + MAI_PTSDsuppress * _currentSuppress * ((time - _lastLoop) * _PTSDfactor / ((count units _group / 1.5) + 1));
	//systemChat format ["AiUnit %1, suppress %2",_PTSD, _currentSuppress];
	_group setVariable ["MAI_PTSD",_PTSD max 0 min 10];

	private _suppressDifference = _lastsuppress - _currentSuppress;
	if (_suppressDifference >= 0) then
	{

		// suppress decay slower by factor set in CBA settings. Base "courage" need to be set to <0.5
		private _suppressDecay = ((1 -_PTSDfactor) + MAI_suppressFactor)min 0.9;
		private _newsuppress = _currentSuppress + _suppressDifference * _suppressDecay;
		_unit setSuppression _newsuppress;
		_unit setVariable ["MAI_lastsuppress",_newsuppress];
	}else{
		_unit setVariable ["MAI_lastsuppress",_currentSuppress];
	};
}else{
	_unit setVariable ["MAI_lastsuppress",_currentSuppress];
};

// set unit skill based on it's PTSD and suppress
{
	private _baseSkill = _unit getVariable [_x,-1];
	if (_baseSkill isEqualTo -1) then{
		_baseSkill = _unit skill _x;
		_unit setVariable [_x,_baseSkill];
	};
	///systemChat format ["%1 * %2 * (1 - %3)",_baseSkill,_PTSDfactor,_currentSuppress];
	_unit setSkill [_x, _baseSkill * _PTSDfactor * (1 - (_currentSuppress * 0.75))];
}forEach [
	"aimingAccuracy",
	"aimingShake",
	"aimingSpeed",
	"endurance",
	"courage",
	"reloadSpeed",
	"commanding",
	"general"
];
private _sightBlock = _unit getVariable ["MAI_sightBlock",0];
{
	private _baseSkill = _unit getVariable [_x,-1];
	if (_baseSkill isEqualTo -1) then{
		_baseSkill = _unit skill _x;
		_unit setVariable [_x,_baseSkill];
	};
	///systemChat format ["%1 * %2 * (1 - %3)",_baseSkill,_PTSDfactor,_currentSuppress];
	_unit setSkill [_x, (_baseSkill - _sightBlock) * _PTSDfactor * (1 - (_currentSuppress * 0.75))];
}forEach [
	"spotDistance",
	"spotTime"
];
[
	{
		[_this] call MadinAI_fnc_AiUnits
	},
	_units
]call CBA_fnc_execNextFrame;