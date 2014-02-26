class BF_Enemy_Stalker extends BF_Enemy_Base;

event PostBeginPlay()
{
	NPCInfo.FireRate=0.05;
	NPCInfo.ProjClass=class'BF_Proj_Red_Line';
	NPCInfo.SoulClass=class'BF_Enemy_Stalker';
	NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerStalker_0';
	NPCInfo.Size=0.5;
	NPCInfo.Speed=1800;
	NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_Shielding_Dark';
	NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed_Dark';
	NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_ArmorPiercing_Dark';
	NPCInfo.HUDuP.HB1="Shield";
	NPCInfo.HUDuP.HB2="Flight Speed";
	NPCInfo.HUDuP.HB3="Armor Piercing";
	NPCInfo.HUDName="Stalker";
	NPCInfo.BulletDamage=10;
	//WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(0,0,0), );
}

function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("Stalker Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level>=1){
		NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_Shielding';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerStalker_1';
		NPCInfo.bSecondLife=true; //Check This Out Later
		NPCInfo.BulletDamage=15;
		NPCInfo.FireRate=0.05;
	}
	if(NPCInfo.Level>=2){
		NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerStalker_2';
		NPCInfo.Speed=2000;
		NPCInfo.BulletDamage=20;
		NPCInfo.FireRate=0.05;
	}
	if(NPCInfo.Level>=3){
		NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_ArmorPiercing';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerStalker_3';
		NPCInfo.BulletPenetration=true;
		NPCInfo.BulletDamage=20;
		NPCInfo.FireRate=0.033;
	}
}

DefaultProperties
{
	Health=225
    Begin Object Class=SkeletalMeshComponent Name=EP2Mesh
        SkeletalMesh=SkeletalMesh'MyMesh.SkeletalMesh.EnemyStalker'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Stalker_0_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale= .5
    End Object
	Mesh=EP2Mesh
	Components.Add(EP2Mesh)
	GroundSpeed=500
}
