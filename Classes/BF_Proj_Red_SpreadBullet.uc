class BF_Proj_Red_SpreadBullet extends BF_Proj_PlayerBase;

function tick(float DeltaTime)
{
	Damage=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.BulletDamage;
	Velocity.Y=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.BulletSpeed.Y;
	super.tick(DeltaTime);
}

defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Red_Circle'
	DrawScale=1
	Damage=1
}
