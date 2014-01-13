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
	Close();
}

function Options(string myString, int myInt, bool myBool)
{
	`log("Open Options Screen");
}

function ReturntoMenu(string myString, int myInt, bool myBool)
{
	ConsoleCommand("open BF_TitleScreen_Map");
}

function QuittoDesktop(string myString, int myInt, bool myBool)
{
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
