/***************************************
// Author(s): Tyler Keller, Sean Mackey
// Date: 1/8/2014
// Status: Alpha
// Being Used: Yes
// Description: Default player projectile.
// Behavior: Straight-shot basic projectile.
***************************************/


class BF_Proj_Red_Line extends BF_Proj_PlayerBase;

var BF_Proj_Base MyProj;
var Rotator SpreadIncrement;
var Rotator SpreadOffset;
var byte BulletsLeft;

simulated event PostBeginPlay()
{
	SpreadShot(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.Bullets,BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.AngularWidth);
}

function SpreadShot(byte Bullets,int AngularWidth)
{
	SpreadIncrement.Yaw = (AngularWidth*DegToUnrRot)/Bullets;
	BulletsLeft=Bullets;
	SpreadOffset.Yaw = ((AngularWidth*DegToUnrRot)/2)-((((39*DegToUnrRot)/Bullets)/75)*AngularWidth);
	
	while(BulletsLeft>0){
		BulletsLeft--;
		MyProj = Spawn(class'BF_Proj_Red_SpreadBullet',Owner,, self.Location, self.Rotation); //MUST RENAME SOCKETS FOR PRECISE SPAWN LOCATION
		MyProj.Init(vector(self.Rotation+SpreadOffset));
		SpreadOffset-=SpreadIncrement;
	}
	//self.Destroy();
}

defaultproperties
{
	CollisionComponent = none
	CollisionType = COLLIDE_TouchAll
}