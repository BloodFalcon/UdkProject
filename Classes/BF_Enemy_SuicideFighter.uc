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
	NPCInfo.FireRate=0.1;
	NPCInfo.ProjClass=class'BF_Proj_Red_Circle';
	NPCInfo.SoulClass=class'BF_Enemy_SuicideFighter';
	NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.SuicideFighter_W4';
	NPCInfo.Level=0;
	NPCInfo.Size=1.5;
	NPCInfo.Speed=800;
	WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(-1,0,0));
}

function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("SF Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level==1){
		NPCInfo.FireRate=0.05;
	}else if(NPCInfo.Level>=2){
		NPCInfo.FireRate=0.01;
	}
}

DefaultProperties
{
	Health = 5
    Begin Object Class=SkeletalMeshComponent Name=EP3Mesh
        SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.SuicideFighter_W4'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.SuicideFighter_W4_Physics'
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
	GroundSpeed=800
}
