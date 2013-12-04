//////////////////////////
// Author(s): Tyler Keller
// Date: 12/4/2013
// Status: Alpha
// Being Used: Yes
// Description: AI Script
//////////////////////////

class BF_AI_Default extends UDKBot;

var byte FM;
var Actor ScriptedTarget;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}

function OnAIStartFireAt(UTSeqAct_AIStartFireAt FireAction){
	if(FM==3){
	FM=0;
	}else{
	FM=3;
	}
	Pawn.StartFire(FM);
}

defaultproperties
{
FM = 3
}