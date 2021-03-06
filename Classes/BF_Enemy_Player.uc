/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/11/2014
// Status: Alpha
// Being Used: Yes
// Description: Holder class for default player pawn and default stats.
***************************************/

class BF_Enemy_Player extends BF_Enemy_Base;

event PostBeginPlay()
{
NPCInfo.FireRate=0.2;
NPCInfo.ProjClass=class'BF_Proj_Red_Circle';
NPCInfo.SoulClass=class'BF_Enemy_Player';
NPCInfo.SoulMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerModel_BF';
NPCInfo.Level=0;
NPCInfo.Size=0.7;
NPCInfo.Speed=1400;
}

DefaultProperties
{
	Health = 10
    Begin Object Name=CollisionCylinder
		CollisionRadius=+100.000000
		CollisionHeight=+44.000000
    End Object

    Begin Object Class=SkeletalMeshComponent Name=EP1Mesh
        SkeletalMesh=SkeletalMesh'MyMesh.SkeletalMesh.PlayerModel_BF'
		PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.Player_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale = 0.7
    End Object 
    Mesh=EP1Mesh 
    Components.Add(EP1Mesh)
	GroundSpeed=1400
}
