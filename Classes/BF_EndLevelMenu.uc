class BF_EndLevelMenu extends GFxMoviePlayer;


function bool Start(optional bool StartPaused = false)
{
    super.Start();
    Advance(0.f);
    SetPause(false);
	SetTimingMode( TM_Real );
    return TRUE;
}


function NextLevel(string myString, int myInt, bool myBool)
{
	//BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive = false;
	//ConsoleCommand("open "@BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).WorldInfo.Title);
	ConsoleCommand("open SpaceLevel2");
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
	MovieInfo = SwfMovie'BloodFalcon.LevelEnd.BFLevelEnd'
}