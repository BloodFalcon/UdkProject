class BF_Boss_Gun_1 extends BF_Boss_Aux;

event PostBeginPlay()
{
	super.PostBeginPlay();
}

event tick(float DeltaTime)
{
super.tick(DeltaTime);
//self.SetRotation(RotRand());

}

DefaultProperties
{
	Begin Object Class=SkeletalMeshComponent Name=A11Mesh
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
	Mesh=A11Mesh
	Components.Add(A11Mesh)
	bIgnoreForces=true
}
