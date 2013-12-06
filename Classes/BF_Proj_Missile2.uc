//////////////////////////
// Author(s): Tyler
// Date: 12/4/2013
// Status: Alpha
// Being Used: Yes
// Description: Missile using distance instead of velocity
//////////////////////////

class BF_Proj_Missile2 extends UDKProjectile;

var ParticleSystemComponent ProjEffects;
var ParticleSystem ProjFlightTemplate;
var ParticleSystem ProjExplosionTemplate;
var SoundCue ProjSound1;
var vector VelocityCur;
var vector AccelerationCur;
var Vector StartingLoc;
var bool Neg;
var int CurDistance;
var int HDistance;
var int VDistance;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetPhysics(PHYS_Projectile); 
	SpawnFlightEffects();
	SpawnFireEffect();
	StartingLoc = self.Location;
	while(HDistance<50 && HDistance>(-50)){
	HDistance = RandRange(-75, 75);
	}
	if(HDistance>0){
		VelocityCur.X = 250;
		Neg=false;
	}else{
		VelocityCur.X = (-250);
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
	CurDistance = VSize(StartingLoc - self.Location);
`log(CurDistance);
	if(Neg){
		if(CurDistance>=HDistance && VelocityCur.Y>0.0){
			VelocityCur.X+=5;
			VelocityCur.Y+=2;
		}else{
			VelocityCur.X=(100);
			VelocityCur.Y-=100;
		}
	}else{
		if(CurDistance>=(-HDistance) && VelocityCur.Y>0.0){
			VelocityCur.X-=5;
			VelocityCur.Y+=2;
		}else{
			VelocityCur.X=(-100);
			VelocityCur.Y-=100;
		}
	}
	Velocity = VelocityCur;
	if(CurDistance >= 5000){
		Destroyed();
		self.Destroy();
	}
//Velocity = vect(0,10000,0);
//Acceleration =vect(0.0,1000.0,0.0);

}


defaultproperties
{
	HDistance=0
	VDistance=0
	Neg=0
	//VelocityCur =(x=0.0,y=100.0,z=0.0)
	//AccelerationCur =(x=0.0,y=100.0,z=0.0)
	//AccelRate = 10
	//Speed = 1200
	ProjFlightTemplate=ParticleSystem'BloodFalcon.ParticleSystem.Red'
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
})