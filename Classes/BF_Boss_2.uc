class BF_Boss_2 extends BF_Boss_Main;

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
			else if(Health <= 7497){
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
	if(Health >=7499){
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
	//if(Health==7498 && Controller.IsInState('PhaseOne')){
	//	Controller.GotoState('Swarm1');
	//	//Controller.GotoState('PhaseTwo');
	//}
	if(Health==7497 && Controller.IsInState('PhaseOne')){
		Controller.GotoState('FinalPhase');
	}
	if(Health <= 7497 && self.IsTimerActive('DeadHitFlash') == false && Controller.IsInState('FinalPhase')){
		self.Mesh.SetMaterial(0, Material'BF_Fighters.Material.PlayerGlow');
	}
	if(Controller.IsInState('FinalPhase')){
		GroundSpeed = 1500;
	}
}


DefaultProperties
{
	Health=7500
	Begin Object Class=SkeletalMeshComponent Name=M1Mesh
		SkeletalMesh=SkeletalMesh'MyMesh.SkeletalMesh.LVL2_Boss_Body'
		PhysicsAsset=PhysicsAsset'MyMesh.Physics.LVL2_Boss_Body_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=1
    End Object 
	Mesh=M1Mesh
	Components.Add(M1Mesh)
    ControllerClass=class'UdkProject.BF_AI_Boss_2'
    bJumpCapable=false
    bCanJump=false
	BlockRigidBody=false
	bBlockActors = false
	bCollideActors = true
	bCollideWorld = true
	CollisionType=COLLIDE_TouchAll
	GroundSpeed=750
	AccelRate=10000
}
