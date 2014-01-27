class BF_Enemy_Drone extends BF_Enemy_Base;


event PostBeginPlay()
{
	NPCInfo.FireRate=0.2;
	NPCInfo.ProjClass=class'BF_Proj_Red_Line';
	NPCInfo.SoulClass=class'BF_Enemy_Drone';
	NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Drone_W2';
	NPCInfo.Size=1;
	NPCInfo.Speed=600;
	//WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(0,0,0), );
}


function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("Drone Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level>=1){
		NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpread';
		//Not Done
	}
	if(NPCInfo.Level>=2){
		NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpeed';
		NPCInfo.BulletSpeed=3000;
	}
	if(NPCInfo.Level>=3){
		NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletDamage';
		NPCInfo.BulletDamage=3;
	}
}


DefaultProperties
{
	Health = 10
    Begin Object Class=SkeletalMeshComponent Name=EP2Mesh
        SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Drone_W2'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Drone_W2_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale = 1
    End Object
	Mesh=EP2Mesh
	Components.Add(EP2Mesh)
	GroundSpeed=600
}
