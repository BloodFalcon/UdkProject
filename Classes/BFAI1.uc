//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy AI Script 1
//////////////////////////

class BFAI1 extends UDKBot;

var Actor target;
var() Vector TempDest;
 
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition); Pawn.SetMovementPhysics();
} //I'm adding an default idle state so the Pawn doesn't try to follow a player that doesn' exist yet.
 
auto state Idle
{
    event SeePlayer (Pawn Seen)
    {
        super.SeePlayer(Seen);
        target = Seen;
 
        GotoState('Follow');
    }
Begin:
}
 
state Follow
{
Begin:
    Target = GetALocalPlayerController().Pawn;
    //Target is an Actor variable defined in my custom AI Controller.
    //Of course, you would normally verify that the Pawn is not None before proceeding.
 
    MoveToward(Target, Target, 128);
 
    goto 'Begin';
}

DefaultProperties
{
}