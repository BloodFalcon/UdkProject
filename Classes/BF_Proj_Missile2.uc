/***************************************
// Author(s): Tyler Keller
// Date: 12/8/2013
// Status: Beta
// Being Used: No
// Description: Missile for Blood Falcon
***************************************/

class BF_Proj_Missile2 extends UDKProjectile;

var ParticleSystemComponent ProjEffects;
var ParticleSystem ProjFlightTemplate;
var ParticleSystem ProjExplosionTemplate;
var SoundCue ProjSound1;
var Vector StartingLoc;
var Vector CurVelocity;
var bool FirstRun;


simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetPhysics(PHYS_Projectile); 
	SpawnFlightEffects();
	SpawnFireEffect();
	StartingLoc = self.Location;
	CurVelocity = vect(200,100,0);
}


function tick(float DeltTime)
{
	if(Self.Location.X>=(StartingLoc.X+50)){
		if(FirstRun){
		
		}
		Velocity = vect(0,-5,0);
	}else{
		CurVelocity-=vect(2,1,0);
		Velocity = CurVelocity;
	}
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
	//VelocityCur =(x=0.0,y=100.0,z=0.0)
	//AccelerationCur =(x=0.0,y=100.0,z=0.0)
	//AccelRate = 10
	//Speed = 1200
	ProjFlightTemplate=ParticleSystem'BloodFalcon.ParticleSystem.Basic'
	ProjExplosionTemplate=ParticleSystem'Envy_Effects.Particles.P_JumpBoot_Effect'
	LifeSpan=250
	DrawScale=2
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
            StaticMesh=StaticMesh'WP_RocketLauncher.Mesh.S_WP_Rocketlauncher_Rocket_old_lit'
            LightEnvironment=MyLightEnvironment
			HiddenGame=false
    End Object
    Components.Add(MyMesh)
	bBlockedByInstigator=false
	ProjSound1=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_FireCue'
}