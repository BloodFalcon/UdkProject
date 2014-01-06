class BF_Enemy_Drone extends BF_Enemy_Base;

event PostBeginPlay()
{
NPCInfo.FireRate=0.4;
NPCInfo.ProjClass=class'BF_Proj_Red';
NPCInfo.SoulClass=class'BF_Enemy_Drone';
NPCInfo.SoulMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Drone';
NPCInfo.Level=0;
}

function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("Drone Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level==1){
		NPCInfo.FireRate=0.15;
	}else if(NPCInfo.Level>=2){
		NPCInfo.FireRate=0.075;
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
}
