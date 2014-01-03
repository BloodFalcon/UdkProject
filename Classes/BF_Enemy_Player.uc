class BF_Enemy_Player extends BF_Enemy_Base;

DefaultProperties
{
	
	Health = 10
    Begin Object Name=CollisionCylinder
		CollisionRadius=+100.000000
		CollisionHeight=+44.000000
    End Object

    Begin Object Class=SkeletalMeshComponent Name=EP1Mesh
        SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Player'
		PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.Player_Physics'
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
	ProjClass = class'Bf_Proj_Basic'
	FireRate = 1
}
