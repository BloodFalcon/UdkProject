//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Absorbtion Projectile
//////////////////////////

class BF_Proj_Absorb extends BF_Proj_Base;

var SoundCue ProjSound1;

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
	ProjSound1=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_FireCue'
}