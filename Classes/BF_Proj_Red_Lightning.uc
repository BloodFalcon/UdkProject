class BF_Proj_Red_Lightning extends BF_Proj_Base;

var ParticleSystemComponent Beam;

simulated event PostBeginPlay()
{
	Beam = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'BloodFalcon.ParticleSystem.AbsorbBeam_Particle', Location, Rotation, self );
	Beam.SetVectorParameter('LinkBeamEnd', (Location + vect(0,-750,0)));
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{

	if (Other != Instigator)
	{
		if (!Other.bStatic && DamageRadius == 0.0)
		{
			Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		}
		Explode(HitLocation, HitNormal);
	}
}


defaultproperties
{
	Speed=5000
	ProjFlightTemplate=ParticleSystem'BloodFalcon.ParticleSystem.Absorb'
	LifeSpan=0.25
	DrawScale=2
	Damage=2

    Begin Object name=MyMesh
        StaticMesh=StaticMesh'WP_ShockRifle.Mesh.S_Sphere_Good'
		HiddenGame=true
    End Object
    Components.Add(MyMesh)
}