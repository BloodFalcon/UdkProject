class BF_EndLevelMenu extends GFxMoviePlayer;

var GFxObject KillStreak;
var GFxObject TotalKills;
var GFxObject FinalScore;
var GFxObject BaysLeft;
var GFxObject RankText;
var string EndStreak;
var string EndKills;
var string EndScore;
var string EndBays;
var string EndRank;

function bool Start(optional bool StartPaused = false)
{
    super.Start();
    Advance(0.f);
    SetPause(false);
	SetTimingMode( TM_Real );
	EndStreak = string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak);
	EndKills = string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore);
	EndScore = string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GameScore);
	EndBays = string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays);
	EndRank = "S";
		//string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore);
	KillStreak = GetVariableObject("KillStreak");
	KillStreak.SetString("text", EndStreak);
	TotalKills = GetVariableObject("TotalKills");
	TotalKills.SetString("text", EndKills);
	FinalScore = GetVariableObject("FinalScore");
	FinalScore.SetString("text", EndScore);
	BaysLeft = GetVariableObject("BaysLeft");
	BaysLeft.SetString("text", EndBays);
	RankText = GetVariableObject("RankText");
	RankText.SetString("text", EndRank);
    return TRUE;
}


function NextLevel(string myString, int myInt, bool myBool)
{
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).WorldInfo.Title == "FirstLevel_Test"){
		ConsoleCommand("open AtmoLevel");
	}
	else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).WorldInfo.Title == "AtmoLevel"){
		ConsoleCommand("open W3_Form_Test");
	}
	else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).WorldInfo.Title == "W3_Form_Test"){
		ConsoleCommand("open Boss_Level");
	}else{
		ConsoleCommand("open BF_TitleScreen_Map");
	}
}


function ReturntoMenu(string myString, int myInt, bool myBool)
{
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive = false;
	ConsoleCommand("open BF_TitleScreen_Map");
}


function QuittoDesktop(string myString, int myInt, bool myBool)
{
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive = false;
	ConsoleCommand("quit");
}


DefaultProperties
{
    bPauseGameWhileActive=false
    bCaptureInput=false
	//bCaptureMouseInput=true
	//bIgnoreMouseInput=false
	Priority = 1
	TimingMode = TM_Real
	MovieInfo = SwfMovie'BloodFalcon.LevelEnd.BFLevelEnd'
}