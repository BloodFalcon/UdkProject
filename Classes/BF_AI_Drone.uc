//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy AI Script 1
//////////////////////////

class BF_AI_Drone extends UDKBot;

var int FM;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}

auto state Idle
{	
Begin:
	GotoState('Firing');
}

function tick(float DeltaTime){
	GotoState('Firing');
}

state Firing
{
Begin:
	Pawn.StartFire(FM);
}

defaultproperties
{
FM = 0
}