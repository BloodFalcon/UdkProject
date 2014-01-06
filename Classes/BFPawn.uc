/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 12/6/2013
// Status: Beta
// Being Used: Yes
// Description: Pawn for Blood Falcon
***************************************/

class BFPawn extends UDKPawn;

struct SoulVars
{
	var float FireRate;
	var SkeletalMesh SoulMesh;
	var class<BF_Proj_Base> ProjClass;
	var class<BF_Enemy_Base> SoulClass;
	var byte Level;

	structdefaultproperties
	{
		FireRate=0.5
		SoulMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Player'
		ProjClass=class'BF_Proj_Missile'
		SoulClass=class'BF_Enemy_Player'
	}
};

struct CollectedSouls
{
	var SoulVars Current;
	var SoulVars B1;
	var SoulVars B2;
	var SoulVars B3;
	var SoulVars Holder;
};	

var int TimesRun;
var bool FirstRun, CurFire, BeamFire; //Checks Firing and if Beam, FirstRun Sets Camera
var Vector PawnLoc, BFcamLoc; //Used for player bounding on the screen
//var Vector StartLine, EndLine; //Debug Line
var Vector BeamStartLoc, BeamEndLoc; //Trace
var ParticleSystemComponent AbsorbBeam;
var ParticleSystemComponent EnemyDeath;
var ParticleSystem DeathExplosion;
var SoundCue EnemyDeathSound;
var SoundCue DeathSound;
var AudioComponent BeamFireSound, BeamAbsorbSound;
var BF_Enemy_Base TargetEnemy; //Enemyhit and Trace
var int AbsorbTimer;
var int RequiredTime;
var float CheckDist;
/**Distance from center of trace*/
var Vector BeamOffset;
/**BeamOffStep Waggles Trace, Changes Direction*/
var bool BeamOffStep; 
var byte FlickerCount;
var Vector 	local_cam_loc;
var SkeletalMesh EnemyMesh;
var float FireRate;
var class<BF_Proj_Base> ProjClass;
var CollectedSouls CS;
var bool bSpace;


event PostBeginPlay()
{
	//Spawn(CS.B1,self,,vect(-6500,-800,46130),self.Rotation);
	//Spawn(CS.B2,self,,vect(-6250,-800,46130),self.Rotation);
	//Spawn(CS.B3,self,,vect(-6000,-800,46130),self.Rotation);
	super.PostBeginPlay();
	SetPhysics(PHYS_Walking); // wake the physics up
	CylinderComponent.SetActorCollision(false, false); // disable cylinder collision
	Mesh.SetActorCollision(true, true); // enable PhysicsAsset collision
	Mesh.SetTraceBlocking(true, true); // block traces (i.e. anything touching mesh)
	AddDefaultInventory();
	EnemyDeathSound = SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactExplode_Cue';
}

exec function SwitchShips()
{
	bSpace=true;
	`log("Space Pressed");
	CycleShips();
}

event Tick(float DeltaTime)
{
	local Vector HitLocation, HitNormal;
	local Actor TracedEnemyAct;
	local UDKPawn TracedEnemy;
	BeamStartLoc = Location;
	BeamEndLoc = Location + BeamOffset;
	//`log("INTERRUPTING COW: "@CS.Current);

	if(AbsorbTimer<RequiredTime) //If you havent held the Absorb for the required time yet
	{
		if(BeamFire){ //Checks if firing	
			CurFire=false;
			if(BeamOffStep){ 
				BeamOffset.X-=45.0;
				if(BeamOffset.X<-300){
					BeamOffStep = false;
				}
			}else{
				BeamOffset.X+=45.0;
				if(BeamOffset.X>300){
					BeamOffStep = true;
				}
			}
			TracedEnemyAct = Trace(HitLocation, HitNormal, BeamEndLoc, BeamStartLoc, true);
			TracedEnemy = UDKPawn(TracedEnemyAct);
			DrawBeam();
			if(TargetEnemy == none){
				TargetEnemy = BF_Enemy_Base(TracedEnemy); //Locks in your first traced enemy until you try to trace again
				if(TargetEnemy != none){
					BeamFireSound.Stop();
					BeamAbsorbSound.Play();
				}else{
					BeamFireSound.Play();
					BeamAbsorbSound.Stop();
				}
			}else{
				if(TargetEnemy==none){
					KillBeam();
				}else{
					CheckDist = VSize2D(Location - TargetEnemy.Location);
					if(CheckDist<750)
					{
						AbsorbTimer++;
						AbsorbBeam.SetVectorParameter('LinkBeamEnd', TargetEnemy.Location);
					}else{
						KillBeam();
					}
					BeamScreenBounds();
				}
			}
		}else{
			KillBeam();
		}
	}else{
		AbsorbSuccess();
	}
	super.Tick(DeltaTime);
}


function DrawBeam()
{
	if(TargetEnemy==none){
		if(AbsorbBeam == none){
			AbsorbBeam = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'BloodFalcon.ParticleSystem.AbsorbBeam_Particle', Location, Rotation, self );
			AbsorbBeam.SetVectorParameter('LinkBeamEnd', (Location + vect(0,-750,0)));
		}else{
			AbsorbBeam.SetVectorParameter('LinkBeamEnd', (Location + vect(0,-750,0)));
		}
	}
}


function FireWeaps()
{
	Spawn(ProjClass,self,,self.Location,self.Rotation);
}


function KillBeam()
{
	if(AbsorbBeam != none){
		AbsorbBeam.SetKillOnDeactivate(0, true);
		AbsorbBeam.DeactivateSystem();
		AbsorbBeam = none;
	}
	TargetEnemy = none;
	AbsorbTimer = 0;
	BeamOffset = vect(0,-750,0);
	BeamOffStep = true;
	BeamFireSound.Stop();
	BeamAbsorbSound.Stop();
}


function BeamScreenBounds() //Need to add AspectRation offset
{
	if(TargetEnemy!=none){
		if(((TargetEnemy.Location.Y-950)>=local_cam_loc.Y) || ((TargetEnemy.Location.Y+950)<=local_cam_loc.Y) || ((TargetEnemy.Location.X+975)<=local_cam_loc.X) || ((TargetEnemy.Location.X-975)>=local_cam_loc.X)){ //Deals with killing an enemy that falls off the screen
			TargetEnemy.Destroy();
			KillBeam();
		}
	}
}

function AbsorbSuccess()
{

	//local Name CSC;
	//CSC = TargetEnemy.Name;
	//Spawn Finished Absorb Emitter HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	//Call Finished Absorb sound HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	//`Log(TargetEnemy.Class);
	//`Log(TargetEnemy.Name);
	//`Log(CS.Current.Class);
	AbsorbTimer = 0;
	if(TargetEnemy.Class==CS.Current.SoulClass){
		TargetEnemy.LevelUp(CS.Current.Level);
		CS.Current = TargetEnemy.NPCInfo;
		//`log("SHOULD HAVE FUCKING DOUBLED FIRERATE");
	}else{
		if(TargetEnemy!=none){
			if(CS.B1.SoulClass==class'BF_Enemy_Player'){
				CS.B1 = CS.Current;
				CS.Current = TargetEnemy.NPCInfo;
			}else if(CS.B2.SoulClass==class'BF_Enemy_Player'){
				CS.B2 = CS.Current;
				CS.Current = TargetEnemy.NPCInfo;
			}else if(CS.B3.SoulClass==class'BF_Enemy_Player'){
				CS.B3 = CS.Current;
				CS.Current = TargetEnemy.NPCInfo;
			}else{ 

			}
			`log("BAYSSSSBITCCHESSSSSSSS");
			`log(CS.B1.SoulClass);
			`log(CS.B2.SoulClass);
			`log(CS.B3.SoulClass);
			`log(CS.Current.SoulClass);
			`log("BAYSSSSBITCCHESSSSSSSS");
				//if(CS.B1.IsA('BF_Enemy_Player')){
				//CS.B1 = CS.Current;
				//CS.Current = TargetEnemy;
		//	}else if(CS.B2.IsA('BF_Enemy_Player')){
		//		CS.B2 = CS.Current;
		//		CS.Current = TargetEnemy.Class;
		//	}else if(CS.B3.IsA('BF_Enemy_Player')){
		//		CS.B3 = CS.Current;
		//		CS.Current = TargetEnemy.Class;
		//	}else if(CS.B1.IsA('BF_Enemy_Player')){
		//		CS.B1 = CS.Current;
		//		CS.Current = TargetEnemy.Class;
		//	}else{
		//		//Dunno Just in case
			//}
		
		}}

				
	//`log("SEVEN: "@CS.Current);
	FireRate = CS.Current.FireRate;
	//`log("EIGHT: "@CS.Current);
	ProjClass = CS.Current.ProjClass;
	//`log("NINE: "@CS.Current);
	EnemyMesh = CS.Current.SoulMesh;
	//`log("TEN: "@CS.Current);
	self.Mesh.SetSkeletalMesh(CS.Current.SoulMesh);
	//`log("ELEVEN: "@CS.Current);
	self.Mesh.SetMaterial(0,Material'enginedebugmaterials.BoneWeightMaterial');
	//`log("TWELVE: "@CS.Current);
	TargetEnemy.Destroy();
	//`log("THIRTEEN: "@CS.Current);
	KillBeam();
	//`log("FOURTEEN: "@CS.Current);
}


event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
			RespawnPlayer();
}


function RespawnPlayer()
{
	BeamFire = false;
	if(FlickerCount<20){
		if(FlickerCount==0){
			Self.SetLocation(vect(-7040,-892,46130));
			KillBeam();
		}
		if(self.bHidden){
			self.SetHidden(false);
		}else{
			self.SetHidden(true);
		}
		FlickerCount++;
		SetTimer(0.3,false,'RespawnPlayer',);
	}else{
		FlickerCount = 0;
	}
}

function CycleShips()
{
	`log("DUCKDUDICKCDHAKHDFKHK");
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
	if(BeamFire == false && FireModeNum == 0){
		SetTimer(FireRate, true, 'FireWeaps');
	}
	else if(FireModeNum == 1){
		if(FlickerCount==0){
			BeamFire = true;
		}	
	}
}


simulated function StopFire(byte FireModeNum)
{
	if(FireModeNum==0){
		CurFire = false;
		ClearTimer('FireWeaps');
	}else{
		BeamFire = false;
	}
}


simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
	local_cam_loc = out_CamLoc;

	if(FirstRun)
	{
		out_CamLoc.X = (Location.X);
		out_CamLoc.Y = (Location.Y - 750);
		out_CamLoc.Z = (Location.Z + 1800);
		out_CamRot.Pitch-=16384;
		FirstRun=false;
	}	

	PawnLoc = Location;
	SetLocation(PawnLoc);
	Health=1000;

	if((Location.Z+1800)!=out_CamLoc.Z)
	{
		PawnLoc = Location;
		PawnLoc.Z = (out_CamLoc.Z-1800);
		SetLocation(PawnLoc);
	}

	if((Location.Y-875)>=out_CamLoc.Y)
	{
		PawnLoc = Location;
		PawnLoc.Y = (out_CamLoc.Y+875);
		SetLocation(PawnLoc);
	}
	
	if((Location.Y+875)<=out_CamLoc.Y)
	{
		PawnLoc = Location;
		PawnLoc.Y = (out_CamLoc.Y-875);
		SetLocation(PawnLoc);
	}

	if((Location.X+900)<=out_CamLoc.X)
	{
		PawnLoc = Location;
		PawnLoc.X = (out_CamLoc.X-900);
		SetLocation(PawnLoc);
	}
	
	if((Location.X-900)>=out_CamLoc.X)
	{
		PawnLoc = Location;
		PawnLoc.X = (out_CamLoc.X+900);
		SetLocation(PawnLoc);
	}

	BFcamLoc = out_CamLoc;
	return true;
}


event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local UDKPawn HitPawn;
	HitPawn = UDKPawn(Other);
		if(HitPawn != none)
		{
			KillBeam();
			Other.Destroy();
			WorldInfo.MyEmitterPool.SpawnEmitter(DeathExplosion, Location);
			PlaySound(DeathSound);
			TakeDamage(0, none,self.Location,vect(0,0,0),none,,);
		}
}


defaultproperties
{
		bCanJump=false
		bCanFly=false
		DeathExplosion = ParticleSystem'FX_VehicleExplosions.Effects.P_FX_VehicleDeathExplosion'
		DeathSound = SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Eject_Cue'
        Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
                bEnabled=TRUE
        End Object
        Components.Add(MyLightEnvironment)
        
		Begin Object Class=AudioComponent Name=AltFireSound
			SoundCue = SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_Berzerk_GroundLoopCue'
		End Object
		Components.Add(AltFireSound)
		BeamFireSound = AltFireSound

		Begin Object Class=AudioComponent Name=AbsorbSound
			SoundCue = SoundCue'A_Pickups_Powerups.PowerUps.A_Powerup_Berzerk_PowerLoopCue';
		End Object
		Components.Add(AbsorbSound)
		BeamAbsorbSound = AbsorbSound

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
		RequiredTime=200
		FireRate=0.5
		ProjClass=class'BF_Proj_Missile'
}