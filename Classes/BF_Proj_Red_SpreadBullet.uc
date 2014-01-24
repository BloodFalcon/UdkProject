class BF_Proj_Red_SpreadBullet extends BF_Proj_PlayerBase;

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	if (Other != Instigator)
	{
		Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		self.Destroy();	
	}
}

defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Red_Circle'
	DrawScale=1
	Damage=5
}
