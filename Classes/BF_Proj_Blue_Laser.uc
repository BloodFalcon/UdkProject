/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: laser projectile.
// Behavior: Straight-shot basic projectile.
***************************************/

class BF_Proj_Blue_Laser extends BF_Proj_EnemyBase;

event tick(float DeltaTime)
{
	Velocity=vect(0,0,0);
	super.Tick(DeltaTime);
}

defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Blue_Laser'
	DrawScale=1
	Damage=5
}