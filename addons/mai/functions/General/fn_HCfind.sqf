 /*
	MAI_fnc_HCfind

	Description:
		find HC connected to server.
		returns itself if not called on server.

	Arguments:
		None

	Return Value:
		0: Headless Cliend ID, 2(server) if not connected	<NUMBER>

*/

if (!isMultiplayer) exitWith {0};
if (!isServer) exitWith {clientOwner};
private _owner = 2;
private _allHCs = entities "HeadlessClient_F";
{
	_owner = owner _x;
	if !(_owner isEqualTo 2) exitWith {};
}forEach _allHCs;
if (_owner isEqualTo 0) then {
	_owner = 2;
};
_owner