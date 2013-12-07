/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 12/6/2013
// Status: Beta
// Being Used: Yes
// Description: Pawn for Blood Falcon
***************************************/

class BFPawn_CleanTemp extends UDKPawn;

var bool FirstRun, CurFire, BeamFire; //Checks Firing and if Beam, FirstRun Sets Camera
var Vector PawnLoc, BFcamLoc; //Used for player bounding on the screen
//var Vector StartLine, EndLine; //Debug Line
var Vector BeamStartLoc, BeamEndLoc; //Trace
var ParticleSystemComponent AbsorbBeam;
var ParticleSystemComponent EnemyDeath;
var Actor TargetEnemy; //Enemyhit and Trace
var int AbsorbTimer;
var int EnemyAbsorbTime;
var Vector NewEnemyLoc;
var float CheckDist;
var Vector BeamOffset;
var bool BeamOffStep;
//Weapon Equip Information (BECAUSE THE DAMN STRUCTS DONT WORK)
	var int Rank;
	var int DroneRank;
	var bool DroneEquip;
	var int GunShipRank;
	var bool GunShipEquip;
	var int SuicideFighterRank;
	var bool SuicideFighterEquip;		
//Weapon Equip Information (BECAUSE THE DAMN STRUCTS DONT WORK)


event PostBeginPlay()
{
	super.PostBeginPlay();
	SetPhysics(PHYS_Walking); // wake the physics up
	CylinderComponent.SetActorCollision(false, false); // disable cylinder collision
	Mesh.SetActorCollision(true, true); // enable PhysicsAsset collision
	Mesh.SetTraceBlocking(true, true); // block traces (i.e. anything touching mesh)
	AddDefaultInventory();
}


function EnemyTimeReference() //Set The Absorbtion Time Per Enemy
{
	if(TargetEnemy.IsA('BF_Enemy_Drone')){
		EnemyAbsorbTime=200;
	}else if(TargetEnemy.IsA('BF_Enemy_GunShip')){
		EnemyAbsorbTime=200;
	}else if(TargetEnemy.IsA('BF_Enemy_SuicideFighter')){
		EnemyAbsorbTime=200;
	}else{

	}
}


function UpgradeUpdate()
{
	if(TargetEnemy.IsA('BF_Enemy_Drone')){
		Rank++;
		DroneRank = Rank;
		DroneEquip = true;
	}else if(TargetEnemy.IsA('BF_Enemy_GunShip')){
		Rank++;
		GunShipRank = Rank;
		GunShipEquip = true;
	}else if(TargetEnemy.IsA('BF_Enemy_SuicideFighter')){
		Rank++;
		SuicideFighterRank = Rank;
		SuicideFighterEquip = true;
	}else{

	}
}


function ShootUpgrades(byte FireModeNum) //Place All the upgrades to be fired here
{
	if(DroneEquip && CurFire == true)
	{
		Spawn(class'BF_Proj_Red');
	}
	
	if(GunShipEquip && CurFire == true)
	{
		Spawn(class'BF_Proj_Missile');
		//Spawn(class'BF_Proj_Player_Missile_L');
		//Spawn(class'BF_Proj_Player_Missile_R');
	}
	
	if(SuicideFighterEquip && CurFire == true)
	{
		Spawn(class'BF_Proj_Blue');
	}
}


event Tick(float DeltaTime)
{
	local Vector HitLocation, HitNormal;
	local Actor TracedEnemy;
	BeamStartLoc = Location;
	BeamEndLoc = Location + BeamOffset;

	if(AbsorbTimer<EnemyAbsorbTime) //If you havent held the Absorb for the required time yet
	{
		if(BeamFire) //Altfire = true
		{
			if(BeamOffStep){
				BeamOffset.X-=10.0;
				if(BeamOffset.X<-250){
					BeamOffStep = false;
				}
			}else{
				BeamOffset.X+=10.0;
				if(BeamOffset.X>250){
					BeamOffStep = true;
				}
			}
			TracedEnemy = Trace(HitLocation, HitNormal, BeamEndLoc, BeamStartLoc, true);
			//DrawDebugLine( BeamStartLoc, BeamEndLoc, 255, 0, 0, false);
			if(TargetEnemy == none) //If you havent tried to trace an enemy yet
			{
				if(AbsorbBeam == none)
				{
					AbsorbBeam = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'BloodFalcon.ParticleSystem.AbsorbBeam_Particle', Location, Rotation, self );
				}else{
					AbsorbBeam.SetVectorParameter('LinkBeamEnd', BeamEndLoc);
				}
				TargetEnemy = TracedEnemy;  //(BELOW) Checks to see if you are absorbing a weapon you already have
				if(TargetEnemy != none)
				{
					if((TargetEnemy.IsA('BF_Enemy_Drone') && DroneEquip) || (TargetEnemy.IsA('BF_Enemy_GunShip') && GunShipEquip) || (TargetEnemy.IsA('BF_Enemy_SuicideFighter') && SuicideFighterEquip))
					{
						TargetEnemy = none;
					}
					EnemyTimeReference();
				}
			}else{ //If you have a target enemy already, currently beaming
				CheckDist = VSize2D(Location - TargetEnemy.Location);
				if(CheckDist<750)
				{
					AbsorbTimer++;
					AbsorbBeam.SetVectorParameter('LinkBeamEnd', TargetEnemy.Location);
				}else{
					killbeam();
				}
			}
		}else{
			killbeam();
		}
	}else{
		UpgradeUpdate();	
		EnemyDeath = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'FX_VehicleExplosions.Effects.P_FX_VehicleDeathExplosion', TargetEnemy.Location, TargetEnemy.Rotation, self );
		EnemyDeath.SetVectorParameter('LinkBeamEnd', (TargetEnemy.Location+vect(0,20,50)));
		TargetEnemy.Destroy();
		killbeam();
	}
	super.Tick(DeltaTime);
}


function killbeam() //Resets The Absorb Beam
{
	if(AbsorbBeam != none)
	{
		AbsorbBeam.SetKillOnDeactivate(0, true);
		AbsorbBeam.DeactivateSystem();
		AbsorbBeam = none;
	}
	BeamOffset = vect(0,-750,0);
	BeamOffStep = true;
	TargetEnemy = none;
	AbsorbTimer = 0;
}


event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	BeamFire = false;
	if(DroneRank == Rank){
		Rank--;
		DroneRank = -1;
		DroneEquip = false;
	}else if(GunShipRank == Rank){
		Rank--;
		GunShipRank = -1;
		GunShipEquip = false;
	}else if(SuicideFighterRank == Rank){
		Rank--;
		SuicideFighterRank = -1;
		SuicideFighterEquip = false;
	}else{
		Health=0;
		self.Destroy();
	}
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
	
	if((Location.Y+750)<=out_CamLoc.Y)
	{
		PawnLoc = Location;
		PawnLoc.Y = (out_CamLoc.Y-750);
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
				//`Log("BUMP!");
				//WeaponDamage();
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
		
		CurFire = false
		BeamFire = false
		TargetEnemy = none	
		AbsorbTimer=0
		EnemyAbsorbTime=200
		GunShipRank = -1
		GunShipEquip = false
		DroneRank = -1
		DroneEquip = false
		SuicideFighterRank = -1
		SuicideFighterEquip = false
}