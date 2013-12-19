//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy Pawn 1
//////////////////////////

class BF_Enemy_SuicideFighter extends UDKPawn 
placeable;

var bool AbsorbSuccess;
var BFPawn OurPlayer;
var Vector NewLoc;
var ParticleSystem DeathExplosion;
var SoundCue DeathSound;

function AddDefaultInventory()
{
    InvManager.CreateInventory(class'UdkProject.BF_Weap_SuicideFighter');
}

event PostBeginPlay()
{
    super.PostBeginPlay();
	SetPhysics(PHYS_Flying); // wake the physics up
	
	// set up collision detection based on mesh's PhysicsAsset
	//CylinderComponent.SetActorCollision(false, false); // disable cylinder collision
	Mesh.SetActorCollision(true, true); // enable PhysicsAsset collision
	Mesh.SetTraceBlocking(true, true); // block traces (i.e. anything touching mesh)
	//SuicideSpeed = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).SuicideSpeed;
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(Damage == 2)
	{
	SetDrawScale((DrawScale-0.5));
	AbsorbSuccess = true;
	}

	super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);  //Must Have To Process Standard Damage
}



function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	owner.Destroy();
	Self.Destroy();
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
	Health = 10
	LandMovementState=PlayerFlying
	DeathExplosion = ParticleSystem'FX_VehicleExplosions.Effects.P_FX_VehicleDeathExplosion'
	DeathSound = SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Eject_Cue'

    Begin Object Name=CollisionCylinder
		CollisionHeight=+44.000000
    End Object


    Begin Object Class=SkeletalMeshComponent Name=EP3Mesh
        SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.SuicideFighter'
		PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.SuicideFighter_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
    End Object
 
    Mesh=EP3Mesh
 
    Components.Add(EP3Mesh)
    ControllerClass=class'UdkProject.BF_AI_SuicideFighter'
    InventoryManagerClass=class'UdkProject.BF_Enemy_Inventory'
 
    bJumpCapable=false
    bCanJump=false

	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	CollisionType=COLLIDE_TouchAll
	CylinderComponent=CollisionCylinder

	GroundSpeed = 1200
	DrawScale=1.25
}