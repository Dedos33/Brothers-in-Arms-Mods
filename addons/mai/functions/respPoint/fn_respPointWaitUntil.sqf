 /*
	MadinAI_fnc_respPointWaitUntil

	Description:
		wait until Resp Point condition meet to start script

	Arguments:
		0: Logic <OBJECT>
		1: 

	Return Value:
		None

*/

params [
	"_logic",
	"_leaderPos",
	"_leaderDir",
	"_unitTypes",
	"_side",
	"_nearBuildings",
	["_positions",[]],
	"_tickets",
	"_minDist",
	"_activation",
	"_includeAir",
	"_group",
	"_behaviour",
	"_speed",
	"_waypoints"
];
//systemChat str "respPointWaitUntil";

private _nearUnits = _logic nearEntities ["allVehicles", _activation];
private _activate = false;

if (_includeAir) then
{
	_activate = ((_nearUnits findIf {isPlayer _x}) != -1);
}else
{
	_activate = ((_nearUnits findIf {isPlayer _x && {!(_x isKindOf "Air")}}) != -1);
};
if (_activate) then{
	_owner = call MadinAI_fnc_HCfind;
	_this remoteExecCall ["MadinAI_fnc_respPointFirstState",_owner,false];
}else
{
	[{_this call MadinAI_fnc_respPointWaitUntil},
	_this,
	random [0.9,1,1.1]
	] call CBA_fnc_waitAndExecute;
};