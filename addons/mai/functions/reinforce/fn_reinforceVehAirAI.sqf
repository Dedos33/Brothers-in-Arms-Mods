 /*
	MAI_fnc_reinforceVehAirAI

	Description:
		Simple "AI" for vehicle to respond to events on the way to destination.

*/

params ["_veh", "_GroupVeh", "_GroupCargo", "_destination", "_despawn", "_distance", "_vehStartPos"];
if (!alive _veh) exitWith {};

[_GroupCargo, _destination, 100, 6, true] call MAI_fnc_patrolRandomWaypoints;
{
	if (waypointType _x isEqualTo "TR UNLOAD") exitWith {
		private _ehID = _veh  addEventHandler ["GetOut", {
			params ["_vehicle", "_role", "_unit", "_turret"];
			if (_role isEqualTo "cargo") then {
				private _ehID = _vehicle getVariable ["MAI_ehGetOutID", -1];
				_vehicle removeEventHandler ["GetOut", _ehID];

				private _crew = fullCrew [_vehicle, "cargo", false];
				private _cargoUnits = [];
				{
					_cargoUnits pushBack (_x select 0);
				} forEach _crew;
				[_cargoUnits, _vehicle] call MAI_fnc_reinforceUnloadUnits;
			};
		}];
		_veh setVariable ["MAI_ehGetOutID", _ehID];
	};
}forEach waypoints _GroupVeh;
