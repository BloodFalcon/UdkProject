class BF_Boss_LWing_1 extends BF_Boss_Aux;

var Rotator WingRot;
var ParticleSystemComponent WingProj;


event PostBeginPlay()
{
	super.PostBeginPlay();
	WingRot.Yaw = 90*DegToUnrRot;
	self.SetRotation(WingRot); 
	SetTimer(2.0, true, 'FireWeaps');
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(BossBase.Controller.IsInState('PhaseOne') || BossBase.Controller.IsInState('FinalPhase')){
		super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
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
		SkeletalMesh=SkeletalMesh'MyMesh.SkeletalMesh.LVL1_Boss_LWing'
		PhysicsAsset=PhysicsAsset'MyMesh.Physics.LVL1_Boss_LWing_Physics'
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