class BF_Proj_Boss_1 extends BF_Proj_EnemyBase;

var BF_Proj_Base MyProj;
var Rotator SpreadIncrement;
var Rotator SpreadOffset;
var byte BulletsLeft;
var byte Bullets;
var int AngularWidth;
var class BFClasses;

simulated event PostBeginPlay()
{
	SpreadShot();
}

function SpreadShot()
{
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Controller.IsInState('PhaseTwo')){
		Bullets=2;
		AngularWidth=90;
	}
	else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Controller.IsInState('FinalPhase')){
		Bullets=4;
		AngularWidth=75;
	}

	SpreadIncrement.Yaw = (AngularWidth*DegToUnrRot)/Bullets;
	BulletsLeft=Bullets;
	SpreadOffset.Yaw = ((AngularWidth*DegToUnrRot)/2)-((((39*DegToUnrRot)/Bullets)/75)*AngularWidth);
	
	while(BulletsLeft>0 && (BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Controller.IsInState('PhaseOne') || BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Controller.IsInState('PhaseTwo') || BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Controller.IsInState('FinalPhase'))){
		BulletsLeft--;
		MyProj = Spawn(class'BF_Proj_Blue_Circle',,, self.Location, self.Rotation); //MUST RENAME SOCKETS FOR PRECISE SPAWN LOCATION
		MyProj.Speed = 850;
		MyProj.Damage = 0.5;
		MyProj.SetDrawScale(3.0);
		MyProj.Init(vector(self.Rotation+SpreadOffset));
		SpreadOffset-=SpreadIncrement;
	}
	//self.Destroy();
}

defaultproperties
{
	AngularWidth=75
	Bullets=4
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Blue_TriCircle'
	DrawScale=3
	Damage=10
}