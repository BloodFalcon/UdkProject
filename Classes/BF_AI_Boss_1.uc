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

auto state PhaseOne
{
Begin:
	Sleep(0.75);
	MoveTo(PointA, none, ,true);
	Sleep(0.75);
	MoveTo(PointB, none, ,true);
	if(Pawn.Health <= 2500){
		GotoState('PhaseTwo');
	}
	else{
		GotoState('PhaseOne');
	}
}

state PhaseTwo
{
Begin:
    Sleep(0.60);
	MoveTo(PointC, none, ,true);
	Sleep(0.1);
	MoveTo(PointA, none, ,true);
	Sleep(0.60);
	MoveTo(PointB, none, ,true);
	if(Pawn.Health <= 625){
		GotoState('FinalPhase');
	}
	else{
		GotoState('PhaseTwo');
	}
}

state FinalPhase
{
Begin:
	Sleep(0.45);
	MoveTo(PointC, none, ,true);
	Sleep(0.1);
	MoveTo(PointA, none, ,true);
	Sleep(0.45);
	MoveTo(PointC, none, ,true);
	Sleep(0.1);
	MoveTo(PointB, none, ,true);
	Sleep(0.45);
	MoveTo(PointA, none, ,true);
	Sleep(0.45);
	MoveTo(PointC, none, ,true);
	Sleep(0.1);
	MoveTo(PointA, none, ,true);
	Sleep(0.45);
	MoveTo(PointB, none, ,true);
	GotoState('FinalPhase');
}

state StrafeShot
{
Begin:
	//Sleep(0.75);
	MoveTo(PointB, none, ,true);
	//Sleep(0.75);
	MoveTo(PointA, none, ,true);
	GotoState('StrafeShot');
}

DefaultProperties
{
	bForceStrafe = true
	PointA=(X=-7600, Y=-2178, Z=46129)
	PointB=(X=-6400, Y=-2178, Z=46129)
	PointC=(X=-7000, Y=-1650, Z=46129)
	FaceThisWay = (Pitch=0,Yaw=16384,Roll=0)
}
