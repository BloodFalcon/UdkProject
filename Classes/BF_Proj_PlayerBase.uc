/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/11/2014
// Status: Alpha
// Being Used: Yes
// Description: Reference extension to reference all player projectiles. 
// Behavior: Fire upward.
***************************************/

class BF_Proj_PlayerBase extends BF_Proj_Base;

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{

	if (Other != Instigator)
	{
		Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		//if(BossMode){
			//Explode(HitLocation, HitNormal);
		//}		
	}
}


DefaultProperties
{

}
