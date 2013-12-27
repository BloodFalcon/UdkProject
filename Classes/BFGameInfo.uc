//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: GameInfo for Blood Falcon
//////////////////////////

class BFGameInfo extends UDKGame;

//var bool PlayerDead;
//	var bool DroneEquip;
//	var bool GunShipEquip;
//	var bool SuicideFighterEquip;
//	var int DroneRank;
//	var int GunShipRank;
//	var int SuicideFighterRank;
//	var int Rank;
//	var byte Lives;
//	var float BeamLength;

var array<SkeletalMesh> Souls; 


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

	//playerdead = false
}