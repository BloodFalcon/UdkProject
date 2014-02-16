/***************************************
// Author(s): Tyler Keller
// Date: 1/17/2014
// Status: Alpha
// Being Used: Yes
// Description: An Asteroid.
// Behavior: Uses dummy AI.
***************************************/

class BF_Enemy_ThanksForPlaying extends BF_Enemy_Base;

event PostBeginPlay()
{
    super.PostBeginPlay();
	NPCInfo.bCanAbsorb=false;
}

DefaultProperties
{
	Health = 500
    Begin Object Class=SkeletalMeshComponent Name=EP3Mesh
        SkeletalMesh=SkeletalMesh'BF_Fighters2.SkeletalMesh.ThanksForPlaying'
		PhysicsAsset=PhysicsAsset'BF_Fighters2.physicsassets.ThanksForPlaying_Physics'
        HiddenGame=FALSE
        HiddenEditor=FALSE
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=false
		CollideActors=true
		Scale = 3.0
    End Object
	Mesh=EP3Mesh
	Components.Add(EP3Mesh)
	GroundSpeed=450
}
