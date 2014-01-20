class BF_Boss_1 extends BF_Boss_Main;

event PostBeginPlay()
{
	super.PostBeginPlay();
	CylinderComponent.SetActorCollision(false, false); 
}


event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	SetTimer(0.10, true, 'ProjHitFlash');
	`log(Health);
	Health-=Damage;
	if(Health<=0){
		Destroy();
	}
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


function tick(float DeltaTime)
{

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
