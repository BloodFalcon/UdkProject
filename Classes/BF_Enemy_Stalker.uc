class BF_Enemy_Stalker extends BF_Enemy_Base;

event PostBeginPlay()
{
	NPCInfo.FireRate=0.4;
	NPCInfo.ProjClass=class'BF_Proj_Red_Line';
	NPCInfo.SoulClass=class'BF_Enemy_Stalker';
	NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Drone_W3';
	NPCInfo.Size=1.1;
	NPCInfo.Speed=500;
	//WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(0,0,0), );
}

function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("Stalker Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level>=1){

	}
	if(NPCInfo.Level>=2){

	}
	if(NPCInfo.Level>=3){

	}
}

DefaultProperties
{
	Health=25
    Begin Object Class=SkeletalMeshComponent Name=EP2Mesh
        SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Drone_W3'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Drone_W3_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale=1.1
    End Object
	Mesh=EP2Mesh
	Components.Add(EP2Mesh)
	GroundSpeed=500
}
