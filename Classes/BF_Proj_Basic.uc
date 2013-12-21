//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Base Weapon
//////////////////////////

class BF_Proj_Basic extends BF_Proj_Base;

var ParticleSystemComponent ProjEffects;
var ParticleSystem ProjFlightTemplate;
var ParticleSystem ProjExplosionTemplate;
var SoundCue ProjSound1;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetPhysics(PHYS_Projectile); 
	SpawnFlightEffects();
	SpawnFireEffect();
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
		WorldInfo.MyEmitterPool.SpawnEmitter(ProjExplosionTemplate, HitLocation);		
	}
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


function tick(float DeltaTime)
{
	Velocity = vect(0,-1500,0);
}


defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BloodFalcon.ParticleSystem.P_Test_Bullet'
	ProjExplosionTemplate=ParticleSystem'BloodFalcon.ParticleSystem.Kill_Bullet'
	LifeSpan=125
	DrawScale=1
	Damage=10
	DamageRadius = +10.0
    MomentumTransfer=0
	CustomGravityScaling=0
	Physics = PHYS_Projectile

    Begin Object Name=CollisionCylinder
            CollisionRadius=8
            CollisionHeight=16
    End Object

    Begin Object class=DynamicLightEnvironmentComponent name=MyLightEnvironment
            bEnabled=true
    End Object
    Components.Add(MyLightEnvironment)

    Begin Object class=StaticMeshComponent name=MyMesh
            StaticMesh=StaticMesh'WP_RocketLauncher.Mesh.S_WP_Rocketlauncher_Rocket_old_lit'
            LightEnvironment=MyLightEnvironment
			HiddenGame=true
    End Object
    Components.Add(MyMesh)
	bBlockedByInstigator=false
	ProjSound1=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_FireCue'
}