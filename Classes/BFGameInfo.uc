/***************************************
// Author(s): Tyler Keller
// Date: 1/11/2014
// Status: Alpha
// Being Used: Yes
// Description: BloodFalcon world info class.
***************************************/

class BFGameInfo extends GameInfo;


struct HitD
{
	var Vector HitLoc;
	var int Damage;
	var byte LocCount;

	structdefaultproperties
	{
		HitLoc=(X=0,Y=0,Z=0)
		Damage=0
		LocCount=0
	}
};


var float BloodMeter;
var bool PlayerDead;
var byte modeBulletTime;
var float TimeIncrement;
var float Time;
var bool bDrain;
var bool R;
var bool PauseActive, GameOverActive;
var bool Boss1Dead;
var float BloodIncrement, BloodDecrement;
var CollectedSouls CS;
var BFPawn BFPawnInfo;
var float BulletSpeed;
var byte BulletSpread;
var float BulletDamage;
var byte BulletPenetration;
var BF_EndLevelMenu EndLevelMenu;
var BF_Enemy_Base BossBase;
var int KillScore, KillCount;
var vector ScreenBounds;
var HitD HitData;


function BulletTime(byte ModeNum)
{
	modeBulletTime=ModeNum;
}


function tick(float DeltaTime)
{
	super.Tick(DeltaTime);
	if(modeBulletTime==0){
		if(bDrain){
			Time=DeltaTime;
			if(BloodMeter>0){
				BloodMeter-=(Time*BloodDecrement);
				//Time=0;
			}else if(BloodMeter<=0){
				BloodMeter=0;
			}
		}else{
			Time=0;
		}
	}


	if(modeBulletTime==0){
		TimeIncrement=3;
	}
	

	if(modeBulletTime==1 && GameSpeed>0.3 && BloodMeter>0){
		GameSpeed=GameSpeed-((TimeIncrement*TimeIncrement)*0.002);
		SetGameSpeed(GameSpeed);
		TimeIncrement-=0.0005;
		bDrain=true;
	}else if((GameSpeed<1.0 && modeBulletTime==2)||(BloodMeter<=0 && GameSpeed<1.0)){
		GameSpeed=GameSpeed+((TimeIncrement*TimeIncrement)*0.002);
		SetGameSpeed(GameSpeed);
		TimeIncrement-=0.0005;	
		bDrain=false;
		if(BloodMeter>=9.5){
			BloodMeter=10;
		}
	}else{
		if(modeBulletTime==1 && BloodMeter>0){
			GameSpeed=0.3;
		}else if(modeBulletTime==2 || BloodMeter<=0){
			GameSpeed=1.0;
		}
		modeBulletTime=0;
	}
	//BloodMeter=10;
	if(Boss1Dead == true)
	{
		`log("OPEN COMPLETE");
		Boss1Dead = false;
		SetTimer(3.0f, false, 'NextLevel');
	}
}

function NextLevel()
{
	GameOverActive = true;
	EndLevelMenu = new class'BF_EndLevelMenu';
	EndLevelMenu.Start();
}

static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
    return Default.Class;
}

defaultproperties
{
	Boss1Dead = false
	BloodDecrement=2
	BloodIncrement=1
	BulletSpeed=1
	BulletSpread=1
	BulletDamage=1
	BulletPenetration=1
    bDelayedStart=false
    DefaultPawnClass=class'UdkProject.BFPawn'
    PlayerControllerClass=class'UdkProject.BFPlayerController'
	HUDType=class'UdkProject.BFHUD'
	TimeIncrement=2
	Time=0
	bDrain=false
	BloodMeter=0
	R=false
	PauseActive=false
	GameOverActive=false
}