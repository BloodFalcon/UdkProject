//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy AI Script 1
//////////////////////////

class BFAI3 extends UDKBot;

var vector EnemyLoc;
var float EnemyDistance;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}

auto state Idle
{
	event SeePlayer (Pawn Seen)
	{
		super.SeePlayer(Seen);
		Enemy = Seen;
       
		GotoState('Firing');
	}
}

state Firing
{
Begin:

EnemyLoc = Enemy.location;
Focus = Enemy;
EnemyDistance = VSize( Pawn.Location - Enemy.location );

	if (CanSee(Enemy) && (EnemyDistance < 1500))
	{
		Pawn.StartFire(0);
	}
	else
	{
		Pawn.StopFire(0);
		GotoState('Idle');
		//Goto('Begin');
	}
}

simulated event GetPlayerViewPoint(out vector out_Location, out Rotator out_Rotation)
{
	    if (Pawn != None)
	    {
	        out_Location = Pawn.Location;
	        out_Rotation = Rotation;
	    }
	    else
	        Super.GetPlayerViewPoint(out_Location, out_Rotation);
}

defaultproperties
{

}