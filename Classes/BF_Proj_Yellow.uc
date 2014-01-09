/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Projectile.
// Behavior:
***************************************/

class BF_Proj_Yellow extends BF_Proj_EnemyBase;

defaultproperties
{

	Speed = 550
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Yellow_Circle'
	//ProjExplosionTemplate=ParticleSystem'Envy_Effects.Particles.P_JumpBoot_Effect'
	LifeSpan=5
	DrawScale=1.5
	Damage=10
    MomentumTransfer=0
	CustomGravityScaling=0

    Begin Object Name=CollisionCylinder
            CollisionRadius=8
            CollisionHeight=16
    End Object

	bBlockedByInstigator=false
}