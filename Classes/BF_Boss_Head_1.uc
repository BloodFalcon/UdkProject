class BF_Boss_Head_1 extends BF_Boss_Aux;

var bool ShouldShoot;
var float HeadOffset;

event PostBeginPlay()
{
	super.PostBeginPlay();

}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(BossBase.Controller.IsInState('PhaseTwo') || BossBase.IsInState('FinalPhase')){
		//Health-=Damage;
		BossBase.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
		super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
		if(((self.Health<=0) || (BossBase.Controller.IsInState('FinalPhase')) || (BossBase.Health <= 625)) && (PartDestroyed==true)){
			BossBase.Health=(BossBase.Health/2);
			WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(DestroyEffect, Mesh, 'Attach', true);
			WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(DestroyEffect, Mesh, 'Nose_Gun', true);
			self.Mesh.SetMaterial(0, Material'BF_Fighters.Material.PlayerGlow');
			PartDestroyed = false;
		}
		else if(self.Health <= 0){
			BossBase.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
			SetTimer(0.10f, true, 'DeadHitFlash');
		}
	}
}

event tick(float DeltaTime)
{
	//`log(self.Health);
	super.tick(DeltaTime);
	if(BossBase.Controller==none || BossBase==none){
		self.Destroy();
	}
	else{
		if(BossBase!=none && BossBase.Controller!=none){
			if(BossBase.Mesh.GetSocketByName(Sock)!=none){
				BossBase.Mesh.GetSocketWorldLocationAndRotation(Sock,SockLoc,SockRot,);
				if(BossBase.Controller.IsInState('PhaseOne') && HeadOffset > 0){
					//`log("akdhfkadhfkh");
					HeadOffset-=0.01;
				}
				else if(BossBase.Controller.IsInState('PhaseTwo')){
					HeadOffset = 0;
				}
				else if(BossBase.Controller.IsInState('FinalPhase') && HeadOffset == 0){
					HeadOffset = 350;
				}
				SockLoc.Y-=HeadOffset;
				self.SetLocation(SockLoc);
				self.SetRotation(SockRot);
			}
		}
		else{
			self.Destroy();
		}
		if(BossBase.Controller.IsInState('PhaseTwo') && (ShouldShoot == true) && BossBase.Controller!=none)
		{
			`log("Should be shooting");
			SetTimer(3.0f, true, 'StrafeShooting');
			ShouldShoot = false;
		}
	}
}

function StrafeShooting()
{
	local BF_Proj_Base HeadProj;

	self.Mesh.GetSocketWorldLocationAndRotation('Nose_Gun', SockLoc, SockRot);
	HeadProj = Spawn(class'BF_Proj_Blue_Tri', ,,SockLoc, SockRot);
	HeadProj.Velocity = vect(0,1200,0);
	//ClearTimer('StrafeShooting');
}

DefaultProperties
{
	Health=250
	Begin Object Name=BAMesh
		SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.LVL1_Boss_Head1'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.LVL1_Boss_Head1_Physics'
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
	ShouldShoot=true
	HeadOffset = 350
}