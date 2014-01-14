class BF_Boss_Main extends UDKPawn
	dependson(BFPawn)
	placeable;


event PostBeginPlay()
{
    super.PostBeginPlay();
	CylinderComponent.SetActorCollision(false, false);
	Mesh.SetActorCollision(true, true);
}


event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
}


event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local UDKPawn HitPawn;
	HitPawn = BFPawn(Other);

			if(HitPawn != none)
			{

			}
}


DefaultProperties
{
	Health=50000
	GroundSpeed=200
	CollisionType=COLLIDE_TouchAll
    bJumpCapable=false
    bCanJump=false
	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	bCanBeBaseForPawns=true
	Begin Object Class=SkeletalMeshComponent Name=BMMesh
		SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.testboss'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.testboss_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=10
    End Object 
	Mesh=BMMesh
	Components.Add(BMMesh)
}
