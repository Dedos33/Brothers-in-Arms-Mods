 /*
	MAI_fnc_spawnAI

	Description:
		spawn AI with animation and add to ACEX blacklist.

	Arguments:
		0: Group, where unit will be added							<GROUP>
		1: Type of unit												<STRING>
		2: Position ATL												<POSITION>
		3: Direction of unit (optional)								<DIRECTION>
		4: Force unit to stand for first x seconds (optional)		<NUMBER>
		5: Use animation (optional)									<BOOL>

	Return Value:
		0: Unit <OBJECT>

*/
params ["_group","_type","_pos",["_dir",0],["_stanceTime",0,[0]],["_useAnimation",true]];
private _unit = _group createUnit [_type, _pos, [], 0, "CAN_COLLIDE"];
_unit setFormDir _dir;
_unit setDir _dir;
if (_useAnimation) then {
	[_unit,"AmovPsitMstpSrasWrflDnon_AmovPercMstpSlowWrflDnon"] remoteExec ["switchMove", 0];
};
_unit setVariable ["acex_headless_blacklist", true, 0];
{[_x,[[_unit],true]] remoteExec ["addCuratorEditableObjects", 0]} forEach allCurators;

if (_stanceTime > 0) then {
	_unit setUnitPos "UP";
	[{_this setUnitPos "Auto"},
	_unit,
	_stanceTime
	] call CBA_fnc_waitAndExecute;
};

_unit