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
var BFHUD BFH;
var bool Missiles;
var bool CurFire;
var bool BeamFire;
var Vector StartLine;
var Vector EndLine;
var ParticleSystemComponent AbsorbBeam;
var Actor AbsorbedEnemy;

event PostBeginPlay()
{
	super.PostBeginPlay();
	SetPhysics(PHYS_Walking); // wake the physics up
	// set up collision detection based on mesh's PhysicsAsset
	CylinderComponent.SetActorCollision(false, false); // disable cylinder collision
	Mesh.SetActorCollision(true, true); // enable PhysicsAsset collision
	Mesh.SetTraceBlocking(true, true); // block traces (i.e. anything touching mesh)
	AddDefaultInventory();

}

event Tick(float DeltaTime)
{
	local Actor HitBot;
	local Vector StartLocation, EndLocation, HitLocation, HitNormal;
	local float CheckDist;


	
	StartLocation = Location;
	EndLocation = Location + vect(0,-9999,0);
	StartLine = Location;
	EndLine = EndLocation;

	super.Tick(DeltaTime);
	if(BeamFire)
	{
		HitBot = Trace( HitLocation, HitNormal, EndLocation, StartLocation, true);
		if(AbsorbedEnemy == none )
		{
			AbsorbedEnemy = HitBot;
		}
		else
		{
			EndLine = AbsorbedEnemy.Location;
			CheckDist = VSize2D(Location - AbsorbedEnemy.Location);
			if(AbsorbedEnemy != none && AbsorbedEnemy.IsA('BF_Enemy_GunShip') && CheckDist < 1000.0)
			{
				`log("Hit Enemy with Trace");
				Missiles = true;
				if(AbsorbBeam == none)
				{
					AbsorbBeam = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'BloodFalcon.ParticleSystem.AbsorbBeam_Particle', Location, Rotation, self );

				}
				
				if(AbsorbBeam != none && AbsorbedEnemy != none)
				{
					AbsorbBeam.SetVectorParameter('LinkBeamEnd', AbsorbedEnemy.Location);
				}
			}
			else if(AbsorbBeam != none)
			{
				AbsorbBeam.SetKillOnDeactivate(0, true);
				AbsorbBeam.DeactivateSystem();
				AbsorbBeam = none;
				AbsorbedEnemy = none;
			}
		}
	}
	else if(AbsorbBeam != none)
	{
		AbsorbBeam.SetKillOnDeactivate(0, true);
		AbsorbBeam.DeactivateSystem();
		AbsorbBeam = none;
		AbsorbedEnemy = none;
	}
	DrawDebugLine( StartLine, EndLine, 255, 0, 0, false);
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
	`log("Damage");
}

simulated function Rotator GetAdjustedAimFor(Weapon W, vector StartFireLoc)
{
	local Vector SocketLocation;
	local Rotator SocketRotation;
	local Player_Weap_Basic PlayerWeap;
	local SkeletalMeshComponent WeaponSkeletalMeshComponent;

	PlayerWeap = Player_Weap_Basic(Weapon);
	if (PlayerWeap != None)
	{
		WeaponSkeletalMeshComponent = SkeletalMeshComponent(PlayerWeap.Mesh);
		if (WeaponSkeletalMeshComponent != None && WeaponSkeletalMeshComponent.GetSocketByName(PlayerWeap.MuzzleSocketName) != None)
		{			
			WeaponSkeletalMeshComponent.GetSocketWorldLocationAndRotation(PlayerWeap.MuzzleSocketName, SocketLocation, SocketRotation);
			return SocketRotation;
		}
	}

	return Rotation;
}

function AddDefaultInventory()
{
	InvManager.CreateInventory(class'Player_Weap_Basic');
	InvManager.CreateInventory(class'Player_Weap_Red');
}

simulated function StartFire(byte FireModeNum)
{	
	CurFire = true;
	if(CurFire == true && BeamFire == false && FireModeNum == 0)
	{
		Player_Weap_Basic(Weapon).StartFire(FireModeNum);
		SetTimer(0.1f, true, 'ShootUpgrades');
	}
	else if(FireModeNum == 1){
		BeamFire = true;
		//Player_Weap_Basic(Weapon).StartFire(FireModeNum);		
	}
}

simulated function StopFire(byte FireModeNum)
{
	CurFire = false;
	BeamFire = false;
	Player_Weap_Basic(Weapon).StopFire(FireModeNum);
	ClearTimer('ShootUpgrades');
}

function ShootUpgrades(byte FireModeNum)
{
	if(Missiles == true && CurFire == true)
	{
		Spawn(class'BF_Proj_Missile');
	}
}

simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
	if(FirstRun)
	{
		out_CamLoc.X = (Location.X);
		out_CamLoc.Y = (Location.Y - 750);
		out_CamLoc.Z = (Location.Z + 650);
		out_CamRot.Pitch-=16384;
		FirstRun=false;
	}	

	PawnLoc = Location;
	SetLocation(PawnLoc);
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

	if((Location.X+600)<=out_CamLoc.X)
	{
		PawnLoc = Location;
		PawnLoc.X = (out_CamLoc.X-600);
		SetLocation(PawnLoc);
	}
	
	if((Location.X-600)>=out_CamLoc.X)
	{
		PawnLoc = Location;
		PawnLoc.X = (out_CamLoc.X+600);
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

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
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
		//LandMovementState=PlayerFlying
        Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
                bEnabled=TRUE
        End Object
        Components.Add(MyLightEnvironment)
        
        Begin Object Class=SkeletalMeshComponent Name=MyMesh
                SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Player'
				PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.Player_Physics'
				Scale=1.5
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
		GroundSpeed = 700
		AccelRate = 5600
		InventoryManagerClass=class'UdkProject.Player_Inventory'
		Missiles = false;
		CurFire = false;
		BeamFire = false;
		AbsorbedEnemy = none;
}