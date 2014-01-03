class BF_Enemy_SuicideFighter extends BF_Enemy_Base;

function LevelUp()
{
	`log(Level);
	Level++;
	if(Level==1){
		FireRate=0.05;
	}else if(Level==2){
		FireRate=0.01;
	}
}

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
	ProjClass = class'BF_Proj_Blue'
	FireRate = 0.1
}
