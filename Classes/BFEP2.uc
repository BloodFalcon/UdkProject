//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy Pawn 1
//////////////////////////

class BFEP2 extends UDKPawn 
placeable;

var bool AbsorbSuccess;

function AddDefaultInventory()
{
    InvManager.CreateInventory(class'UdkProject.BFEP2Weap');
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
	super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser); //Must Have To Process Standard Damage
}

function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	/*
	if (Super.Died(Killer, DamageType, HitLocation))
	{
		StartFallImpactTime = WorldInfo.TimeSeconds;
		bCanPlayFallingImpacts=true;
		if(ArmsMesh[0] != none)
		{
			ArmsMesh[0].SetHidden(true);
		}
		if(ArmsMesh[1] != none)
		{
			ArmsMesh[1].SetHidden(true);
		}
		SetPawnAmbientSound(None);
		SetWeaponAmbientSound(None);
		return true;
	}
	return false;
	*/
	if(AbsorbSuccess){
	BFGameInfo(WorldInfo.Game).W2 = true;
	}
	owner.Destroy();
	Self.Destroy();
	return True;
}
 
DefaultProperties
{
	Health = 10
    Begin Object Name=CollisionCylinder
        CollisionHeight=+44.000000
    End Object
 
    Begin Object Class=SkeletalMeshComponent Name=EP2Mesh
        SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.GunShip'
        //AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
        //AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        HiddenGame=FALSE
        HiddenEditor=FALSE
    End Object
 
    Mesh=EP2Mesh
 
    Components.Add(EP2Mesh)
    ControllerClass=class'UdkProject.BFAI2'
    InventoryManagerClass=class'UdkProject.BFEP1InvManager'
 
    bJumpCapable=false
    bCanJump=false
 
    GroundSpeed=200.0 //Making the bot slower than the player
	DrawScale=5
}