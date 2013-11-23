//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy Pawn 1
//////////////////////////

class BFEP2 extends UDKPawn 
placeable;

var bool AbsorbSuccess;
var BFPawn OurPlayer;

function AddDefaultInventory()
{
    InvManager.CreateInventory(class'UdkProject.BFEP2Weap');
}
 
event PostBeginPlay()
{
    super.PostBeginPlay();
    AddDefaultInventory(); //GameInfo calls it only for players, so we have to do it ourselves for AI.
	SetPhysics(PHYS_Flying); // wake the physics up
	
	// set up collision detection based on mesh's PhysicsAsset
	CylinderComponent.SetActorCollision(false, false); // disable cylinder collision
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
	if(AbsorbSuccess){
	BFGameInfo(WorldInfo.Game).W2 = true;
	}
	owner.Destroy();
	Self.Destroy();
	return True;
}

event Bump (Actor Other, PrimitiveComponent OtherComp, Object.Vector HitNormal)
{
	local UDKPawn HitPawn;
	HitPawn = UDKPawn(Other);

			if(HitPawn != none)
			{
				`Log("ENEMY KILLED!");
				self.Destroy();
			}
}

 
DefaultProperties
{
	Health = 10
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
		BlockActors=true
		CollideActors=true
    End Object
 
    Mesh=EP2Mesh
 
    Components.Add(EP2Mesh)
    ControllerClass=class'UdkProject.BFAI2'
    InventoryManagerClass=class'UdkProject.BFEP1InvManager'
 
    bJumpCapable=false
    bCanJump=false
	BlockRigidBody=true
	bBlockActors = true
	bCollideActors = true
	bCollideWorld = true
 
    GroundSpeed=200.0 //Making the bot slower than the player
	DrawScale=5
}