//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Enemy AI Script 1
//////////////////////////

class BF_AI_SuicideFighter extends UDKBot;

var vector EnemyLoc;
var Vector NewLoc;
var bool pattern;
var float EnemyDistance;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
	pattern=true;
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

function Tick(float DeltaTime){

	if(pattern){
		if(Pawn != none){
		//Pawn.MoveToward(Enemy,Enemy); HOW TO MAKE SUICIDE FLY INTO PLAYER's COORDINATES???
		}
	}
}


state Firing
{
Begin:
	if(Pawn != none){
	EnemyLoc = Enemy.location;
	Focus = Enemy;
	EnemyDistance = VSize( Pawn.Location - Enemy.location );

		if (EnemyDistance < 1500)
		{
			//Pawn.StartFire(0);
		}
		else
		{
			pattern=false;
			Pawn.StopFire(0);
			GotoState('Expire');
		}
	}else{
		GotoState('Expire');
	}
}

state Expire
{
	Begin:
	if(Pawn != none){
		Pawn.Destroy();
	}
		Self.Destroy();
}

/*simulated event GetPlayerViewPoint(out vector out_Location, out Rotator out_Rotation)
{
	    if (Pawn != None)
	    {
	        out_Location = Pawn.Location;
	        out_Rotation = Rotation;
	    }
	    else
	        Super.GetPlayerViewPoint(out_Location, out_Rotation);
}*/

defaultproperties
{

}