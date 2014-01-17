/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Default player projectile.
// Behavior: Straight-shot basic projectile.
***************************************/

class BF_Proj_Blue_Line extends BF_Proj_EnemyBase;

defaultproperties
{
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Blue_LineCircle'
	DrawScale=3
	Damage=5
}