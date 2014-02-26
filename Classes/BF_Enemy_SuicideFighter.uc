/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/11/2014
// Status: Alpha
// Being Used: Yes
// Description: A non-firing, fast moving, and weak enemy.
// Behavior: Uses dummy AI.
***************************************/

class BF_Enemy_SuicideFighter extends BF_Enemy_Base;

event PostBeginPlay()
{
	NPCInfo.FireRate=0.05;
	NPCInfo.ProjClass=class'BF_Proj_Red_Circle';
	NPCInfo.SoulClass=class'BF_Enemy_SuicideFighter';
	NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerSuicide_0';
	NPCInfo.Size=1.5;
	NPCInfo.Speed=1900;
	NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_Shielding_Dark';
	NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed_Dark';
	NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_MeterGain_Dark';
	NPCInfo.HUDuP.HB1="Shield";
	NPCInfo.HUDuP.HB2="Flight Speed";
	NPCInfo.HUDuP.HB3="Meter Fill Rate";
	NPCInfo.HUDName="Suicide Fighter";
	NPCInfo.BulletDamage=10;
	//WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(-1,0,0));
}


function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("SF Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level>=1){
		NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_Shielding';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerSuicide_1';
		NPCInfo.bSecondLife=true;
		NPCInfo.FireRate=0.05;
		NPCInfo.BulletDamage=15;
	}
	if(NPCInfo.Level>=2){
		NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerSuicide_2';
		NPCInfo.Speed=2100;
		NPCInfo.FireRate=0.05;
		NPCInfo.BulletDamage=20;
	}
	if(NPCInfo.Level>=3){
		NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_MeterGain';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerSuicide_3';
		NPCInfo.BloodIncrement=2;
		NPCInfo.FireRate=0.05;
		NPCInfo.BulletDamage=30;
	}
}


DefaultProperties
{
	Health = 75
    Begin Object Class=SkeletalMeshComponent Name=EP3Mesh
        SkeletalMesh=SkeletalMesh'MyMesh.SkeletalMesh.EnemySuicideFighter'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Suicide_0_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale = .65
    End Object
	Mesh=EP3Mesh
	Components.Add(EP3Mesh)
	GroundSpeed=650
}
