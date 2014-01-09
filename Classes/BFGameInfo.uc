//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: GameInfo for Blood Falcon
//////////////////////////

class BFGameInfo extends GameInfo;

var int BloodMeter;
var byte modeBulletTime;
var float TimeIncrement;
var float Time;
var bool bDrain;

function BulletTime(byte ModeNum)
{
	modeBulletTime=ModeNum;
}

function tick(float DeltaTime)
{
	super.Tick(DeltaTime);
	`log(Time);
	if(bDrain){
		Time+=DeltaTime;
		if(BloodMeter>0 && Time>=1.0){
			BloodMeter-=2;
			Time=0;
		}else if(BloodMeter<=0){
			BloodMeter=0;
		}
	}else{
		Time=0;
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
	}else{
		if(modeBulletTime==1 && BloodMeter>0){
			GameSpeed=0.3;
		}else if(modeBulletTime==2 || BloodMeter<=0){
			GameSpeed=1.0;
		}
		modeBulletTime=0;
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
	TimeIncrement=2
	Time=0
	bDrain=false
}