class BF_Enemy_GunShip extends BF_Enemy_Base;

event PostBeginPlay()
{
NPCInfo.FireRate=0.7;
NPCInfo.ProjClass=class'BF_Proj_Missile';
NPCInfo.SoulClass=class'BF_Enemy_GunShip';
NPCInfo.SoulMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Player';
NPCInfo.Level=0;
}

function LevelUp()
{
	`log("GS Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level==1){
		NPCInfo.FireRate=0.5;
	}else if(NPCInfo.Level==2){
		NPCInfo.FireRate=0.1;
	}
}

DefaultProperties
{	
	Health = 10

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
}
