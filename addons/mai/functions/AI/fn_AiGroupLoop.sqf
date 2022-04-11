 /*
	MAI_fnc_AiGroupLoop

	Description:
		Group AI loop, can be switch on/off mid game in CBA settings.
		Used to reduce PTSD over time, call "Combat" functions etc.
		Called from MAI_fnc_AiLoop.

	Arguments:
		0: Group	<GROUP>

	Return Value:
		None

*/

params [["_group",grpNull,[grpNull]]];
if (_group isEqualTo grpNull) exitWith
{
	diag_log text "[MAI_fnc_AiGroupLoop] group is grpNull, exit sctipt"
};
private _leader = leader _group;
if (!local _leader) exitWith {};

private _aiEnabled = _group getVariable ["MAI_enable",true];
if (!_aiEnabled) exitWith {};

private _units = units _group;
if (_units isEqualTo []) exitWith {};

//private _aiGroupActive = _group getVariable ["AiGroupActive",false];
//if (_aiGroupActive) exitWith {};

if ((vehicle _leader) isKindOf "air") exitWith {};

private _lastLoop = _group getVariable ["MAI_lastLoop",time - 1];
private _PTSD = _group getVariable ["MAI_PTSD",0];
if (_PTSD > 0) then {
	_PTSD = (_PTSD - (time - _lastLoop)*MAI_PTSDfactor) max 0;
	//PUBLIC VARIABLE ONLY FOR TESTING PURPOSES!

	private _PTSDfactor = _group getVariable ["MAI_PTSDfactor",1];
	private _maxSupress = _group getVariable ["MAI_maxSupress",0];
	_PTSD = _PTSD + MAI_PTSDsuppress * _maxSupress * ((time - _lastLoop) * _PTSDfactor / ((count units _group / 1.5) + 1));
	_group setVariable ["MAI_maxSupress",nil];

	_group setVariable ["MAI_PTSD",_PTSD,true];
	_group setVariable ["MAI_PTSDfactor",((_PTSD + 1) ^-0.5) max 0];
	if (MAI_allowFlee && {_PTSD >= MAI_PTSDflee}) then {
		[_group] call MAI_fnc_AiGroupFlee;
	};
};
_group setVariable ["MAI_lastLoop",time];

if (behaviour _leader == "COMBAT") exitWith {
	[_group] call MAI_fnc_AiGroupCombat;
};

/*
if (behaviour _leader == "AWARE") exitWith {
	[_group] call MAI_fnc_AiGroupAware;
};
*/

Nil