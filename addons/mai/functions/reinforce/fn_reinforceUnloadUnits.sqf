 /*
	MAI_fnc_reinforceUnloadUnits

	Description:
		Force faster unload AI from cargo

*/

params [["_units",[],[[]]],["_veh",objNull]];
if (_units isEqualTo []) exitWith {};
if !(alive _veh) exitWith {};

if (speed _veh < 0.01) then {
	if (_veh isKindOf "AIR" && {getposATL _veh select 2 > 1}) exitWith {};
	private _unit = _units deleteAt 0;
	moveOut _unit;
};

[
	{_this call MAI_fnc_reinforceUnloadUnits},
	_this,
	0.25 + random 0.5
]call CBA_fnc_waitAndExecute;