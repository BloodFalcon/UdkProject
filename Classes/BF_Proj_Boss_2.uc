class BF_Proj_Boss_2 extends BF_Proj_EnemyBase;

function tick(float DeltaTime)
{
	SetRotation(RotRand());
	Velocity = vect(0,900,0);
	super.Tick(DeltaTime);
}


defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Blue_TriCircle'
	DrawScale=5
	Damage=10
}