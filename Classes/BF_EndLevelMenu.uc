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
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).WorldInfo.Title == "FirstLevel_Test"){
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=200 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=3 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=50){
			EndRank = "S";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=150 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=3 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "A";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=150 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=2 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "B";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=100 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=2 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "C";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=50 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=1 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=10){
			EndRank = "D";
		}else{
			EndRank = "F";
		}
	}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).WorldInfo.Title == "AtmoLevel"){
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=160 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=3 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=50){
			EndRank = "S";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=120 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=3 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "A";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=120 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=2 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "B";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=80 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=2 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "C";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=40 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=1 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=10){
			EndRank = "D";
		}else{
			EndRank = "F";
		}
	}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).WorldInfo.Title == "W3_Form_Test"){
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=240 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=3 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=50){
			EndRank = "S";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=180 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=3 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "A";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=180 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=2 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "B";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=120 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=2 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "C";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=60 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=1 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=10){
			EndRank = "D";
		}else{
			EndRank = "F";
		}
	}else{
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=240 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=3 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=50){
			EndRank = "S";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=180 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=3 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "A";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=180 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=2 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "B";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=120 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=2 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=20){
			EndRank = "C";
		}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore>=60 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays>=1 && BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).LongKillStreak>=10){
			EndRank = "D";
		}else{
			EndRank = "F";
		}
	}

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
	}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).WorldInfo.Title == "AtmoLevel"){
		ConsoleCommand("open W3_Form_Test");
	}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).WorldInfo.Title == "W3_Form_Test"){
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