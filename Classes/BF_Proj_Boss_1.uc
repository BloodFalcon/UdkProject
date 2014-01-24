class BF_Proj_Boss_1 extends BF_Proj_EnemyBase;

var Vector Spread;
var bool StopIt;

function tick(float DeltaTime)
{
	SetRotation(RotRand());
	Spread.X = RandRange(-200,200);
	Spread.Y = 750;
	Spread.Z = 0;
	if(StopIt){
		Velocity = (Spread);
		StopIt = false;
	}
}


defaultproperties
{
	StopIt = true
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Blue_TriCircle'
	DrawScale=3
	Damage=10
}