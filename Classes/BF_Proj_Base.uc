/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/11/2014
// Status: Alpha
// Being Used: Yes
// Description: Reference extension to group access to all the projectile classes.
***************************************/

class BF_Proj_Base extends UDKProjectile;

var ParticleSystemComponent ProjEffects;
var ParticleSystem ProjFlightTemplate;
var float Time;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetPhysics(PHYS_Projectile); 
	SpawnFlightEffects();
}


simulated event SpawnFlightEffects()
{
  if(WorldInfo.NetMode != NM_DedicatedServer)
  {
  ProjEffects = new class'ParticleSystemComponent';
  ProjEffects.SetTemplate(ProjFlightTemplate);
  ProjEffects.SetAbsolute(false, false, false);
  ProjEffects.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
  ProjEffects.bUpdateComponentInTick = true;
  AttachComponent(ProjEffects);
  }
}


function tick(float DeltaTime) 
{
	if(self.Location.X-920>=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).ScreenBounds.X){
		self.Destroy();	
	}
	if(self.Location.X+920<=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).ScreenBounds.X){
		self.Destroy();	
	}
	if(self.Location.Y-895>=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).ScreenBounds.Y){
		self.Destroy();	
	}
	if(self.Location.Y+895<=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).ScreenBounds.Y){
		self.Destroy();	
	}
super.Tick(DeltaTime);
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


DefaultProperties
{
	LifeSpan=2
	DamageRadius=10.0
    MomentumTransfer=0
	CustomGravityScaling=0
	Physics=PHYS_Projectile

	Begin Object Name=CollisionCylinder
        CollisionRadius=8
        CollisionHeight=16
    End Object

	Begin Object class=StaticMeshComponent name=MyMesh
        StaticMesh=StaticMesh'BloodFalcon.SM.Round_Bullet'
		HiddenGame=true
		Scale = 0.025
    End Object
    Components.Add(MyMesh)
	bBlockedByInstigator=false
}
