class BF_Boss2_LWing extends BF_Boss_Aux;

var Rotator WingRot;

event PostBeginPlay()
{
	super.PostBeginPlay();
	WingRot.Yaw = 90*DegToUnrRot;
	self.SetRotation(WingRot); 
	SetTimer(0.5, true, 'FireWeaps');
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	//if(BossBase.Controller.IsInState('PhaseOne') || BossBase.Controller.IsInState('FinalPhase')){
		super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
	//}
}

function FireWeaps()
{
	//if(self.Health >= 0 )
	//{
		self.Mesh.GetSocketWorldLocationAndRotation('Nose_Gun', SockLoc);
		Spawn(class'BF_Proj_Boss_2', self,,SockLoc,self.Rotation);
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
	Health=1000
	Begin Object Name=BAMesh
		SkeletalMesh=SkeletalMesh'MyMesh.SkeletalMesh.LVL2_Boss_LARM'
		PhysicsAsset=PhysicsAsset'MyMesh.Physics.LVL2_Boss_LARM_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=1
    End Object 
	Mesh=BAMesh
	Components.Add(BAMesh)
	bIgnoreForces=true
}