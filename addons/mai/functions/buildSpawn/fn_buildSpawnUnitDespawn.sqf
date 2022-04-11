 /*
	MAI_fnc_buildSpawnUnitDespawn

	Description:
		Despawn unit that was spawned when player goes nerby building, but goes away from it.

	Arguments:
		0: Unit							<OBJECT>
		1: Logic						<OBJECT>
		2: Spawned from this building	<OBJECT>
		3: Spawn positions of building	<ARRAY>
		4: Spawn tickets left			<NUMBER>

	Return Value:
		None

*/

params [["_units",[]],["_logic",objNull],"_building", "_buildingPositons", "_limit"];

if (_units findIf {alive _x} isEqualTo -1) exitWith {};
if !(_units findIf {_x getVariable ["MAI_isMoving", false]} isEqualTo -1) exitWith {};
if (_logic isEqualTo objNull) exitWith {};

private _minDist = _logic getVariable ["minDist",35];
_nearplayers = _building nearEntities ["allVehicles", _minDist + 7.5];
_player = _nearplayers findIf {isPlayer _x && {alive _x}};
if (_player isEqualTo -1) then {
	//despawn, add building to array
	private _tickets = _logic getVariable ["tickets",0];
	{
		if (alive _x) then {
			deleteVehicle _x;
			_tickets = _tickets + 1;
		};
	}forEach _units;
	private _spawnbuildings = _logic getVariable ["spawnbuildings", []];
	_spawnbuildings pushBack [_building, _buildingPositons, _limit, true];
	_logic setVariable ["spawnbuildings", _spawnbuildings];
	 _logic setVariable ["tickets", _tickets];
	 private _active = _logic getVariable ["active", true];
	 if !(_active) then {
		 [_logic] call MAI_fnc_buildSpawnLoop;
	 };
}else{
	// players nearby
	[
		{
			_this call MAI_fnc_buildSpawnUnitDespawn;
		},
		_this,
		4 + random 1
	]call CBA_fnc_waitAndExecute;
};

Nil