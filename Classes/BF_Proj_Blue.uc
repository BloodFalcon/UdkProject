/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Projectile.
// Behavior:
***************************************/

class BF_Proj_Blue extends BF_Proj_EnemyBase;

defaultproperties
{
	Speed = 1000
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Blue_Circle'
	//ProjExplosionTemplate=ParticleSystem'Envy_Effects.Particles.P_JumpBoot_Effect'
	LifeSpan=4
	DrawScale=1
	Damage=10
    MomentumTransfer=0
	CustomGravityScaling=0

    Begin Object Name=CollisionCylinder
            CollisionRadius=8
            CollisionHeight=16
    End Object

	bBlockedByInstigator=false
}