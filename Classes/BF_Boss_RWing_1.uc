class BF_Boss_RWing_1 extends BF_Boss_Aux;

var Rotator WingRot;


event PostBeginPlay()
{
	super.PostBeginPlay();
	WingRot.Yaw = 90*DegToUnrRot;
	SetTimer(1.5, true, 'FireWeaps');
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(BossBase.Controller.IsInState('PhaseOne') || BossBase.Controller.IsInState('FinalPhase')){
		super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
	}
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

function FireWeaps()
{
	//if(self.Health >= 0 )
	//{
		self.Mesh.GetSocketWorldLocationAndRotation('Nose_Gun', SockLoc);
		Spawn(class'BF_Proj_Boss_1', self,,SockLoc,self.Rotation);
	//}
}

event tick(float DeltaTime)
{
	super.tick(DeltaTime);
	if(BossBase!=none){
		if(BossBase.Mesh.GetSocketByName(Sock)!=none){
			BossBase.Mesh.GetSocketWorldLocationAndRotation(Sock,SockLoc,SockRot,);
			self.SetLocation(SockLoc);
			self.SetRotation(WingRot);
		}
	}
	else if(BossBase==none || BossBase.Controller==none){
		self.Destroy();
	}
}

DefaultProperties
{
	Begin Object Name=BAMesh
		SkeletalMesh=SkeletalMesh'MyMesh.SkeletalMesh.LVL1_Boss_RWing'
		PhysicsAsset=PhysicsAsset'MyMesh.Physics.LVL1_Boss_RWing_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=2
    End Object 
	Mesh=BAMesh
	Components.Add(BAMesh)
	bIgnoreForces=true
}