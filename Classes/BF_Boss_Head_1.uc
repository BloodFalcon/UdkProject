class BF_Boss_Head_1 extends BF_Boss_Aux;

var bool ShouldShoot;
var float HeadOffset;

event PostBeginPlay()
{
	super.PostBeginPlay();

}

event tick(float DeltaTime)
{
	super.tick(DeltaTime);
	if(BossBase!=none){
		if(BossBase.Mesh.GetSocketByName(Sock)!=none){
			BossBase.Mesh.GetSocketWorldLocationAndRotation(Sock,SockLoc,SockRot,);
			if(BossBase.Controller.IsInState('PhaseOne') && HeadOffset > 0){
				`log("akdhfkadhfkh");
				HeadOffset-=0.01;
			}
			else if(BossBase.Controller.IsInState('PhaseTwo')){
				HeadOffset = 0;
			}
			SockLoc.Y-=HeadOffset;
			self.SetLocation(SockLoc);
			self.SetRotation(SockRot);
		}
	}
	else{
		self.Destroy();
	}
	if(BossBase.Controller.IsInState('PhaseTwo') && (ShouldShoot == true))
	{
		`log("Should be shooting");
		SetTimer(3.0f, true, 'StrafeShooting');
		ShouldShoot = false;
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
}