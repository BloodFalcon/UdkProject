//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/5/2013
// Status: Alpha
// Being Used: Yes
// Description: Player Controller for Blood Falcon
//////////////////////////

class BFPlayerController extends UDKPlayerController;

//var bool PauseActive;
var PostProcessSettings blurSettings;


//simulated event PostBeginPlay()
//{
//    blurSettings.bEnableMotionBlur = true;
//    blurSettings.bOverride_EnableMotionBlur = true;
//    blurSettings.bOverride_MotionBlur_Amount = true;
//    blurSettings.MotionBlur_Amount = 100.f;
//    TestBlur();
//    Super.PostBeginPlay();
//}


//function TestBlur()
//{
//    LocalPlayer(Player).OverridePostProcessSettings(blurSettings,10.f);
//}


function UpdateRotation( float DeltaTime )
{
	local Rotator	DeltaRot, ViewRotation;
	
	DeltaRot.Yaw	= 0;
	DeltaRot.Pitch	= 0;
	ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
}

exec function DoSomethingWithEscape()
{
	local BF_PauseMenu PauseMenu;

	if(WorldInfo.Title != "BF_TitleScreen_Map")
	{
		//PauseActive = true;
		PauseMenu = new class'BF_PauseMenu';
		PauseMenu.Start();
	}
}

defaultproperties
{
	bIsPlayer=true
	//PauseActive=false

}
