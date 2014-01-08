//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Upgrade Weapon 1
//////////////////////////

class BF_Proj_Yellow extends BF_Proj_Base;

var ParticleSystemComponent ProjEffects;
var ParticleSystem ProjFlightTemplate;
var ParticleSystem ProjExplosionTemplate;
var SoundCue ProjSound1;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SpawnFlightEffects();
	SpawnFireEffect();
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	local UDKPawn HitPlayer;
	HitPlayer = BFPawn(Other);
	`log("Process Touch");
	if (Other != Instigator && Other == HitPlayer)
	{
		Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
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

defaultproperties
{

	Speed = 550
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Yellow_Circle'
	//ProjExplosionTemplate=ParticleSystem'Envy_Effects.Particles.P_JumpBoot_Effect'
	LifeSpan=5
	DrawScale=1.5
	Damage=10
    MomentumTransfer=0
	CustomGravityScaling=0

    Begin Object Name=CollisionCylinder
            CollisionRadius=8
            CollisionHeight=16
    End Object

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
}