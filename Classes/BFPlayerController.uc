//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/5/2013
// Status: Alpha
// Being Used: Yes
// Description: Player Controller for Blood Falcon
//////////////////////////

class BFPlayerController extends UDKPlayerController;

function UpdateRotation( float DeltaTime )
{
	local Rotator	DeltaRot, ViewRotation;
	
	DeltaRot.Yaw	= 0;
	DeltaRot.Pitch	= 0;
	ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
}

defaultproperties
{
	bIsPlayer=true
}
