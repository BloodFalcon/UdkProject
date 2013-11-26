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
var BFHUD BFH;

event PostBeginPlay()
{
	super.PostBeginPlay();
	SetPhysics(PHYS_Flying); // wake the physics up
	// set up collision detection based on mesh's PhysicsAsset
	CylinderComponent.SetActorCollision(false, false); // disable cylinder collision
	Mesh.SetActorCollision(true, true); // enable PhysicsAsset collision
	Mesh.SetTraceBlocking(true, true); // block traces (i.e. anything touching mesh)
}

function WeaponDamage()
{
	local bool W1;
	local bool W2;
	local bool W3;
	local bool W4;
	local bool W5;
	local bool W6;

	W1 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W1;
	W2 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W2;
	W3 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W3;
	W4 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W4;
	W5 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W5;
	W6 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W6;

	if(W6){
 		BFGameInfo(WorldInfo.Game).W6 = false;
	}else if(W5){
 		BFGameInfo(WorldInfo.Game).W5 = false;
	}else if(W4){
 		BFGameInfo(WorldInfo.Game).W4 = false;
	}else if(W3){
 		BFGameInfo(WorldInfo.Game).W3 = false;
	}else if(W2){
 		BFGameInfo(WorldInfo.Game).W2 = false;
	}else if(W1){
 		BFGameInfo(WorldInfo.Game).W1 = false;
	}else{
		BFGameInfo(WorldInfo.Game).playerdead = true;
 		self.Destroy();
 }
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
  WeaponDamage();
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
	

	PawnLoc = Location;
	PawnLoc.Y-=5;
	SetLocation(PawnLoc);
	out_CamLoc.Y-=5;
	Health=1000;

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

function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	//owner.Destroy();
	Self.Destroy();
	return True;
}

event Bump (Actor Other, PrimitiveComponent OtherComp, Object.Vector HitNormal)
{
	local UDKPawn HitPawn;
	HitPawn = UDKPawn(Other);

			if(HitPawn != none)
			{
				`Log("BUMP!");
				WeaponDamage();
			}
}

defaultproperties
{
		bCanJump=false
		bCanFly=false
		LandMovementState=PlayerFlying
        Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
                bEnabled=TRUE
        End Object
        Components.Add(MyLightEnvironment)
        
        Begin Object Class=SkeletalMeshComponent Name=MyMesh
                SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Player'
				PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.Player_Physics'
				Scale=2.0
                HiddenGame=FALSE
                HiddenEditor=FALSE
				BlockNonZeroExtent=true
				BlockZeroExtent=true
				BlockActors=true
				CollideActors=true
                LightEnvironment=MyLightEnvironment
        End Object
        Components.Add(MyMesh)
        Mesh=MyMesh
		FirstRun=True
		Health=1000
		BlockRigidBody=true
		bBlockActors = true
		bCollideActors = true
		bCollideWorld = true
}