 /*
	MAI_fnc_AiAimPenalty

	Description:
		 Penalty for bots accuracy for every shot hit.
		 accuracy returns over time.

	Arguments:
		0: Unit	<OBJECT>

	Return Value:
		None

*/
if (MAI_enableAimPenalty) then
{
	params [["_unit",objNull,[objNull]]];
	
	private _oldPenaltyID = _unit getVariable ["MAI_penaltyID",-1];
	_unit removeEventHandler ["FiredMan",_oldPenaltyID];
	_unit setVariable ["MAI_aimHandler",time];
			
	private _penaltyID = _unit addEventHandler ["FiredMan",
	{
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
		private _aimHandler = _unit getVariable ["MAI_aimHandler",time];
		private _power = ((MAI_aimPenaltyTime + _aimHandler - time)* MAI_aimPenaltyStrength)min MAI_aimPenaltyMax;
		if (_power > 0) then
		{
			if (!isNull objectParent _unit) then
			{
				_power = _power / 2;
			};
			private _vel = (velocityModelSpace _projectile);
			private _f = random ((_power)*1000/((_vel select 1)+1));
			private _angle = random 360;
			_projectile setVelocityModelSpace (_vel vectorAdd [_f * sin _angle, 0,_f * cos _angle]);
		}else
		{
			private _penaltyID = _unit getVariable ["MAI_penaltyID",-1];
			_unit setVariable ["MAI_aimHandler",nil];
			_unit removeEventHandler ["FiredMan",_penaltyID];
			_unit setVariable ["MAI_penaltyID",nil];
		};
	}];
	_unit setVariable ["MAI_penaltyID",_penaltyID]; 
};

Nil