class BF_Enemy_Drone extends BF_Enemy_Base;


event PostBeginPlay()
{
	NPCInfo.FireRate=0.2;
	NPCInfo.ProjClass=class'BF_Proj_Red_Line';
	NPCInfo.SoulClass=class'BF_Enemy_Drone';
	NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Drone_0';
	NPCInfo.Size=1;
	NPCInfo.Speed=1700;
	NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpread_Dark';
	NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpeed_Dark';
	NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletDamage_Dark';
	NPCInfo.HUDuP.HB1="Bullet Spread";
	NPCInfo.HUDuP.HB2="Bullet Speed";
	NPCInfo.HUDuP.HB3="Bullet Damage";
	NPCInfo.HUDName="Drone";
	NPCInfo.BulletDamage=1;
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
		NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters2.Drone_1';
		NPCInfo.AngularWidth=75;
		NPCInfo.Bullets=5;
	}
	if(NPCInfo.Level>=2){
		NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpeed';
		NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters2.Drone_2';
		NPCInfo.BulletSpeed=vect(0,-3000,0);
	}
	if(NPCInfo.Level>=3){
		NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletDamage';
		NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters2.Drone_3';
		NPCInfo.BulletDamage=3;
	}
}


DefaultProperties
{
	Health = 10
    Begin Object Class=SkeletalMeshComponent Name=EP2Mesh
        SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Drone_0'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Drone_0_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale = 0.85
    End Object
	Mesh=EP2Mesh
	Components.Add(EP2Mesh)
	GroundSpeed=600
}
