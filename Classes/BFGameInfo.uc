//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/5/2013
// Status: Alpha
// Being Used: Yes
// Description: GameInfo for Blood Falcon
//////////////////////////

class BFGameInfo extends UDKGame;

var bool P0;
var bool P1;
var bool P2;
var bool P3;
var bool P4;
var bool P5;
var bool P6;
var bool P7;

/*struct WeapStatus
{
	var bool Base;
	var bool Absorb;
	var bool Laser;

	structdefaultproperties
	{
		Base = true;
		Absorb = true;
		Laser = false;
	}
};*/

static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
    return Default.Class;
}

defaultproperties
{
        bDelayedStart=false
        DefaultPawnClass=class'UdkProject.BFPawn'
        PlayerControllerClass=class'UdkProject.BFPlayerController'
	    HUDType=class'BFHUD'

	P0 = false
	P1 = true
	P2 = false
	P3 = false
	P4 = false
	P5 = false
	P6 = false
	P7 = false
}