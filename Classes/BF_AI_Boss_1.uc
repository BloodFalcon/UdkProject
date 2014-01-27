class BF_AI_Boss_1 extends UDKBot;

var Rotator FaceThisWay;
var Vector PointA, PointB, PointC;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
	Pawn.FaceRotation(FaceThisWay, 0.5);
	Pawn.SetRotation(FaceThisWay);
	Pawn.SetDesiredRotation(FaceThisWay, true, false,0.5,false);
}

auto state Idle
{
Begin:
	MoveTo(PointA, none, ,true);
	GotoState('MoveRight');
	if(Pawn.Health <= 1250)
		GotoState('SwoopDown');
}

state MoveRight
{
Begin:
    Sleep(0.75);
	MoveTo(PointB, none, ,true);
	if(Pawn.Health <= 5000){
    GotoState('SwoopDown');
	}
	else{
		GotoState('Idle');
	}
}

state SwoopDown
{
Begin:
	Sleep(0.75);
	MoveTo(PointC, none, ,true);
	GotoState('Idle');
}

DefaultProperties
{
	bForceStrafe = true
	PointA=(X=-7600, Y=-2178, Z=46129)
	PointB=(X=-6400, Y=-2178, Z=46129)
	PointC=(X=-7000, Y=-1650, Z=46129)
	FaceThisWay = (Pitch=0,Yaw=16384,Roll=0)
}
