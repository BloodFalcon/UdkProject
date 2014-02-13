class BF_Boss_1 extends BF_Boss_Main;

event PostBeginPlay()
{
	super.PostBeginPlay();
	CylinderComponent.SetActorCollision(false, false); 
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(Controller != none && Controller.IsInState('FinalPhase')){
		if(Controller.IsInState('FinalPhase')){
			super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);	
			if(Health<=0){
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Boss1Dead = true;
				`log("Destroyed Boss");
				Destroy();
			}
			else if(Health <= 49996){
				SetTimer(0.10f, true, 'DeadHitFlash');
			}
		}
	}
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
	if(Health >=92699){
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
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossHealths[HealthIndex]=Health;
	//`log(self.Health);
	if(Health==49998 && Controller.IsInState('PhaseOne')){
		Controller.GotoState('Swarm1');
		//Controller.GotoState('PhaseTwo');
	}
	if(Health==49996 && Controller.IsInState('PhaseTwo')){
		Controller.GotoState('Swarm2');
		//Controller.GotoState('FinalPhase');
	}
	if(Health <= 49996 && self.IsTimerActive('DeadHitFlash') == false && Controller.IsInState('FinalPhase')){
		self.Mesh.SetMaterial(0, Material'BF_Fighters.Material.PlayerGlow');
	}
	if(Controller.IsInState('PhaseTwo')){
		GroundSpeed = 2000;
	}
	if(Controller.IsInState('FinalPhase')){
		GroundSpeed = 2250;
	}
}


DefaultProperties
{
	Health=50000
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
