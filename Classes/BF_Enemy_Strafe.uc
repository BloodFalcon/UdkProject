class BF_Enemy_Strafe extends BF_Enemy_Base;

event PostBeginPlay()
{
	NPCInfo.FireRate=0.05;
	NPCInfo.ProjClass=class'BF_Proj_Red_Line';
	NPCInfo.SoulClass=class'BF_Enemy_Strafe';
	NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerStrafe_0';
	NPCInfo.Size=0.2;
	NPCInfo.Speed=1600;
	NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed_Dark';
	NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpeed_Dark';
	NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_ArmorPiercing_Dark';
	NPCInfo.HUDuP.HB1="Flight Speed";
	NPCInfo.HUDuP.HB2="Bullet Speed";
	NPCInfo.HUDuP.HB3="Armor Piercing";
	NPCInfo.HUDName="Strafe";
	NPCInfo.AngularWidth=30;
	NPCInfo.Bullets=3;
	NPCInfo.BulletDamage=10;
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
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerStrafe_1';
		NPCInfo.Speed=1900;
		NPCInfo.FireRate=0.05;
		NPCInfo.BulletDamage=15;
	}
	if(NPCInfo.Level>=2){
		NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpeed';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerStrafe_2';
		//NPCInfo.AngularWidth=75;
		//NPCInfo.Bullets=5;
		NPCInfo.BulletSpeed=vect(0,-3000,0);
		NPCInfo.FireRate=0.05;
		NPCInfo.BulletDamage=20;
	}
	if(NPCInfo.Level>=3){
		NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_ArmorPiercing';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerStrafe_3';
		NPCInfo.BulletPenetration=true;
		NPCInfo.FireRate=0.05;
		NPCInfo.BulletDamage=30;
	}
}

DefaultProperties
{
	Health=275
    Begin Object Class=SkeletalMeshComponent Name=EP2Mesh
        SkeletalMesh=SkeletalMesh'MyMesh.SkeletalMesh.EnemyStrafe'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Strafe_0_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale= .20
    End Object
	Mesh=EP2Mesh
	Components.Add(EP2Mesh)
	GroundSpeed=500
}
