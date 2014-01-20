class BF_Enemy_Base extends UDKPawn
	dependson(BFPawn)
	placeable;

var int EnemyAbsorbTime;
var ParticleSystem EngineFire, DeathExplosion, ProjHitEffect, AbsorbRed, AbsorbYellow, AbsorbGreen;
var ParticleSystemComponent AbsorbRing;
var SoundCue DeathSound;
//var class<BF_Proj_Base> ProjClass;
//var float FireRate;
//var byte Level;
var SoulVars NPCInfo;
var byte EnemyHitFlash;

event PostBeginPlay()
{
    super.PostBeginPlay();
	CylinderComponent.SetActorCollision(false, false); 
}


event tick(float DeltaTime)
{
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GameSpeed<1){
		if(AbsorbRing==none){
			if(WorldInfo.NetMode != NM_DedicatedServer){
				AbsorbRing = new class'ParticleSystemComponent';
					AbsorbRing.SetTemplate(AbsorbRed);
				AbsorbRing.SetScale(0.6);
				AbsorbRing.SetAbsolute(false, True, True);
				AbsorbRing.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
				AbsorbRing.bUpdateComponentInTick = true;
				AttachComponent(AbsorbRing);
			}
		}
	}else if(AbsorbRing!=none){
		AbsorbRing.SetKillOnDeactivate(0,true);
		AbsorbRing.DeactivateSystem();
		AbsorbRing=none;
	}
}


function LevelUp(byte CurLevel){}


event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter<10 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GameSpeed>=1 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).R==false){
		BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter+=1;
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter<10 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter>=9.5){
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter=10;	
		}
	}
	SetTimer(0.10, true, 'ProjHitFlash');
	super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);  //Must Have To Process Standard Damage
}

function ProjHitFlash()
{
	if(EnemyHitFlash < 6 && EnemyHitFlash != 1 && EnemyHitFlash != 3 && EnemyHitFlash != 5){
		EnemyHitFlash++;
		self.Mesh.SetMaterial(0,Material'EngineDebugMaterials.MaterialError_Mat');
	}
	else if(EnemyHitFlash == 1 || EnemyHitFlash == 3 || EnemyHitFlash == 5){
		EnemyHitFlash++;
		self.Mesh.SetMaterial(0, none);
	}
	else{
		EnemyHitFlash = 0;
		ClearTimer('ProjHitFlash');
	}
}


function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	owner.Destroy();
	Self.Destroy();
	WorldInfo.MyEmitterPool.SpawnEmitter(DeathExplosion, Location);
	PlaySound(DeathSound);
	return True;
}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local UDKPawn HitPawn;
	HitPawn = BFPawn(Other);

			if(HitPawn != none)
			{
				//`Log("Touch Player");
				WorldInfo.MyEmitterPool.SpawnEmitter(DeathExplosion, Location);
				PlaySound(DeathSound);
				self.Destroy();
			}
			else
			{
				//`log("Touch Enemy");
			}
}

DefaultProperties
{
	EngineFire = ParticleSystem'BloodFalcon.ParticleSystem.Gunship_Exhaust'
	DeathExplosion = ParticleSystem'FX_VehicleExplosions.Effects.P_FX_VehicleDeathExplosion'
	ProjHitEffect = ParticleSystem'BloodFalcon.ParticleSystem.EnemyHitSmokeFire'
	DeathSound = SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Eject_Cue'
	AbsorbRed = ParticleSystem'BF_Robert.ParticleSystem.AbsorbRed'
	AbsorbYellow = ParticleSystem'BF_Robert.ParticleSystem.AbsorbYellow'
	AbsorbGreen = ParticleSystem'BF_Robert.ParticleSystem.AbsorbGreen'
  //  Begin Object Name=CollisionCylinder
		//CollisionRadius=+100.000000
		//CollisionHeight=+44.000000
  //  End Object

  //  Begin Object Class=SkeletalMeshComponent Name=EP1Mesh
  //      SkeletalMesh=SkeletalMesh'BloodFalcon.SkeletalMesh.GunShip'
		//PhysicsAsset=PhysicsAsset'BloodFalcon.SkeletalMesh.GunShip_Physics'
  //      HiddenGame=FALSE
  //      HiddenEditor=FALSE
		//BlockNonZeroExtent=true
		//BlockZeroExtent=true
		//BlockActors=false
		//CollideActors=true
  //  End Object 
  //  Mesh=EP1Mesh 
  //  Components.Add(EP1Mesh)
    ControllerClass=class'UdkProject.BF_AI_Gunship'
    bJumpCapable=false
    bCanJump=false
	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	CollisionType=COLLIDE_TouchAll
	CylinderComponent=CollisionCylinder
	EnemyHitFlash=0;
}
