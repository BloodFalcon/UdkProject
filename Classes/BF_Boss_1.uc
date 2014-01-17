class BF_Boss_1 extends BF_Boss_Main;

event PostBeginPlay()
{
	CylinderComponent.SetActorCollision(false, false); 
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	`log(Health);
	Health-=Damage;
	if(Health<=0){
		Destroy();
	}
}

function tick(float DeltaTime)
{

}


DefaultProperties
{
	Begin Object Class=SkeletalMeshComponent Name=M1Mesh
		SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.testboss'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.testboss_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=false
		BlockZeroExtent=False
		BlockActors=false
		CollideActors=false
		Scale=10
    End Object 
	Mesh=M1Mesh
	Components.Add(M1Mesh)
    ControllerClass=class'UdkProject.BF_AI_Boss_1'
    bJumpCapable=false
    bCanJump=false
	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	CollisionType=COLLIDE_TouchAll
	GroundSpeed=1000
	AccelRate=10000
	Acceleration=10000
}
