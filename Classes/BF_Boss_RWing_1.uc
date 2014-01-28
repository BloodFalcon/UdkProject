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
		//Health-=Damage;
		super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
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
	}
	//super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
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
	Health=300
	Begin Object Name=BAMesh
		SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.LVL1_Boss_RWing'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.LVL1_Boss_RWing_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=5
    End Object 
	Mesh=BAMesh
	Components.Add(BAMesh)
	bIgnoreForces=true
}