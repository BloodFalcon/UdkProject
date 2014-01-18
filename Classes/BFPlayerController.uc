//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/5/2013
// Status: Alpha
// Being Used: Yes
// Description: Player Controller for Blood Falcon
//////////////////////////

class BFPlayerController extends UDKPlayerController;

<<<<<<< HEAD
//var bool PauseMenu;
=======
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

>>>>>>> ea73641d3610a26c40b52d04c5d57f488ab4d03a

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

	if(WorldInfo.Title != "BF_TitleScreen_Map" && (BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive==false))
	{
		BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PauseActive = true;
		PauseMenu = new class'BF_PauseMenu';
		PauseMenu.Start();
	}
}

defaultproperties
{
	bIsPlayer=true
	//PauseActive=false
}
