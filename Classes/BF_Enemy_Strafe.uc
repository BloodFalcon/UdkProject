class BF_Enemy_Strafe extends BF_Enemy_Base;

event PostBeginPlay()
{
	NPCInfo.FireRate=0.4;
	NPCInfo.ProjClass=class'BF_Proj_Red_Line';
	NPCInfo.SoulClass=class'BF_Enemy_Strafe';
	NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.SuicideFighter_W2';
	NPCInfo.Size=0.45;
	NPCInfo.Speed=500;
	//WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(0,0,0), );
}

function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("Strafe Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level==1){

	}else if(NPCInfo.Level==2){

	}else if(NPCInfo.Level==3){

	}else{

	}
}

DefaultProperties
{
	Health=15
    Begin Object Class=SkeletalMeshComponent Name=EP2Mesh
        SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.SuicideFighter_W2'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.SuicideFighter_W2_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale=0.45
    End Object
	Mesh=EP2Mesh
	Components.Add(EP2Mesh)
	GroundSpeed=500
}
