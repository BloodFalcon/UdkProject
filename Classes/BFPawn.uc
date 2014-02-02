/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Pawn for Blood Falcon. Controls most aspects of the game.
***************************************/

class BFPawn extends UDKPawn;

struct UpHUD
{
	var Texture2D HBay1;
	var Texture2D HBay2;
	var Texture2D HBay3;
	var string HB1;
	var string HB2;
	var string HB3;

	structdefaultproperties
	{
		HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_IconTemplate'
		HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_IconTemplate'
		HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_IconTemplate'
		HB1="Empty"
		HB2="Empty"
		HB3="Empty"
	}
};

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
	var float BloodDecrement;
	var float BloodIncrement;
	var bool bSecondLife;
	var float BulletSpeed;
	var byte BulletSpread;
	var float BulletDamage;
	var bool BulletPenetration;
	var UpHUD HUDuP;
	var string HUDName;

	structdefaultproperties
	{
		FireRate=0.4
		SoulMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.Player'
		ProjClass=class'BF_Proj_Red_Circle'
		SoulClass=class'BF_Enemy_EmptyBay'
		Size=1.5
		Speed=1400
		bFXEnabled=true
		Closed=false
		bCanAbsorb=true
		BloodDecrement=2
		BloodIncrement=1
		bSecondLife=false
		BulletSpeed=1500
		BulletSpread=1
		BulletDamage=1
		BulletPenetration=false
		HUDName="Falcon"
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
var ParticleSystemComponent Shield;
var ParticleSystem ShieldSystem;
var ParticleSystem DeathExplosion, ShieldDeathExplosion;
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
var CollectedSouls CS, DefaultCS;
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
	//BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter=100; //.0115 .0164
	Health=100000;
	Mesh.SetScale(CS.Current.Size);
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
					if(TargetEnemy.NPCInfo.bCanAbsorb==false || (CS.Current.Level>=3 && CS.Current.SoulClass==TargetEnemy.Class)){ //Ignores Asteroids and Maxed out enemies
						TargetEnemy=none;	
					}else if(CS.B1.SoulClass!=class'BF_Enemy_EmptyBay' && CS.B2.SoulClass!=class'BF_Enemy_EmptyBay' && CS.B3.SoulClass!=class'BF_Enemy_EmptyBay' && CS.Current.SoulClass!=TargetEnemy.Class){
						TargetEnemy=none;
					}else if(CS.B1.SoulClass==TargetEnemy.Class && CS.Current.SoulClass!=TargetEnemy.Class){
						TargetEnemy=none;
					}else if(CS.B2.SoulClass==TargetEnemy.Class && CS.Current.SoulClass!=TargetEnemy.Class){
						TargetEnemy=none;
					}else if(CS.B3.SoulClass==TargetEnemy.Class && CS.Current.SoulClass!=TargetEnemy.Class){
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

		if(CS.Current.HUDuP.HB1=="Shield"){
			if(CS.Current.HUDuP.HBay1==Texture2D'BF_HUD_Assets.Textures.BF_HUD_Shielding'){
				ShieldSystem=ParticleSystem'BF_Fighters.ParticleSystem.SuperShield';
			}else{
				ShieldSystem=ParticleSystem'BF_Fighters.ParticleSystem.Shield';
			}
		}else if(CS.Current.HUDuP.HB2=="Shield"){
			if(CS.Current.HUDuP.HBay2==Texture2D'BF_HUD_Assets.Textures.BF_HUD_Shielding'){
				ShieldSystem=ParticleSystem'BF_Fighters.ParticleSystem.SuperShield';
			}else{
				ShieldSystem=ParticleSystem'BF_Fighters.ParticleSystem.Shield';
			}
		}else if(CS.Current.HUDuP.HB3=="Shield"){
			if(CS.Current.HUDuP.HBay3==Texture2D'BF_HUD_Assets.Textures.BF_HUD_Shielding'){
				ShieldSystem=ParticleSystem'BF_Fighters.ParticleSystem.SuperShield';
			}else{
				ShieldSystem=ParticleSystem'BF_Fighters.ParticleSystem.Shield';
			}
		}else{
			ShieldSystem=ParticleSystem'BF_Fighters.ParticleSystem.Shield';
		}

	if((BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter>2 && Shield==none) || (ShieldSystem!=Shield.Template && Shield!=none && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter>2)){
		if(Shield!=none){
			Shield.SetKillOnDeactivate(0,true);
			Shield.DeactivateSystem();
			Shield=none;
		}
		Shield = new class'ParticleSystemComponent';
		Shield.SetTemplate(ShieldSystem);
		Shield.SetScale(4);
		Shield.SetAbsolute(false, True, True);
		Shield.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
		Shield.bUpdateComponentInTick = true;
		self.AttachComponent(Shield);
	}
	if(CS.B1.SoulClass!=class'BF_Enemy_EmptyBay' && CS.B2.SoulClass!=class'BF_Enemy_EmptyBay' && CS.B3.SoulClass!=class'BF_Enemy_EmptyBay'){
		CS.BayOpen=false;
	}
	HideBays();
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS=CS;
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BFPawnInfo=self;
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
	local BF_Proj_Base Proj;

	if(ProjClass!=none){
		Proj = Spawn(ProjClass,self,,self.Location,self.Rotation);
		Proj.Speed=CS.Current.BulletSpeed;
		Proj.Damage*=CS.Current.BulletDamage;
		WorldInfo.MyEmitterPool.ClearPoolComponents(false);
	}
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
	if(FlickerCount<10){
		if(FlickerCount==0){
			if(Shield!=none){
				WorldInfo.MyEmitterPool.SpawnEmitter(ShieldDeathExplosion, Location);
				Shield.SetKillOnDeactivate(0,true);
				Shield.DeactivateSystem();
				Shield=none;
			}else{
				WorldInfo.MyEmitterPool.SpawnEmitter(DeathExplosion, Location); 
			}
			PlaySound(DeathSound);
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
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillCount=0;
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter>0){
		if(CS.Current.bSecondLife){
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter-=5;
		}else{
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter=0;
		}
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
		StopFire(0);
		StopFire(1);
		Self.SetLocation(vect(-7040,-892,46130));
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
		Shield.SetKillOnDeactivate(0,true);
		Shield.DeactivateSystem();
		Shield=none;
		ProjClass=none;
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
			CS.Current=DefaultCS.Current;
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
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter=1;
	if(TargetEnemy.Class==CS.Current.SoulClass){
		TargetEnemy.LevelUp(CS.Current.Level);
		CS.Current = TargetEnemy.NPCInfo;
		if(CS.BayNumber==1){
			CS.B1=CS.Current;
		}else if(CS.BayNumber==2){
			CS.B2=CS.Current;
		}else if(CS.BayNumber==3){
			CS.B3=CS.Current;
		}
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
	//BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodDecrement=CS.Current.BloodDecrement;
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodIncrement=CS.Current.BloodIncrement;
	FireRate = CS.Current.FireRate;
	ProjClass = CS.Current.ProjClass;
	self.GroundSpeed = CS.Current.Speed;
	self.Mesh.SetSkeletalMesh(CS.Current.SoulMesh);
	self.Mesh.SetScale(CS.Current.Size);
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
	if(CS.B1.SoulClass!=class'BF_Enemy_EmptyBay' && CS.B1.SoulClass!=class'BF_Enemy_ClosedBay' && CS.B1.Closed==false && CS.BayNumber!=1){
		CS.Current=CS.B1;
		CS.BayNumber=1;
		UpdatePlayer();
	}else{
		//Flash BloodMeter
	}
}


exec function SwitchBay2()
{
	if(CS.B2.SoulClass!=class'BF_Enemy_EmptyBay' && CS.B2.SoulClass!=class'BF_Enemy_ClosedBay' && CS.B2.Closed==false && CS.BayNumber!=2){
		CS.Current=CS.B2;
		CS.BayNumber=2;
		UpdatePlayer();
	}else{
		//Flash BloodMeter
	}
}


exec function SwitchBay3()
{
	if(CS.B3.SoulClass!=class'BF_Enemy_EmptyBay' && CS.B3.SoulClass!=class'BF_Enemy_ClosedBay' && CS.B3.Closed==false && CS.BayNumber!=3){
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
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).ScreenBounds = out_CamLoc;

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
	local BF_Enemy_Base HitPawn;
	HitPawn = BF_Enemy_Base(Other);
	if(HitPawn != none)
	{
		if(HitPawn.NPCInfo.bCanAbsorb && FlickerCount==0){
			Other.Destroy();
		}
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).R==false){
			KillBeam();
			WorldInfo.MyEmitterPool.SpawnEmitter(DeathExplosion, Location);
			PlaySound(DeathSound);
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter=0;
			RespawnPlayer();
		}
	}
}


defaultproperties
{
		bCanJump=false
		bCanFly=false
		DeathExplosion = ParticleSystem'FX_VehicleExplosions.Effects.P_FX_VehicleDeathExplosion'
		DeathSound = SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Eject_Cue'
		ShieldDeathExplosion = ParticleSystem'Pickups.Flag.Effects.P_Flagbase_FlagCaptured_Red'
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
		FireRate=0.2
		ProjClass=class'BF_Proj_Red_Circle'
}