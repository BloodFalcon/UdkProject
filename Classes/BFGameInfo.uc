/***************************************
// Author(s): Tyler Keller
// Date: 1/11/2014
// Status: Alpha
// Being Used: Yes
// Description: BloodFalcon world info class.
***************************************/

class BFGameInfo extends GameInfo;

var float BloodMeter;
var byte modeBulletTime;
var float TimeIncrement;
var float Time;
var bool bDrain;
var bool R;


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
				BloodMeter-=(Time*2);
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
	BloodMeter=0
	R=false
}