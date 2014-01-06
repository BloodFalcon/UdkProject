class BF_Enemy_SuicideFighter extends BF_Enemy_Base;

event PostBeginPlay()
{
NPCInfo.FireRate=0.1;
NPCInfo.ProjClass=class'BF_Proj_Blue';
NPCInfo.SoulClass=class'BF_Enemy_SuicideFighter';
NPCInfo.SoulMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.SuicideFighter';
NPCInfo.Level=0;
}

function LevelUp()
{
	`log("SF Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level==1){
		NPCInfo.FireRate=0.05;
	}else if(NPCInfo.Level==2){
		NPCInfo.FireRate=0.01;
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
	//ProjClass = class'BF_Proj_Blue'
	//FireRate = 0.1
}
