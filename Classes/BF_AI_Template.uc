//////////////////////////
// Author(s): Tyler Keller
// Date: 11/26/2013
// Status: Alpha Template
// Being Used: No
// Description: Enemy AI Template Script
//////////////////////////

class BF_AI_Template extends UDKBot;

	var Actor PlayerTarget; //Player controller class 
	var Vector PlayerLoc; //Current Player Location
	var Vector EnemyLoc; //Enemy(self) Location
	var Vector DeltaPlayerLoc; //Vector for setting player location when using "SetLocation()"
	var bool Started;
 
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}


function Tick(float DeltaTime)
{
	PlayerTarget = GetALocalPlayerController().Pawn; //Get player controller class
	if(Pawn != none && PlayerTarget != none){
		PlayerLoc = PlayerTarget.Location;
		EnemyLoc = Pawn.Location;
		if(Started){
			GotoState('Movement');
		}else{
			Step1();
		}
	}else{
		GotoState('Expire');
	}
}


function Step1()
{
	Started=true;
	DeltaPlayerLoc.X=500;
	DeltaPlayerLoc.Y=-500;
	SetTimer(5.0f,false,nameof(Step2));
}

function Step2()
{
	Started=true;
	DeltaPlayerLoc.X=-500;
	DeltaPlayerLoc.Y=-500;
	SetTimer(5.0f,false,nameof(Step1));
}


state Movement
{
	Begin:
	if(Pawn != none) //Check to see if the AI still controls a physical pawn
	{
		if(PlayerTarget != none) //Make sure the player isn't dead
		{
		
			//MoveToward(PlayerTarget,PlayerTarget); //Actor Target
			MoveTo((PlayerLoc+DeltaPlayerLoc),PlayerTarget); //Vector Target
	
		}else{
			GotoState('Expire');
		}
	}else{
		GotoState('Expire'); 
	}
}


state Expire //Code for killing off Pawn instances
{
	Begin:
	if(Pawn != none){ //Check to see if the AI still controls a physical pawn
		Pawn.Destroy(); //Destroy the physical pawn
	}
		Self.Destroy(); //Destroy the AI
}


defaultproperties
{
	Started = false
}