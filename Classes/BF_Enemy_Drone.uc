class BF_Enemy_Drone extends BF_Enemy_Base;

function LevelUp()
{
	Level++;
	if(Level==1){
		FireRate=0.15;
	}else if(Level==2){
		FireRate=0.075;
	}
}

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
	ProjClass = class'BF_Proj_Green'
	FireRate = 0.3
}
