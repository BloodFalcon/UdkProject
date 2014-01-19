class BF_Proj_Boss_1 extends BF_Proj_EnemyBase;

var Vector Dickie;
var bool StopIt;

function tick(float DeltaTime)
{
	SetRotation(RotRand());
	Dickie.X = RandRange(-200,200);
	Dickie.Y = 750;
	Dickie.Z = 0;
	if(StopIt){
		Velocity = (Dickie);
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