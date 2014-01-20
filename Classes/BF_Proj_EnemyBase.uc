/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/11/2014
// Status: Alpha
// Being Used: Yes
// Description: Reference extension to reference all enemy projectiles. 
// Behavior: Depends on projectile for behavior.
***************************************/

class BF_Proj_EnemyBase extends BF_Proj_Base;

function Init(vector Direction)
{
	SetRotation(Rotator(Direction));
	Velocity = Speed * Direction;
	//Velocity+=Owner.Velocity;
	//Velocity.Y += TossZ;
	Acceleration = AccelRate * Normal(Velocity);
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	local UDKPawn HitPlayer;
	HitPlayer = BFPawn(Other);
	if (Other != Instigator && Other == HitPlayer)
	{
		Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		self.Destroy();
		ProjEffects = none;
	}
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	if (Damage > 0 && DamageRadius > 0)
	{
		if ( Role == ROLE_Authority )
		{
			MakeNoise(1.0);
		}
		ProjectileHurtRadius(HitLocation, HitNormal);
	}
	Destroy();
}


DefaultProperties
{
	Speed = 750
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Blue_Circle'
    //Begin Object class=DynamicLightEnvironmentComponent name=MyLightEnvironment
    //        bEnabled=true
    //End Object
    //Components.Add(MyLightEnvironment)
}
