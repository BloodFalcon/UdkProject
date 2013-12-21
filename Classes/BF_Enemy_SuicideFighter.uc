class BF_Enemy_SuicideFighter extends BF_Enemy_Base;

DefaultProperties
{
	Health = 10
    Begin Object Class=SkeletalMeshComponent Name=EP3Mesh
        SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.SuicideFighter'
		PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.SuicideFighter_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale = 1.25
    End Object
	Mesh=EP3Mesh
	Components.Add(EP3Mesh)
}
