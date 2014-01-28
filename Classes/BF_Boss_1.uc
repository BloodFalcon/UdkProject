class BF_Boss_1 extends BF_Boss_Main;

event PostBeginPlay()
{
	super.PostBeginPlay();
	CylinderComponent.SetActorCollision(false, false); 
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	SetTimer(0.10, true, 'ProjHitFlash');
	Health-=Damage;
	if(Health<=0){
		BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Boss1Dead = true;
		`log("Destroyed Boss");
		Destroy();
	}
	else if(self.Health <= 625){
		SetTimer(0.10f, true, 'DeadHitFlash');
	}
	super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
}

function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Boss1Dead = true;
	`log("Destroyed Boss");
	Destroy();
	return true;
}

function ProjHitFlash()
{
	if(Health >=626){
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


function tick(float DeltaTime)
{
	`log(self.Health);
	if(Health <= 625 && self.IsTimerActive('DeadHitFlash') == false && Controller.IsInState('FinalPhase')){
		self.Mesh.SetMaterial(0, Material'BF_Fighters.Material.PlayerGlow');
	}
	if(Controller.IsInState('PhaseTwo')){
		GroundSpeed = 2000;
	}
	if(Controller.IsInState('FinalPhase')){
		GroundSpeed = 3500;
	}
}


DefaultProperties
{
	Health=10000
	Begin Object Class=SkeletalMeshComponent Name=M1Mesh
		SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.LVL1_Boss_Body'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.LVL1_Boss_Body_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=5
    End Object 
	Mesh=M1Mesh
	Components.Add(M1Mesh)
    ControllerClass=class'UdkProject.BF_AI_Boss_1'
    bJumpCapable=false
    bCanJump=false
	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	CollisionType=COLLIDE_TouchAll
	GroundSpeed=1000
	AccelRate=10000
}
