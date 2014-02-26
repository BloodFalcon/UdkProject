/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/11/2014
// Status: Alpha
// Being Used: Yes
// Description: A tough, slower moving, and high fire power enemy. 
// Behavior: Uses dummy AI.
***************************************/

class BF_Enemy_Vulcan extends BF_Enemy_Base;


event PostBeginPlay()
{
	NPCInfo.FireRate=0.05;
	NPCInfo.ProjClass=class'BF_Proj_Red_Circle';
	NPCInfo.SoulClass=class'BF_Enemy_Vulcan';
	NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerDrone_0';
	NPCInfo.Size=0.5;
	NPCInfo.Speed=1700;
	NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpeed_Dark';
	NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed_Dark';
	NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_ArmorPiercing_Dark';
	NPCInfo.HUDuP.HB1="Bullet Speed";
	NPCInfo.HUDuP.HB2="Flight Speed";
	NPCInfo.HUDuP.HB3="Armor Piercing";
	NPCInfo.HUDName="Drone";
	NPCInfo.BulletDamage=10;
	//WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(0,0,0), );
}


function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("Drone Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level>=1){
		NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpeed';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerDrone_1';
		NPCInfo.BulletSpeed=vect(0,-3000,0);
		NPCInfo.FireRate=0.033;
		NPCInfo.BulletDamage=10;
	}
	if(NPCInfo.Level>=2){
		NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerDrone_2';
		NPCInfo.Speed=1900;
		NPCInfo.FireRate=0.025;
		NPCInfo.BulletDamage=10;
		//NPCInfo.AngularWidth=75;
		//NPCInfo.Bullets=5; //TAKEN CARE OF IN PAWN
	}
	if(NPCInfo.Level>=3){
		NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_ArmorPiercing';
		NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerDrone_3';
		NPCInfo.BulletPenetration=true;
		NPCInfo.FireRate=0.025;
		NPCInfo.BulletDamage=15;
	}
}


DefaultProperties
{
	Health = 100
    Begin Object Class=SkeletalMeshComponent Name=EP2Mesh
        SkeletalMesh=SkeletalMesh'MyMesh.SkeletalMesh.Enemy_Drone'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Drone_0_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale = .5
    End Object
	Mesh=EP2Mesh
	Components.Add(EP2Mesh)
	GroundSpeed=600
}

