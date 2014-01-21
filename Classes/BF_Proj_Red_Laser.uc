/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Laser projectile.
// Behavior: Straight-shot basic projectile.
***************************************/


class BF_Proj_Red_Laser extends BF_Proj_PlayerBase;


function tick(float DeltaTime)
{
	Velocity = vect(0,0,0);
}


defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Red_Laser'
	DrawScale=1
	Damage=5
}