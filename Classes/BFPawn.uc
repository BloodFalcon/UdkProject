//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/5/2013
// Status: Alpha
// Being Used: Yes
// Description: Pawn for Blood Falcon
//////////////////////////

class BFPawn extends UDKPawn;

var bool FirstRun;
var Vector PawnLoc;
var Vector BFcamLoc;
var array<Weapon> MasterPlayerInventory;

event PostBeginPlay()
{
super.PostBeginPlay();
SetPhysics(PHYS_Flying);
}

simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
	if(FirstRun)
	{
		out_CamLoc.X = (Location.X);
		out_CamLoc.Y = (Location.Y - 400);
		out_CamLoc.Z = (Location.Z + 650);
		out_CamRot.Pitch-=16384;
		FirstRun=false;
	}
	out_CamLoc.Y-=10;

	if((Location.Z+650)!=out_CamLoc.Z)
	{
		PawnLoc = Location;
		PawnLoc.Z = (out_CamLoc.Z-650);
		SetLocation(PawnLoc);
	}

	if((Location.Y-750)>=out_CamLoc.Y)
	{
		PawnLoc = Location;
		PawnLoc.Y = (out_CamLoc.Y+750);
		SetLocation(PawnLoc);
	}
	
	if((Location.Y+300)<=out_CamLoc.Y)
	{
		PawnLoc = Location;
		PawnLoc.Y = (out_CamLoc.Y-300);
		SetLocation(PawnLoc);
	}

	if((Location.X+500)<=out_CamLoc.X)
	{
		PawnLoc = Location;
		PawnLoc.X = (out_CamLoc.X-500);
		SetLocation(PawnLoc);
	}
	
	if((Location.X-500)>=out_CamLoc.X)
	{
		PawnLoc = Location;
		PawnLoc.X = (out_CamLoc.X+500);
		SetLocation(PawnLoc);
	}

	BFcamLoc = out_CamLoc;

	return true;

}


defaultproperties
{
		bCanJump = false
		bCanFly = false
		LandMovementState=PlayerFlying
        Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
                bEnabled=TRUE
        End Object
        Components.Add(MyLightEnvironment)

        Begin Object Name=CollisionCylinder
                CollisionHeight=+44.000000
        End Object
        
        Begin Object Class=SkeletalMeshComponent Name=MyMesh
                SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.SuicideFighter'
                //AnimSets(0)=AnimSet'VH_Cicada.Anims.VH_Cicada_Anims'
                //AnimTreeTemplate=AnimTree'VH_Cicada.Anims.AT_VH_Cicada'
				Scale=2.0
				/*SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
                AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
                AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'*/
                HiddenGame=FALSE
                HiddenEditor=FALSE
                LightEnvironment=MyLightEnvironment
        End Object
        Components.Add(MyMesh)
        Mesh=MyMesh
		FirstRun = True
}