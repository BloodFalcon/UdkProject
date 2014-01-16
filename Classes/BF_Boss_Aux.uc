class BF_Boss_Aux extends BF_Enemy_Base
	dependson(BF_Boss_Main)
	placeable;

var BF_Boss_Main BossBase;
var name Sock;

event PostBeginPlay()
{
    super.PostBeginPlay();
	CylinderComponent.SetActorCollision(false, false); 
	Mesh.SetActorCollision(true, true);
	//self.SpawnDefaultController();
	//self.SetMovementPhysics();
}


event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	Health-=Damage;
	if(Health<=0){
		Destroy();
	}
}


event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local UDKPawn HitPawn;
	HitPawn = BFPawn(Other);

			if(HitPawn != none)
			{

			}
}

event tick(float DeltaTime)
{
	local vector SockLoc;
	local Rotator SockRot;
	if(BossBase!=none){
		if(BossBase.Mesh.GetSocketByName(Sock)!=none){
			BossBase.Mesh.GetSocketWorldLocationAndRotation(Sock,SockLoc,SockRot,);
			self.SetLocation(SockLoc);
			self.SetRotation(SockRot);
		}
	}
}


DefaultProperties
{
	Health=100
	CollisionType=COLLIDE_TouchAll
    bJumpCapable=false
    bCanJump=false
	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	Begin Object Class=SkeletalMeshComponent Name=BAMesh
		SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.testbossweapon'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.testbossweapon_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=10
    End Object 
	Mesh=BAMesh
	Components.Add(BAMesh)
}
