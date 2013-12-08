//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: GameInfo for Blood Falcon
//////////////////////////

class BFGameInfo extends UDKGame;

var bool playerdead;
	var bool DroneEquip;
	var bool GunShipEquip;
	var bool SuicideFighterEquip;
	var byte DroneRank;
	var byte GunShipRank;
	var byte SuicideFighterRank;
	var byte Rank;


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

	playerdead = false
}