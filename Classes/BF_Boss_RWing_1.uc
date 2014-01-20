class BF_Boss_RWing_1 extends BF_Boss_Aux;

var Rotator WingRot;


event PostBeginPlay()
{
	super.PostBeginPlay();
	WingRot.Yaw = 90*DegToUnrRot;
	SetTimer(1.0, true, 'FireWeaps');
}

function FireWeaps()
{
	local Vector SockLoc;
	self.Mesh.GetSocketWorldLocationAndRotation('Nose_Gun', SockLoc);
	Spawn(class'BF_Proj_Boss_1', self,,SockLoc,self.Rotation);
	Spawn(class'BF_Proj_Boss_1', self,,SockLoc,self.Rotation);
	Spawn(class'BF_Proj_Boss_1', self,,SockLoc,self.Rotation);
	Spawn(class'BF_Proj_Boss_1', self,,SockLoc,self.Rotation);
	Spawn(class'BF_Proj_Boss_1', self,,SockLoc,self.Rotation);
}

event tick(float DeltaTime)
{
	super.tick(DeltaTime);
	self.SetRotation(WingRot);
}

DefaultProperties
{
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