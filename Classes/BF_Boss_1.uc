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
		Destroy();
	}
	else if(self.Health <= 1001){
		SetTimer(0.10f, true, 'DeadHitFlash');
	}
}

function ProjHitFlash()
{
	if(Health >=1001){
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
	if(Health <= 1250 && self.IsTimerActive('DeadHitFlash') == false){
		self.Mesh.SetMaterial(0, Material'BF_Fighters.Material.PlayerGlow');
	}
	if(Health <= 5000){
		GroundSpeed = 2000;
	}
	if(Health <= 1250){
		GroundSpeed = 3500;
	}
}


DefaultProperties
{
	Health=20000
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
