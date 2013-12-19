//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy Pawn 1
//////////////////////////

class BF_Enemy_Drone extends UDKPawn 
placeable;

var bool AbsorbSuccess;
var BFPawn OurPlayer;
var ParticleSystem DeathExplosion;
var SoundCue DeathSound;

function AddDefaultInventory()
{
    InvManager.CreateInventory(class'UdkProject.BF_Weap_Drone');
}
 
event PostBeginPlay()
{
    super.PostBeginPlay();
    AddDefaultInventory(); //GameInfo calls it only for players, so we have to do it ourselves for AI.
	SetPhysics(PHYS_Flying); // wake the physics up
	
	//Set up collision detection based on mesh's PhysicsAsset
	//CylinderComponent.SetActorCollision(false, false); // disable cylinder collision
	Mesh.SetActorCollision(true, true); // enable PhysicsAsset collision
	Mesh.SetTraceBlocking(true, true); // block traces (i.e. anything touching mesh)
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(Damage == 2)
	{
	SetDrawScale((DrawScale-0.5));
	AbsorbSuccess = true;
	}
	super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser); //Must Have To Process Standard Damage
}

function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	/*
	if (Super.Died(Killer, DamageType, HitLocation))
	{
		StartFallImpactTime = WorldInfo.TimeSeconds;
		bCanPlayFallingImpacts=true;
		if(ArmsMesh[0] != none)
		{
			ArmsMesh[0].SetHidden(true);
		}
		if(ArmsMesh[1] != none)
		{
			ArmsMesh[1].SetHidden(true);
		}
		SetPawnAmbientSound(None);
		SetWeaponAmbientSound(None);
		return true;
	}
	return false;
	*/
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

    Begin Object Class=SkeletalMeshComponent Name=EP2Mesh
        SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Drone'
		PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.Drone_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
    End Object
 
    Mesh=EP2Mesh
 
    Components.Add(EP2Mesh)
    ControllerClass=class'UdkProject.BF_AI_Drone'
    InventoryManagerClass=class'UdkProject.BF_Enemy_Inventory'
 
    bJumpCapable=false
    bCanJump=false
	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	CollisionType=COLLIDE_BlockAll
	CylinderComponent=CollisionCylinder
 
	AirSpeed=300
	DrawScale=1.5
}