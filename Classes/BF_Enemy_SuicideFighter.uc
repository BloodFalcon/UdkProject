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
	NPCInfo.FireRate=0.2;
	NPCInfo.ProjClass=class'BF_Proj_Red_Circle';
	NPCInfo.SoulClass=class'BF_Enemy_SuicideFighter';
	NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Suicide_0';
	NPCInfo.Size=1.5;
	NPCInfo.Speed=1900;
	NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_Shielding_Dark';
	NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed_Dark';
	NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_MeterGain_Dark';
	NPCInfo.HUDuP.HB1="Shield";
	NPCInfo.HUDuP.HB2="Flight Speed";
	NPCInfo.HUDuP.HB3="Meter Fill Rate";
	NPCInfo.HUDName="Suicide Fighter";
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
		NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters2.SkeletalMesh.Suicide_1';
		NPCInfo.bSecondLife=true;
	}
	if(NPCInfo.Level>=2){
		NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed';
		NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters2.SkeletalMesh.Suicide_2';
		NPCInfo.Speed=2100;
	}
	if(NPCInfo.Level>=3){
		NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_MeterGain';
		NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters2.SkeletalMesh.Suicide_3';
		NPCInfo.BloodIncrement=2;
	}
}


DefaultProperties
{
	Health = 5
    Begin Object Class=SkeletalMeshComponent Name=EP3Mesh
        SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Suicide_0'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Suicide_0_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale = 1.5
    End Object
	Mesh=EP3Mesh
	Components.Add(EP3Mesh)
	GroundSpeed=650
}
