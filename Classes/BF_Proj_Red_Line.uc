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
var byte Bullets;
var int AngularWidth;

simulated event PostBeginPlay()
{
	SpreadShot();
}

function SpreadShot()
{
	SpreadIncrement.Yaw = (AngularWidth*DegToUnrRot)/Bullets;
	BulletsLeft=Bullets;
	SpreadOffset.Yaw = ((AngularWidth*DegToUnrRot)/2)-((((39*DegToUnrRot)/Bullets)/75)*AngularWidth);
	
	while(BulletsLeft>0){
		BulletsLeft--;
		MyProj = Spawn(class'BF_Proj_Red_SpreadBullet',Owner,, self.Location, self.Rotation); //MUST RENAME SOCKETS FOR PRECISE SPAWN LOCATION
		MyProj.Speed = 1500;
		MyProj.Damage = 1;
		MyProj.Init(vector(self.Rotation+SpreadOffset));
		SpreadOffset-=SpreadIncrement;
	}
	//self.Destroy();
}

defaultproperties
{
	AngularWidth=30
	Bullets=3
	CollisionComponent = none
	CollisionType = COLLIDE_TouchAll
}