class BF_Boss_1 extends BF_Boss_Main;

event PostBeginPlay()
{
	CylinderComponent.SetActorCollision(false, false); 
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
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=10
    End Object 
	Mesh=M1Mesh
	Components.Add(M1Mesh)
    ControllerClass=class'UdkProject.BF_AI_Gunship'
    bJumpCapable=false
    bCanJump=false
	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	CollisionType=COLLIDE_TouchAll
	GroundSpeed=1000
}
