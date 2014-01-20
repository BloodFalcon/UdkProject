/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Pawn for Blood Falcon. Controls the absorbtion mechanic, life/death of the player, and firing projectiles from the player.
***************************************/

class BFPawn extends UDKPawn;

struct SoulVars
{
	var float FireRate;
	var SkeletalMesh SoulMesh;
	var class<BF_Proj_Base> ProjClass;
	var class<BF_Enemy_Base> SoulClass;
	var byte Level;
	var float Size;
	var float Speed;
	var bool bFXEnabled;
	var bool Closed;
	var bool bCanAbsorb;

	structdefaultproperties
	{
		FireRate=0.4
		SoulMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Player'
		ProjClass=class'BF_Proj_Red_Circle'
		SoulClass=class'BF_Enemy_EmptyBay'
		Size=1.5
		Speed=700
		bFXEnabled=true
		Closed=false
		bCanAbsorb=true
	}
};

struct CollectedSouls
{
	var SoulVars Current;
	var SoulVars B1;
	var SoulVars B2;
	var SoulVars B3;
	var SoulVars Holder;
	var byte BayNumber;
	var bool BayOpen;

	structdefaultproperties
	{
		BayNumber=1
		BayOpen=true
	}
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
var BF_Enemy_Base Bay1,Bay2,Bay3;


event PostBeginPlay()
{
	super.PostBeginPlay();
	Mesh.SetActorCollision(true, true); // enable PhysicsAsset collision
	Mesh.SetTraceBlocking(true, true); // block traces (i.e. anything touching mesh)
	EnemyDeathSound = SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactExplode_Cue';
}


event Tick(float DeltaTime)
{
	local Vector HitLocation, HitNormal;
	local Actor TracedEnemyAct;
	local UDKPawn TracedEnemy;
	Health=100000;
	Mesh.SetScale(CS.Current.Size);
	GroundSpeed=(CS.Current.Speed*2);
	BeamStartLoc = Location;
	BeamEndLoc = Location + BeamOffset;
	
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GameSpeed<1){
		CustomTimeDilation=((1/(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GameSpeed)*0.75)); //Edit the decimal to change absorb flight speed
	}else{
		CustomTimeDilation=1;
	}

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
			if(TargetEnemy==none){
				TargetEnemy = BF_Enemy_Base(TracedEnemy); //Locks in your first traced enemy until you try to trace again //TargetEnemy.Class.Name!='BF_Enemy_Asteroid'	
				if(TargetEnemy!=none){
					if(TargetEnemy.Class==class'BF_Enemy_Asteroid' || (CS.Current.Level>=3 && CS.Current.SoulClass==TargetEnemy.Class)){ //Ignores Asteroids and Maxed out enemies
						TargetEnemy=none;	
					}else if(CS.B1.SoulClass!=class'BF_Enemy_EmptyBay' && CS.B2.SoulClass!=class'BF_Enemy_EmptyBay' && CS.B3.SoulClass!=class'BF_Enemy_EmptyBay' && CS.Current.SoulClass!=TargetEnemy.Class){
						TargetEnemy=none;
					}else{
						BeamFireSound.Stop();
						BeamAbsorbSound.Play();
					}
				}else{
					BeamFireSound.Play();
					BeamAbsorbSound.Stop();
				}
			}else{
				CheckDist = VSize2D(Location - TargetEnemy.Location);
				if(CheckDist<750)
				{
					AbsorbTimer++; //=GetSystemTime(,,,,,,CustomTimeDilation,); ///TIMED THINGS HERE
					AbsorbBeam.SetVectorParameter('LinkBeamEnd', TargetEnemy.Location);
				}else{
					KillBeam();
				}
				BeamScreenBounds();
			}
		}else{
			KillBeam();
		}
	}else{
		BeamFire=false;
		AbsorbTimer=0;
		ClearTimer('FireWeaps');
		AbsorbSuccess();
	}
	HideBays();
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS=CS;
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
	WorldInfo.MyEmitterPool.ClearPoolComponents(false);
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


event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).R==false){
		RespawnPlayer();
	}
}


function RespawnFlicker()
{
	if(FlickerCount<20){
		if(FlickerCount==0){
			WorldInfo.MyEmitterPool.SpawnEmitter(DeathExplosion, Location);
			PlaySound(DeathSound);
			Self.SetLocation(vect(-7040,-892,46130));
			KillBeam();
		}
		if(self.bHidden){
			self.SetHidden(false);
		}else{
			self.SetHidden(true);
		}
		FlickerCount++;
		SetTimer(0.3,false,'RespawnFlicker',);
	}else{
		FlickerCount=0;
		BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).R=false;
	}
}


function RespawnPlayer()
{
	BeamFire = false;
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter>0){
		BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter = 0;
	}else{
		if(CS.BayNumber==1){
			CS.B1.SoulClass=class'BF_Enemy_ClosedBay';
			CS.B1.Closed=true;
		}else if(CS.BayNumber==2){
			CS.B2.SoulClass=class'BF_Enemy_ClosedBay';
			CS.B2.Closed=true;
		}else if(CS.BayNumber==3){
			CS.B3.SoulClass=class'BF_Enemy_ClosedBay';
			CS.B3.Closed=true;
		}else {

		}
		NewShipChooser();
	}
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).R=true;
	RespawnFlicker();
}


function NewShipChooser()
{
	if(CS.B1.SoulClass==class'BF_Enemy_ClosedBay' && CS.B2.SoulClass==class'BF_Enemy_ClosedBay' && CS.B3.SoulClass==class'BF_Enemy_ClosedBay'){
		BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PlayerDead=true;
		Mesh.SetHidden(true);
	}else{
		if(CS.B1.SoulClass!=class'BF_Enemy_ClosedBay' && CS.B1.SoulClass!=class'BF_Enemy_EmptyBay'){
			CS.Current=CS.B1;
			CS.BayNumber = 1;
		}else if(CS.B2.SoulClass!=class'BF_Enemy_ClosedBay' && CS.B2.SoulClass!=class'BF_Enemy_EmptyBay'){
			CS.Current=CS.B2;
			CS.BayNumber = 2;
		}else if(CS.B3.SoulClass!=class'BF_Enemy_ClosedBay' && CS.B3.SoulClass!=class'BF_Enemy_EmptyBay'){
			CS.Current=CS.B3;
			CS.BayNumber = 3;
		}else{
			CS.Current.FireRate=0.01;
			CS.Current.ProjClass=class'BF_Proj_Red_Circle';
			CS.Current.SoulClass=class'BF_Enemy_Player';
			CS.Current.SoulMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Player';
			CS.Current.Level=0;
			CS.Current.Size=1.5;
			CS.Current.Speed=1400;
			if(CS.B1.SoulClass==class'BF_Enemy_EmptyBay'){
				CS.BayNumber = 1;
			}else if(CS.B2.SoulClass==class'BF_Enemy_EmptyBay'){
				CS.BayNumber = 2;
			}else if(CS.B3.SoulClass==class'BF_Enemy_EmptyBay'){
				CS.BayNumber = 3;
			}else{

			}
		}
		UpdatePlayer();
	}
}


function HideBays()
{
	if(Bay1!=none){
		if(CS.B1.Closed || CS.B1.SoulClass==class'BF_Enemy_EmptyBay' || CS.B1.SoulClass==class'BF_Enemy_ClosedBay'){// || CS.BayNumber==1){
			Bay1.SetHidden(true);
		}else{
			Bay1.SetHidden(false);
		}
	}
	if(Bay2!=none){
		if(CS.B2.Closed || CS.B2.SoulClass==class'BF_Enemy_EmptyBay' || CS.B2.SoulClass==class'BF_Enemy_ClosedBay'){// || CS.BayNumber==2){
			Bay2.SetHidden(true);
		}else{
			Bay2.SetHidden(false);
		}
	}
	if(Bay3!=none){
		if(CS.B3.Closed || CS.B3.SoulClass==class'BF_Enemy_EmptyBay' || CS.B3.SoulClass==class'BF_Enemy_ClosedBay'){// || CS.BayNumber==3){
			Bay3.SetHidden(true);
		}else{
			Bay3.SetHidden(false);
		}
	}
}


function AbsorbSuccess()
{
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter=0;
	if(TargetEnemy.Class==CS.Current.SoulClass){
		TargetEnemy.LevelUp(CS.Current.Level);
		CS.Current = TargetEnemy.NPCInfo;
	}else{
		if(CS.B1.SoulClass==class'BF_Enemy_EmptyBay'){
			CS.Current=TargetEnemy.NPCInfo;
			CS.B1=TargetEnemy.NPCInfo;
			CS.BayNumber=1;
			UpdateHUDBay();
		}else if(CS.B2.SoulClass==class'BF_Enemy_EmptyBay'){
			CS.Current=TargetEnemy.NPCInfo;
			CS.B2=TargetEnemy.NPCInfo;
			CS.BayNumber=2;
			UpdateHUDBay();
		}else if(CS.B3.SoulClass==class'BF_Enemy_EmptyBay'){
			CS.Current=TargetEnemy.NPCInfo;
			CS.B3=TargetEnemy.NPCInfo;
			CS.BayNumber=3;
			UpdateHUDBay();
		}else{

		}
	}
	UpdatePlayer();
	TargetEnemy.Destroy();
	KillBeam();
}


function UpdatePlayer()
{
	FireRate = CS.Current.FireRate;
	ProjClass = CS.Current.ProjClass;
	self.GroundSpeed = CS.Current.Speed;
	self.Mesh.SetSkeletalMesh(CS.Current.SoulMesh);
	self.Mesh.SetScale(CS.Current.Size);
	self.Mesh.SetMaterial(0,Material'EngineDebugMaterials.MaterialError_Mat');
}


function UpdateHUDBay()
{
	if(CS.BayNumber==1){
		Bay1 = Spawn(CS.B1.SoulClass,self,,vect(-5900,-775,46130),self.Rotation);
	}
	if(CS.BayNumber==2){
		Bay2 = Spawn(CS.B2.SoulClass,self,,vect(-5650,-775,46130),self.Rotation);
	}
	if(CS.BayNumber==3){
		Bay3 = Spawn(CS.B3.SoulClass,self,,vect(-5400,-775,46130),self.Rotation);
	}
}


exec function NextShip()
{
	//Do whatever you want with this bitch
}


exec function SwitchBay1()
{
	if(CS.B1.SoulClass!=class'BF_Enemy_EmptyBay' || CS.B1.SoulClass!=class'BF_Enemy_ClosedBay' || CS.B1.Closed){
		CS.Current=CS.B1;
		CS.BayNumber=1;
		UpdatePlayer();
	}else{
		//Flash BloodMeter
	}
}


exec function SwitchBay2()
{
	if(CS.B2.SoulClass!=class'BF_Enemy_EmptyBay' || CS.B2.SoulClass!=class'BF_Enemy_ClosedBay' || CS.B2.Closed){
		CS.Current=CS.B2;
		CS.BayNumber=2;
		UpdatePlayer();
	}else{
		//Flash BloodMeter
	}
}


exec function SwitchBay3()
{
	if(CS.B3.SoulClass!=class'BF_Enemy_EmptyBay' || CS.B3.SoulClass!=class'BF_Enemy_ClosedBay' || CS.B3.Closed){
		CS.Current=CS.B3;
		CS.BayNumber=3;
		UpdatePlayer();
	}else{
		//Flash BloodMeter
	}
}//KeyBinds


simulated function StartFire(byte FireModeNum)
{	
	CurFire = true;
	if(BeamFire == false && FireModeNum == 0){
		Spawn(ProjClass,self,,self.Location,self.Rotation);
		SetTimer(FireRate, true, 'FireWeaps');
	}
	else if(FireModeNum == 1 && false==IsTimerActive('FireWeaps')){
		if(FlickerCount==0){
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BulletTime(1);
			if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter>=10)//Comment out if statement if you want to absorb without full bloodmeter
			{//Comment out if statement if you want to absorb without full bloodmeter
				BeamFire = true;
			}//Comment out if statement if you want to absorb without full bloodmeter
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
		BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BulletTime(2);
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
			//if(Other.Class==class<BF_Boss_Aux>){
				Other.Destroy();
				KillBeam();
				WorldInfo.MyEmitterPool.SpawnEmitter(DeathExplosion, Location);
				PlaySound(DeathSound);
				if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).R==false){
					BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter=0;
					RespawnPlayer();
				}
			//}
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
		Health=100000
		BlockRigidBody=true
		bBlockActors = true
		bCollideActors = true
		bCollideWorld = true
		CollisionType=COLLIDE_TouchAll
		CylinderComponent=CollisionCylinder
		GroundSpeed = 1400
		AccelRate = 10000
		InventoryManagerClass=class'UdkProject.Player_Inventory'
		
		CurFire = false
		BeamFire = false
		TargetEnemy = none	
		AbsorbTimer=0
		RequiredTime=100
		FireRate=0.01
		ProjClass=class'BF_Proj_Red_Circle'
}