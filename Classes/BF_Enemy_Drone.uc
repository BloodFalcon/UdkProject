class BF_Enemy_Drone extends BF_Enemy_Base;

DefaultProperties
{
	Health = 10
    Begin Object Class=SkeletalMeshComponent Name=EP2Mesh
        SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Drone'
		PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.Drone_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale = 1.5
    End Object
	Mesh=EP2Mesh
	Components.Add(EP2Mesh)
}
