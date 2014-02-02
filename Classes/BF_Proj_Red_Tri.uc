/***************************************
// Author(s): Tyler Keller
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Default player projectile.
// Behavior: Straight-shot basic projectile.
***************************************/


class BF_Proj_Red_Tri extends BF_Proj_PlayerBase;

function tick(float DeltaTime)
{
	SetRotation(RotRand());
	Damage=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.BulletDamage;
	Velocity=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.BulletSpeed;
	super.tick(DeltaTime);
}

defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Red_TriCircle'
	DrawScale=3
	Damage=10
}