class BF_Boss_M1 extends BF_Boss_Main;

event PostBeginPlay()
{

}

function tick(float DeltaTime)
{

}


DefaultProperties
{
	ControllerClass=class'BF_AI_Boss_M1'
	Begin Object Class=SkeletalMeshComponent Name=M1Mesh
		SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.testboss'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.testboss_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=1
    End Object 
	Mesh=M1Mesh
	Components.Add(M1Mesh)
}
