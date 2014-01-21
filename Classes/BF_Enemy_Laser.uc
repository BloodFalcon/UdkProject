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
	NPCInfo.FireRate=1.0;
	NPCInfo.ProjClass=class'BF_Proj_Red_Laser';
	NPCInfo.SoulClass=class'BF_Enemy_Laser';
	NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Drone_W4';
	NPCInfo.Level=0;
	NPCInfo.Size=1.4;
	NPCInfo.Speed=300;
	//WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(EngineFire, Mesh, 'Thruster', true, vect(-1,0,0));
}

function LevelUp(byte CurLevel)
{
	NPCInfo.Level=CurLevel;
	`log("Laser Level");
	`log(NPCInfo.Level);
	NPCInfo.Level++;
	if(NPCInfo.Level==1){
		NPCInfo.FireRate=0.5;
	}else if(NPCInfo.Level>=2){
		NPCInfo.FireRate=0.1;
	}
}

DefaultProperties
{
	Health=25
    Begin Object Class=SkeletalMeshComponent Name=EP1Mesh
        SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Drone_W4'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.Drone_W4_Physics'
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
	GroundSpeed=300
}

