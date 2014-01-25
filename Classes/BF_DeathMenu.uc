class BF_DeathMenu extends GFxMoviePlayer;

function bool Start(optional bool StartPaused = false)
{
    super.Start();
    Advance(0.f);
    SetPause(false);
	SetTimingMode( TM_Real );
    return TRUE;
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
