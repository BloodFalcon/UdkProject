//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Base Weapon
//////////////////////////

class BF_Proj_Basic extends Projectile;

var ParticleSystemComponent ProjEffects;
var ParticleSystem ProjFlightTemplate;
var ParticleSystem ProjExplosionTemplate;
var SoundCue ProjSound1;
var bool DoNotExplodeEver;
var Weapon OurPartner;


simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SpawnFlightEffects();
	SpawnFireEffect();
}

simulated singular event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	`log("Touch");
	if ( (Other == None) || Other.bDeleteMe ) // Other just got destroyed in its touch?
		return;

	if (bIgnoreFoliageTouch && InteractiveFoliageActor(Other) != None ) // Ignore foliage if desired
		return;

	// don't allow projectiles to explode while spawning on clients
	// because if that were accurate, the projectile would've been destroyed immediately on the server
	// and therefore it wouldn't have been replicated to the client
	if ( Other.StopsProjectile(self) && (Role == ROLE_Authority || bBegunPlay) && (bBlockedByInstigator || (Other != Instigator)) )
	{
		ImpactedActor = Other;
		ProcessTouch(Other, HitLocation, HitNormal);
		ImpactedActor = None;
	}
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	`log("Process Touch");
	if (Other != Instigator)
	{
		Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
	}
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	if (Damage > 0 && DamageRadius > 0 && DoNotExplodeEver == true)
	{
		`log("Explode");
		if ( Role == ROLE_Authority )
		{
			MakeNoise(1.0);
		}
		ProjectileHurtRadius(HitLocation, HitNormal);
	}
	Destroy();
}

simulated function SpawnFlightEffects()
{
	if (WorldInfo.NetMode != NM_DedicatedServer && ProjFlightTemplate != None)
	{
		ProjEffects = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(ProjFlightTemplate);
		ProjEffects.SetAbsolute(false, false, false);
		ProjEffects.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
		ProjEffects.OnSystemFinished = MyOnParticleSystemFinished;
		ProjEffects.bUpdateComponentInTick = true;
		AttachComponent(ProjEffects);
	}
}

function SpawnFireEffect()
{
	PlaySound(ProjSound1);
}

simulated function Destroyed()
{

	if (ProjEffects != None)
	{
		DetachComponent(ProjEffects);
		WorldInfo.MyEmitterPool.OnParticleSystemFinished(ProjEffects);
		ProjEffects = None;
	}
	super.Destroyed();
}

simulated function MyOnParticleSystemFinished(ParticleSystemComponent PSC)
{
	if (PSC == ProjEffects)
	{
		DetachComponent(ProjEffects);
		WorldInfo.MyEmitterPool.OnParticleSystemFinished(ProjEffects);
		ProjEffects = None;
	}
}

defaultproperties
{

	Speed = 1200
	ProjFlightTemplate=ParticleSystem'BloodFalcon.ParticleSystem.Basic'
	//ProjExplosionTemplate=ParticleSystem'Envy_Effects.Particles.P_JumpBoot_Effect'
	LifeSpan=1
	DrawScale=1.5
	Damage=10
    MomentumTransfer=0
	DoNotExplodeEver = false

    Begin Object Name=CollisionCylinder
            CollisionRadius=+16.000000
            CollisionHeight=+32.000000
    End Object
	CollisionComponent=CollisionCylinder
	CylinderComponent=CollisionCylinder
	Components.Add(CollisionCylinder)

    Begin Object class=DynamicLightEnvironmentComponent name=MyLightEnvironment
            bEnabled=true
    End Object
    Components.Add(MyLightEnvironment)

    Begin Object class=StaticMeshComponent name=MyMesh
            StaticMesh=StaticMesh'WP_ShockRifle.Mesh.S_Sphere_Good'
            LightEnvironment=MyLightEnvironment
			HiddenGame=true
    End Object
    Components.Add(MyMesh)
	bBlockedByInstigator=false
	ProjSound1=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_FireCue'
	bCollideActors = true
	bCollideWorld = true
	Physics=PHYS_Projectile
	CollisionType=COLLIDE_TouchAll
	
}