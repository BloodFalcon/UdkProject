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
	local Controller BossController;

	BossController = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Controller;

	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.BulletPenetration && BF_Enemy_Base(Other).bIsBoss!=true){
		if (Other != Instigator)
		{
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
			if(BF_Enemy_Base(Other).Health<Damage){
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=BF_Enemy_Base(Other).Health;
			}else{
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=Damage;
			}
			Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		}
	}else if(BF_Enemy_Base(Other).bIsBoss){
		if(BossController.IsInState('PhaseOne')){
			if(Other.class==class'BF_Boss2_Head' || Other.class==class'BF_Boss2_LWing' || Other.class==class'BF_Boss2_RWing' || Other.Class==class'BF_Boss_LWing_1' || Other.Class==class'BF_Boss_RWing_1'){
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
				if(BF_Enemy_Base(Other).Health<Damage){
					BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=BF_Enemy_Base(Other).Health;
				}else{
					BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=Damage;
				}
				Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);	
			}else{
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=0;
			}	
		}else if(BossController.IsInState('Swarm1')){
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=0;
		}else if(BossController.IsInState('PhaseTwo')){
			if(Other.class==class'BF_Boss2_Head' || Other.class==class'BF_Boss2_LWing' || Other.class==class'BF_Boss2_RWing' || Other.class==class'BF_Boss_2' || Other.Class==class'BF_Boss_Head_1'){
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
				if(BF_Enemy_Base(Other).Health<Damage){
					BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=BF_Enemy_Base(Other).Health;
				}else{
					BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=Damage;
				}
				Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);	
			}else{
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=0;
			}
		}else if(BossController.IsInState('Swarm2')){
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=0;
		}else if(BossController.IsInState('FinalPhase')){
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
			if(BF_Enemy_Base(Other).Health<Damage){
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=BF_Enemy_Base(Other).Health;
			}else{
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=Damage;
			}
			Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);		
		}else{
			//Shouldn't Be Here. Idiot.
		}
		self.Destroy();	
	}else{
		if (Other != Instigator)
		{
			BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.HitLoc=self.Location;
			if(BF_Enemy_Base(Other).Health<Damage){
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=BF_Enemy_Base(Other).Health;
			}else{
				BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).HitData.Damage=Damage;
			}
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
