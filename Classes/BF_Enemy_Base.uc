class BF_Enemy_Base extends UDKPawn
	placeable;

var BFPawn OurPlayer;
var int EnemyAbsorbTime;
var ParticleSystem EngineFire, DeathExplosion;
var SoundCue DeathSound;
var class<BF_Proj_Base> ProjClass;
var float FireRate;
var byte Level;

event PostBeginPlay()
{
    super.PostBeginPlay();
	SetPhysics(PHYS_Flying); // wake the physics up
	
	// set up collision detection based on mesh's PhysicsAsset
	CylinderComponent.SetActorCollision(false, false); // disable cylinder collision
	Mesh.SetActorCollision(true, true); // enable PhysicsAsset collision
	Mesh.SetTraceBlocking(true, true); // block traces (i.e. anything touching mesh)
	WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(0,0,0));	
}

function LevelUp()
{

}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);  //Must Have To Process Standard Damage
}



function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	owner.Destroy();
	Self.Destroy();
	WorldInfo.MyEmitterPool.SpawnEmitter(DeathExplosion, Location);
	PlaySound(DeathSound);
	return True;
}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local UDKPawn HitPawn;
	HitPawn = BFPawn(Other);

			if(HitPawn != none)
			{
				//`Log("Touch Player");
				WorldInfo.MyEmitterPool.SpawnEmitter(DeathExplosion, Location);
				PlaySound(DeathSound);
				self.Destroy();
			}
			else
			{
				//`log("Touch Enemy");
			}
}

DefaultProperties
{
	LandMovementState=PlayerFlying
	EngineFire = ParticleSystem'BloodFalcon.ParticleSystem.Gunship_Exhaust'
	DeathExplosion = ParticleSystem'FX_VehicleExplosions.Effects.P_FX_VehicleDeathExplosion'
	DeathSound = SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Eject_Cue'

  //  Begin Object Name=CollisionCylinder
		//CollisionRadius=+100.000000
		//CollisionHeight=+44.000000
  //  End Object

  //  Begin Object Class=SkeletalMeshComponent Name=EP1Mesh
  //      SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.GunShip'
		//PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.GunShip_Physics'
  //      HiddenGame=FALSE
  //      HiddenEditor=FALSE
		//BlockNonZeroExtent=true
		//BlockZeroExtent=true
		//BlockActors=false
		//CollideActors=true
  //  End Object 
  //  Mesh=EP1Mesh 
  //  Components.Add(EP1Mesh)
    ControllerClass=class'UdkProject.BF_AI_Gunship'
 
    bJumpCapable=false
    bCanJump=false

	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	CollisionType=COLLIDE_TouchAll
	CylinderComponent=CollisionCylinder
	Level=0
	AirSpeed=300
}
