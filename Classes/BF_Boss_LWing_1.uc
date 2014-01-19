class BF_Boss_LWing_1 extends BF_Boss_Aux;

var Rotator WingRot;

event PostBeginPlay()
{
	super.PostBeginPlay();
	WingRot.Yaw = 90*DegToUnrRot;
	self.SetRotation(WingRot);
}

event tick(float DeltaTime)
{
super.tick(DeltaTime);
self.SetRotation(WingRot);

}

DefaultProperties
{
	Begin Object Class=SkeletalMeshComponent Name=A11Mesh
		SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.LVL1_Boss_LWing'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.LVL1_Boss_LWing_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=5
    End Object 
	Mesh=A11Mesh
	Components.Add(A11Mesh)
	bIgnoreForces=true
}