/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Default player projectile.
// Behavior: Straight-shot basic projectile.
***************************************/


class BF_Proj_Blue_Tri extends BF_Proj_EnemyBase;


function tick(float DeltaTime)
{
	SetRotation(RotRand());
}


defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Blue_TriCircle'
	DrawScale=4
	Damage=10
}