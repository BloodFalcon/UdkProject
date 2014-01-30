class BF_Boss_Head_1 extends BF_Boss_Aux;

var bool ShouldShoot;
var float HeadOffset;
var BF_Proj_Base HeadProj;
var Actor TracedEnemyAct;
var UDKPawn TracedEnemyPawn;
var Vector BeamEnd;

event PostBeginPlay()
{
	super.PostBeginPlay();
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(BossBase.Controller.IsInState('PhaseTwo') || BossBase.IsInState('FinalPhase')){
		super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
	}
}

event tick(float DeltaTime)
{
	local Vector HitLocation, HitNormal;
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
 			SetTimer(5.0f, true, 'StrafeShooting');
 			ShouldShoot = false;
 		}
	}
	if(GetRemainingTimeForTimer('StrafeShooting') > 3.5 && HeadProj != none){		
		SockLoc.Y+=175;		
		HeadProj.SetLocation(SockLoc);
		SockLoc.Z=BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BFPawnInfo.Location.Z;
		TracedEnemyAct = Trace(HitLocation, HitNormal, (SockLoc+BeamEnd), SockLoc, true);
		DrawDebugLine(SockLoc,(SockLoc+BeamEnd),255,0,0);
		if(TracedEnemyAct!=none){
			TracedEnemyPawn = UDKPawn(TracedEnemyAct);
			if(TracedEnemyPawn.Name == 'BFPawn_0'){
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BFPawnInfo.TakeDamage(1, BossBase.Controller, Location, Velocity, class'DamageType',, self);
			}
		}
	}
	else if(HeadProj!=none){
		HeadProj.Destroy();
		HeadProj=none;
	}
}

function StrafeShooting()
{

	self.Mesh.GetSocketWorldLocationAndRotation('Nose_Gun', SockLoc, SockRot);
	HeadProj = Spawn(class'BF_Proj_Blue_Laser', ,,SockLoc, SockRot);
	//ClearTimer('StrafeShooting');
}

DefaultProperties
{
	Health=150
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
	BeamEnd = (X=0,Y=2000,Z=0)
}