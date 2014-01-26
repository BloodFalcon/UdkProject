/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Default player projectile.
// Behavior: Straight-shot basic projectile.
***************************************/


class BF_Proj_Red_TwoShotBetty extends BF_Proj_PlayerBase;


function tick(float DeltaTime)
{
	Velocity = vect(0,-1500,0);
}


defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Red_TwoShotBetty'
	DrawScale=1
	Damage=10
}
