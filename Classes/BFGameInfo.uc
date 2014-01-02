//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: GameInfo for Blood Falcon
//////////////////////////

class BFGameInfo extends GameInfo;

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

struct SoulStats
{
	/**Absorbed Enemy Type*/
	var() class<BF_Enemy_base> EType;
	/**Current Upgrade Level*/
	var() byte L;
	/**Enemy Mesh*/
	var() SkeletalMesh M;
		structdefaultproperties
		{
			EType=class'BF_Enemy_Base'
			L=0
		    M=SkeletalMesh'BloodFalcon.SkeletalMesh.Player'
		}
};

struct CollectedSouls
{
	var() SoulStats Current;
	var() SoulStats B1;
	var() SoulStats B2;
	var() SoulStats B3;
};

var CollectedSouls CS; 

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
}