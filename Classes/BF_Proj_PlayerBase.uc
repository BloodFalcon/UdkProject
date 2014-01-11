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
