//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy Pawn 1
//////////////////////////

class BFEP1 extends UDKPawn 
placeable;

var bool AbsorbSuccess;
var BFPawn OurPlayer;

function AddDefaultInventory()
{
    InvManager.CreateInventory(class'UdkProject.BFEP1Weap');
}
 
event PostBeginPlay()
{
    super.PostBeginPlay();
    AddDefaultInventory(); //GameInfo calls it only for players, so we have to do it ourselves for AI.
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(Damage == 2)
	{
	SetDrawScale((DrawScale-0.5));
	AbsorbSuccess = true;
	}

	super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);  //Must Have To Process Standard Damage
}

simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
	local Vector CamLoc;
	CamLoc = OurPlayer.BFcamLoc;

	if((Location.Y-750)>=CamLoc.Y)
	{
		self.Destroy();
	}
	return true;
}

function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	if(AbsorbSuccess){
	BFGameInfo(WorldInfo.Game).W1 = true;
	}
	owner.Destroy();
	Self.Destroy();
	return True;
}

/*event Bump (Actor Other, PrimitiveComponent OtherComp, Object.Vector HitNormal)
{
	local UDKPawn HitPawn;
	HitPawn = UDKPawn(Other);

			if(HitPawn != none)
			{
				`Log("Call Weapon Damage");
				OurPlayer.WeaponDamage();
			}
}*/

DefaultProperties
{
	
	Health = 10
    Begin Object Name=CollisionCylinder
        CollisionHeight=+128.000000
    End Object
 
    Begin Object Class=SkeletalMeshComponent Name=EP1Mesh
        SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.GunShip'
        //AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
        //AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        HiddenGame=FALSE
        HiddenEditor=FALSE
    End Object
 
    Mesh=EP1Mesh
 
    Components.Add(EP1Mesh)
    ControllerClass=class'UdkProject.BFAI1'
    InventoryManagerClass=class'UdkProject.BFEP1InvManager'
 
    bJumpCapable=false
    bCanJump=false

	BlockRigidBody=true
	bCollideActors=true
	bBlockActors=true
	CollisionType=COLLIDE_BlockAll
	CylinderComponent=CollisionCylinder
 
    GroundSpeed=200.0 //Making the bot slower than the player
<<<<<<< HEAD
	DrawScale = 5
=======
	DrawScale = 1
>>>>>>> 8d550b8fe8484bce7a0677d4f2a5b5717d45acb6
}