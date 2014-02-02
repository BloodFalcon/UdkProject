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
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.BulletPenetration){
		if (Other != Instigator)
		{
			//if(BF_Enemy_Base(Other).bIsBoss){
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
			if(BF_Enemy_Base(Other).Health<Damage){
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=BF_Enemy_Base(Other).Health;
			}else{
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=Damage;
			}
			//}
			Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		}
	}else{
		if (Other != Instigator)
		{
			//if(BF_Enemy_Base(Other).bIsBoss){
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
			if(BF_Enemy_Base(Other).Health<Damage){
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=BF_Enemy_Base(Other).Health;
			}else{
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=Damage;
			}
			//}
			Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
			self.Destroy();	
		}
	}
}


DefaultProperties
{
	Speed = 750
	ProjFlightTemplate=ParticleSystem'BF_Robert.ParticleSystem.Red_Circle'
}
