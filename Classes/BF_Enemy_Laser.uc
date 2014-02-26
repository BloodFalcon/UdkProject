/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/11/2014
// Status: Alpha
// Being Used: Yes
// Description: A tough, slower moving, and high fire power enemy. 
// Behavior: Uses dummy AI.
***************************************/

class BF_Enemy_Laser extends BF_Enemy_Base;

event PostBeginPlay()
{
	NPCInfo.FireRate=0.05;
	NPCInfo.ProjClass=class'BF_Proj_Red_TwoShotBetty';
	NPCInfo.SoulClass=class'BF_Enemy_Laser';
	NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerLazer_0';
	NPCInfo.Size=1.4;
	NPCInfo.Speed=1900;
	NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate_Dark';
	NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate_Dark';
	NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate_Dark';
	NPCInfo.HUDuP.HB1="Fire Rate";
	NPCInfo.HUDuP.HB2="Fire Rate+";
	NPCInfo.HUDuP.HB3="Fire Rate++";
	NPCInfo.HUDName="Laser";
	NPCInfo.BulletDamage=10;
	//WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(-1,0,0));
}

function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("Laser Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level>=1){
		NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerLazer_1';
		NPCInfo.FireRate=0.033;
		NPCInfo.BulletDamage=10;
	}
	if(NPCInfo.Level>=2){
		NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerLazer_2';
		NPCInfo.FireRate=0.05;
		NPCInfo.BulletDamage=10;
	}
	if(NPCInfo.Level>=3){
		NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerLazer_3';
		NPCInfo.FireRate=0.05;
		NPCInfo.BulletDamage=10;
	}
}

DefaultProperties
{
	Health=175
    Begin Object Class=SkeletalMeshComponent Name=EP1Mesh
        SkeletalMesh=SkeletalMesh'MyMesh.SkeletalMesh.EnemyLazer'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Lazer_0_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale= .6
    End Object 
    Mesh=EP1Mesh 
    Components.Add(EP1Mesh)
	GroundSpeed=350
}

