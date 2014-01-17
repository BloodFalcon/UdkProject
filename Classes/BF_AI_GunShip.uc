//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy AI Script 1
//////////////////////////

class BF_AI_GunShip extends UDKBot;

var byte FM;
var Actor ScriptedTarget;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}

function OnAIStartFireAt(UTSeqAct_AIStartFireAt FireAction){
	FM=0;
	Pawn.StartFire(FM);
}

defaultproperties
{
	FM=1
}