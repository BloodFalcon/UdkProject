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
	Damage=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.BulletDamage;
	Velocity=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.BulletSpeed;
	super.tick(DeltaTime);
}


defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Red_Laser'
	DrawScale=1
	Damage=5
}