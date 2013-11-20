//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: GameInfo for Blood Falcon
//////////////////////////

class BFGameInfo extends UDKGame;

var bool Absorb;
var bool Basic;
var bool W1;
var bool W2;
var bool W3;
var bool W4;
var bool W5;
var bool W6;

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

	Absorb = false
	Basic = true
	W1 = false
	W2 = false
	W3 = false
	W4 = false
	W5 = false
	W6 = false
}