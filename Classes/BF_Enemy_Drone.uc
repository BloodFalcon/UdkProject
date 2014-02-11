class BF_Enemy_Drone extends BF_Enemy_Base;

event PostBeginPlay()
{
	NPCInfo.FireRate=0.5;
	NPCInfo.ProjClass=class'BF_Proj_Red_Line';
	NPCInfo.SoulClass=class'BF_Enemy_Drone';
	NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Vulcan_0';
	NPCInfo.Size=1.4;
	NPCInfo.Speed=1200;
	NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate_Dark';
	NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletDamage_Dark';
	NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_ArmorPiercing_Dark';
	NPCInfo.HUDuP.HB1="Fire Rate";
	NPCInfo.HUDuP.HB2="Bullet Damage";
	NPCInfo.HUDuP.HB3="Armor Piercing";
	NPCInfo.HUDName="Vulcan";
	NPCInfo.BulletDamage=1;
	NPCInfo.BulletSpeed=vect(0,-1500,0);
	NPCInfo.AngularWidth=25;
	NPCInfo.Bullets=3;
	//WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(-1,0,0));
}

function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("Vulcan Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level>=1){
		NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate';
		NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters2.SkeletalMesh.Vulcan_1';
		NPCInfo.FireRate = 0.2;
	}
	if(NPCInfo.Level>=2){
		NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletDamage';
		NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters2.SkeletalMesh.Vulcan_2';
		NPCInfo.BulletDamage=2;
	}
	if(NPCInfo.Level>=3){
		NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_ArmorPiercing';
		NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters2.SkeletalMesh.Vulcan_3';
		NPCInfo.BulletPenetration=true;
	}
}

DefaultProperties
{
	Health=60
    Begin Object Class=SkeletalMeshComponent Name=EP1Mesh
        SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Vulcan_0'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Vulcan_0_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale=1.4
    End Object 
    Mesh=EP1Mesh 
    Components.Add(EP1Mesh)
	GroundSpeed=400
}
