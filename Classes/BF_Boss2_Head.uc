class BF_Boss2_Head extends BF_Boss_Aux;

var BF_Proj_Base HeadProj;
var ParticleSystem LaserMuzzle;
var Rotator ProjRot;
var bool ShouldShoot;

event PostBeginPlay()
{
	super.PostBeginPlay();
	//SetTimer(3.0, true, 'FireWeaps');
	ProjRot.Yaw = 180*DegToUnrRot;
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	//if(BossBase.Controller.IsInState('PhaseTwo') || BossBase.IsInState('FinalPhase')){
	super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
	//}
}

function FireWeaps()
{
	self.Mesh.GetSocketWorldLocationAndRotation('Nose_Gun', SockLoc);
	HeadProj = Spawn(class'BF_Proj_Boss_1', self,,SockLoc,self.Rotation-ProjRot);
	HeadProj.Velocity = vect(0,750,0);
}

event tick(float DeltaTime)
{
	//local Vector HitLocation, HitNormal;
	//`log(self.Health);
	super.tick(DeltaTime);
	if(BossBase.Controller==none || BossBase==none){
		self.Destroy();
	}
	if(BossBase!=none && BossBase.Controller!=none){
		if(BossBase.Mesh.GetSocketByName(Sock)!=none){
			BossBase.Mesh.GetSocketWorldLocationAndRotation(Sock,SockLoc,SockRot,);
			self.SetLocation(SockLoc);
			self.SetRotation(SockRot);
		}
	}
	else{
		self.Destroy();
	}
	if(BossBase.Controller.IsInState('FinalPhase') && (ShouldShoot == true) && BossBase.Controller!=none)
 	{
 		SetTimer(3.0f, true, 'FireWeaps');
 		ShouldShoot = false;
 	}
	//if(GetRemainingTimeForTimer('StrafeShooting') > 3.5 && HeadProj != none){		
	//	//SockLoc.Y+=175;		
	//	HeadProj.SetLocation(SockLoc);
	//	SockLoc.Z=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BFPawnInfo.Location.Z;
	//	TracedEnemyAct = Trace(HitLocation, HitNormal, (SockLoc+BeamEnd), SockLoc, true);
	//	//DrawDebugLine(SockLoc,(SockLoc+BeamEnd),255,0,0);
	//	if(TracedEnemyAct!=none){
	//		TracedEnemyPawn = UDKPawn(TracedEnemyAct);
	//		if(TracedEnemyPawn.Name == 'BFPawn_0'){
	//			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BFPawnInfo.TakeDamage(1, BossBase.Controller, Location, Velocity, class'DamageType',, self);
	//		}
	//	}
	//}
	//else if(HeadProj!=none){
	//	HeadProj.Destroy();
	//	HeadProj=none;
	//}
	//if(GetRemainingTimeForTimer('FireWeaps') > 0.5 && GetRemainingTimeForTimer('FireWeaps') < 0.6){
	WorldInfo.MyEmitterPool.SpawnEmitterMeshAttachment(LaserMuzzle,Mesh,'Nose_Gun', true, vect);
	//}
}

//function StrafeShooting()
//{
//	self.Mesh.GetSocketWorldLocationAndRotation('Nose_Gun', SockLoc, SockRot);
//	//SockRot.Yaw+=(30*DegToUnrRot);
//	HeadProj = Spawn(class'BF_Proj_Blue_Laser', ,,SockLoc, SockRot);
//	//ClearTimer('StrafeShooting');
//}

DefaultProperties
{
	Health=1000
	Begin Object Name=BAMesh
		SkeletalMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.LVL2_Boss_Head'
		PhysicsAsset=PhysicsAsset'BF_Fighters.SkeletalMesh.LVL2_Boss_Head_Physics'
		HiddenGame=false
		HiddenEditor=false
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		Scale=2.5
    End Object 
	Mesh=BAMesh
	Components.Add(BAMesh)
	bIgnoreForces=true
	ShouldShoot=true
	LaserMuzzle=ParticleSystem'BF_Robert.ParticleSystem.Missile_Destroy'
}