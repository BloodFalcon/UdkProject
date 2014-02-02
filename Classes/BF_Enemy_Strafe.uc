class BF_Enemy_Strafe extends BF_Enemy_Base;

event PostBeginPlay()
{
	NPCInfo.FireRate=0.4;
	NPCInfo.ProjClass=class'BF_Proj_Red_Line';
	NPCInfo.SoulClass=class'BF_Enemy_Strafe';
	NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.SuicideFighter_W2';
	NPCInfo.Size=0.45;
	NPCInfo.Speed=1600;
	NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed_Dark';
	NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpread_Dark';
	NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate_Dark';
	NPCInfo.HUDuP.HB1="Flight Speed";
	NPCInfo.HUDuP.HB2="Bullet Spread";
	NPCInfo.HUDuP.HB3="Fire Rate";
	NPCInfo.HUDName="Strafe";
	NPCInfo.AngularWidth=30;
	NPCInfo.Bullets=5;
	NPCInfo.BulletDamage=1;
	//WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(0,0,0), );
}

function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("Strafe Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level>=1){
		NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed';
		NPCInfo.Speed=1000;
	}
	if(NPCInfo.Level>=2){
		NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpread';
		NPCInfo.AngularWidth=75;
		NPCInfo.Bullets=5;
	}
	if(NPCInfo.Level>=3){
		NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate';
		NPCInfo.FireRate=0.2;
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
