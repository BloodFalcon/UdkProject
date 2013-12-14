//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy Pawn 1
//////////////////////////

class BF_Enemy_GunShip extends UDKPawn 
placeable;

var bool AbsorbSuccess;
var BFPawn OurPlayer;
var int EnemyAbsorbTime;
var ParticleSystem EngineFire;
var bool TurnEnginesOn;

function AddDefaultInventory()
{
    InvManager.CreateInventory(class'UdkProject.BF_Weap_Gunship');
}

event Tick(float DeltaTime)
{
	//if(TurnEnginesOn)
	//{
	//	WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true);
	//	TurnEnginesOn = false;
	//}
	//else
	//{
	//	//EngineFire.SetVectorParameter('ExhaustStartLocation', (Location + vect(0,0,0)));
	//}
}
 
event PostBeginPlay()
{
    AddDefaultInventory(); //GameInfo calls it only for players, so we have to do it ourselves for AI.
	SetPhysics(PHYS_Flying); // wake the physics up
	
	// set up collision detection based on mesh's PhysicsAsset
	CylinderComponent.SetActorCollision(false, false); // disable cylinder collision
	Mesh.SetActorCollision(true, true); // enable PhysicsAsset collision
	Mesh.SetTraceBlocking(true, true); // block traces (i.e. anything touching mesh)
	WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(0,0,0));
	super.PostBeginPlay();
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
	EngineFire = ParticleSystem'BloodFalcon.ParticleSystem.Gunship_Exhaust'

    Begin Object Name=CollisionCylinder
		CollisionRadius=+100.000000
		CollisionHeight=+44.000000
    End Object

    Begin Object Class=SkeletalMeshComponent Name=EP1Mesh
        SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.GunShip'
		PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.GunShip_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
    End Object 
    Mesh=EP1Mesh 
    Components.Add(EP1Mesh)
    ControllerClass=class'UdkProject.BF_AI_GunShip'
    InventoryManagerClass=class'UdkProject.BF_Enemy_Inventory'
 
    bJumpCapable=false
    bCanJump=false

	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	CollisionType=COLLIDE_TouchAll
	CylinderComponent=CollisionCylinder
 
	AirSpeed=300
	DrawScale=1.5
	TurnEnginesOn = true
}