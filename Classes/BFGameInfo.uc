//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: GameInfo for Blood Falcon
//////////////////////////

class BFGameInfo extends GameInfo;

var int BloodMeter;
var bool bBulletTime;
var float TimeIncrement;

function BulletTime(bool BTToggle)
{
bBulletTime=BTToggle;
}

function tick(float DeltaTime)
{
	if(bBulletTime && GameSpeed>0.3){
		GameSpeed=GameSpeed-(TimeIncrement*TimeIncrement);
		SetGameSpeed(GameSpeed);
		TimeIncrement-=0.005;
	}else if(bBulletTime==false && GameSpeed<1.0){
		GameSpeed=GameSpeed+(TimeIncrement*TimeIncrement);
		SetGameSpeed(GameSpeed);
		TimeIncrement-=0.005;
	}else{
		GameSpeed=1.0;
		SetGameSpeed(GameSpeed);
	}
}

static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
    return Default.Class;
}

defaultproperties
{
    bDelayedStart=false
    DefaultPawnClass=class'UdkProject.BFPawn'
    PlayerControllerClass=class'UdkProject.BFPlayerController'
	HUDType=class'UdkProject.BFHUD'
	TimeIncrement=0.005
}