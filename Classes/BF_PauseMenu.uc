class BF_PauseMenu extends GFxMoviePlayer;

function bool Start(optional bool StartPaused = false)
{
    super.Start();
    Advance(0);
    
    //Extra stuff that doesn't do anything
    SetPause(False);  //Seems like my menu is paused, because even the animated buttons don't change back from selected after being hovered over
    //GetVariableObject("_root").GetObject("GUI").GotoAndPlayI(1); // Want this to play the first frame for GUI group which has all the buttons
    //GetVariableObject("_root").GetObject("MouseCursor").GotoAndPlayI(1); // Want this to play the first frame for MouseCursor group which has the mouse cursor
    //End of extra stuff
	SetTimingMode( TM_Real );
    return TRUE;
}

function ReturntoMenu(string myString, int myInt, bool myBool)
{
	ConsoleCommand("open BF_TitleScreen_Map");
}

DefaultProperties
{
    bPauseGameWhileActive=TRUE
    //bCaptureInput=TRUE
	//bCaptureMouseInput=true
	//bIgnoreMouseInput=false
	//Priority = 1
	TimingMode = TM_Real
	MovieInfo = SwfMovie'BloodFalcon.PauseMenu.BFPauseMenu'
}
