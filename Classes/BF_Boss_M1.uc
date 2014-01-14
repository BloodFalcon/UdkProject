class BF_Boss_M1 extends BF_Boss_Main;

var SkeletalMeshComponent AMesh;

event PostBeginPlay()
{
//	local vector SockLoc;
//	local Rotator SockRot;
//	local Actor A;
//self.Mesh.GetSocketWorldLocationAndRotation('W1',SockLoc,SockRot);
//A = self.Spawn(class'BF_Boss_A1_1',,,SockLoc,SockRot,,);
//A.SetBase(self);
//a.Attach(self);
}


function tick(float DeltaTime)
{

}


DefaultProperties
{
	//ControllerClass=class'BF_AI_Boss_M1'
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
}
