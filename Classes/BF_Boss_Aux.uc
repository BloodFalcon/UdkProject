class BF_Boss_Aux extends BF_Enemy_Base
	dependson(BF_Boss_Main)
	placeable;

var BF_Boss_Main BossBase;
var name Sock;
var ParticleSystem DestroyEffect;
var bool PartDestroyed;
var vector SockLoc;
var Rotator SockRot;

event PostBeginPlay()
{
    super.PostBeginPlay();
	CylinderComponent.SetActorCollision(false, false); 
	Mesh.SetActorCollision(true, true);
	NPCInfo.bCanAbsorb=false;
	//self.SpawnDefaultController();
	//self.SetMovementPhysics();
}


event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	Health-=Damage;
	if((Health<=0) && (PartDestroyed==true)){
		BossBase.Health=(BossBase.Health/2);
		if(PartDestroyed == true){
			WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(DestroyEffect, Mesh, 'Attach', true);
			WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(DestroyEffect, Mesh, 'Nose_Gun', true);
			self.Mesh.SetMaterial(0, Material'BF_Fighters.Material.PlayerGlow');
			PartDestroyed = false;
		}
		//Destroy();
	}
	else if(self.Health <= 0){
		BossBase.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
		SetTimer(0.10f, true, 'DeadHitFlash');
	}
	super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
}

function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
`log("Please Dont Die!");
return true;
}

function ProjHitFlash()
{
	if(Health >= 0){
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
}

function DeadHitFlash()
{
	if(EnemyHitFlash < 6 && EnemyHitFlash != 1 && EnemyHitFlash != 3 && EnemyHitFlash != 5){
		EnemyHitFlash++;
		self.Mesh.SetMaterial(0,Material'EngineDebugMaterials.MaterialError_Mat');
	}
	else if(EnemyHitFlash == 1 || EnemyHitFlash == 3 || EnemyHitFlash == 5){
		EnemyHitFlash++;
		self.Mesh.SetMaterial(0, Material'BF_Fighters.Material.PlayerGlow');
	}
	else{
		EnemyHitFlash = 0;
		self.Mesh.SetMaterial(0, Material'BF_Fighters.Material.PlayerGlow');
		ClearTimer('DeadHitFlash');
	}
}

event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local UDKPawn HitPawn;
	HitPawn = BFPawn(Other);
	if(HitPawn != none){}
}

event tick(float DeltaTime)
{
	if(BossBase.Health <= 0){
		self.Destroy();
	}
	if(BossBase.IsTimerActive('ProjHitFlash') && self.IsTimerActive('ProjHitFlash') == false && Health <= 0){
		SetTimer(0.10f, true, 'ProjHitFlash');
	}
	if(Health <= 0 && self.IsTimerActive('DeadHitFlash') == false){
		self.Mesh.SetMaterial(0, Material'BF_Fighters.Material.PlayerGlow');
	}
	if(BossBase.Controller == none){
		self.Destroy();
	}
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase = BossBase;
}


DefaultProperties
{
	PartDestroyed = true
	DestroyEffect = ParticleSystem'BloodFalcon.ParticleSystem.EnemyHitSmokeFire'
	Health=100
	CollisionType=COLLIDE_TouchAll
    bJumpCapable=false
    bCanJump=false
	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	Begin Object Class=SkeletalMeshComponent Name=BAMesh
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=10
    End Object 
	Mesh=BAMesh
	Components.Add(BAMesh)
}
