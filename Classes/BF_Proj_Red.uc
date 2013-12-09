//////////////////////////
// Author(s): Tyler
// Date: 12/4/2013
// Status: Alpha
// Being Used: Yes
// Description: laser
//////////////////////////

class BF_Proj_Red extends UDKProjectile;

var ParticleSystemComponent ProjEffects;
var ParticleSystem ProjFlightTemplate;
var ParticleSystem ProjExplosionTemplate;
var SoundCue ProjSound1;
var vector VelocityCur;
var vector AccelerationCur;
var Vector StartingLoc;
var int Distance;
var bool Neg;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetPhysics(PHYS_Projectile); 
	SpawnFlightEffects();
	SpawnFireEffect();
	StartingLoc = self.Location;
	while(VelocityCur.X<150 && VelocityCur.X>(-150)){
	VelocityCur.X = RandRange(-200, 200);
	}
	if(VelocityCur.X>0){
		Neg=false;
	}else{
		Neg=true;
	}
	VelocityCur.Y = 1.0;
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


function tick(float DeltTime)
{
	if(Neg){
		if(VelocityCur.X<(-10.0) && VelocityCur.Y>0.0){
			VelocityCur.X+=5;
			VelocityCur.Y+=2;
		}else{
			VelocityCur.X=(100);
			VelocityCur.Y-=100;
		}
	}else{
		if(VelocityCur.X>10.0 && VelocityCur.Y>0.0){
			VelocityCur.X-=5;
			VelocityCur.Y+=2;
		}else{
			VelocityCur.X=(-100);
			VelocityCur.Y-=100;
		}
	}
	Velocity = VelocityCur;
	Distance = VSize(StartingLoc - self.Location);
	if(Distance >= 5000){
	self.Destroy();
	}
//Velocity = vect(0,10000,0);
//Acceleration =vect(0.0,1000.0,0.0);

}


defaultproperties
{
	Neg=0
	//VelocityCur =(x=0.0,y=100.0,z=0.0)
	//AccelerationCur =(x=0.0,y=100.0,z=0.0)
	//AccelRate = 10
	//Speed = 1200
	ProjFlightTemplate=ParticleSystem'BloodFalcon.ParticleSystem.LaserShot3'
	//ProjExplosionTemplate=ParticleSystem'Envy_Effects.Particles.P_JumpBoot_Effect'
	LifeSpan=250
	DrawScale=0.1
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
			HiddenGame=true
    End Object
    Components.Add(MyMesh)
	bBlockedByInstigator=false
	ProjSound1=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_FireCue'
}