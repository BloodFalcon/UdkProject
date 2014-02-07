class BF_DeathMenu extends GFxMoviePlayer;

var GFxObject FinalScore;
var GFxObject TotalKills;
var string KillCount;
var string EndScore;

function bool Start(optional bool StartPaused = false)
{
    super.Start();
    Advance(0.f);
    SetPause(false);
	SetTimingMode( TM_Real );
	KillCount = string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillCount);
	EndScore = string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore);
	TotalKills = GetVariableObject("TotalKills");
	TotalKills.SetString("text", KillCount);
	FinalScore = GetVariableObject("FinalScore");
	FinalScore.SetString("text", EndScore);
    return TRUE;
}


function RestartLevel(string myString, int myInt, bool myBool)
{
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive = false;
	ConsoleCommand("open "@BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).WorldInfo.Title);
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
    bPauseGameWhileActive=true
    bCaptureInput=false
	//bCaptureMouseInput=true
	//bIgnoreMouseInput=false
	Priority = 1
	TimingMode = TM_Real
	MovieInfo = SwfMovie'BloodFalcon.DeathMenu.BFDeathMenu'	
}
