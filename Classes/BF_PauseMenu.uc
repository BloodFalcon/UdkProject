class BF_PauseMenu extends GFxMoviePlayer;

function bool Start(optional bool StartPaused = false)
{
    super.Start();
    Advance(0);
    SetPause(False);
	SetTimingMode( TM_Real );
    return TRUE;
}

function ResumeGame(string myString, int myInt, bool myBool)
{
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive = false;
	Close();
}

function Options(string myString, int myInt, bool myBool)
{
	//`log("Open Options Screen");
}

function SetRes1280x720(string myString, int myInt, bool myBool)
{
	ConsoleCommand("SetRes 1280x720x32");
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive = false;
	Close();
}

function SetRes1366x768(string myString, int myInt, bool myBool)
{
	ConsoleCommand("SetRes 1366x768x32");
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive = false;
	Close();
}

function SetRes1600x900(string myString, int myInt, bool myBool)
{
	ConsoleCommand("SetRes 1600x900x32");
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive = false;
	Close();
}

function SetRes1920x1080(string myString, int myInt, bool myBool)
{
	ConsoleCommand("SetRes 1920x1080x32");
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive = false;
	Close();
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
	MovieInfo = SwfMovie'BloodFalcon.PauseMenu.BFPauseMenu'
}
