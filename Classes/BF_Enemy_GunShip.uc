class BF_Enemy_GunShip extends BF_Enemy_Base;

DefaultProperties
{
	Health = 10
    Begin Object Class=SkeletalMeshComponent Name=EP1Mesh
        SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.GunShip'
		PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.GunShip_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale = 1.5
    End Object
    Mesh=EP1Mesh 
    Components.Add(EP1Mesh)
}
