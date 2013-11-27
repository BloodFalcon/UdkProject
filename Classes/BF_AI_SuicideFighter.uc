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
var bool atPlayer;
var float EnemyDistance;
var Actor PlayerTarget;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
	atPlayer=false;
}

/*auto state Idle
{	
	event SeePlayer (Pawn Seen)
	{
		super.SeePlayer(Seen);
		Enemy = Seen;
		GotoState('Firing');
	}
}*/

function Tick(float DeltaTime){
GotoState('Firing');
}

function EnemyDeath(){
`log("Expired");
GotoState('Expire');
}

state Firing
{
Begin:
	if(Pawn != none){
	PlayerTarget = GetALocalPlayerController().Pawn;
	//EnemyLoc = Enemy.location;
	//Focus = Enemy;
	//EnemyDistance = VSize( Pawn.Location - Enemy.location );

	if(Pawn != none && PlayerTarget != none){
		if(VSize(Pawn.Location-PlayerTarget.Location)>500 && atPlayer==false){
			MoveToward(PlayerTarget, PlayerTarget);
		}else{
			atPlayer=true;
			//NewLoc = Pawn.Location;	
			//NewLoc.Y-=5;
			//Pawn.SetLocation(NewLoc);
			//SetTimer(5,false,'EnemyDeath');
		}
	}
			
	
	if (EnemyDistance < 1500)
		{
			//Pawn.StartFire(0);
		}
		else
		{
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