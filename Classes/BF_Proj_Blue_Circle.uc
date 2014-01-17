/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Default player projectile.
// Behavior: Straight-shot basic projectile.
***************************************/

class BF_Proj_Blue_Circle extends BF_Proj_PlayerBase;


defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Blue_Circle'
	DrawScale=1
	Damage=5
}
