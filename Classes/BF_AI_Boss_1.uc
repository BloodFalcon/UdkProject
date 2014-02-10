class BF_AI_Boss_1 extends UDKBot;

var Rotator FaceThisWay;
var Vector PointA, PointB, PointC, PointS1;

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
	if(Pawn.Health == 423){
		GotoState('Swarm1');
	}
	else{
		GotoState('PhaseOne');
	}
}

state Swarm1
{
Begin:
	MoveTo(PointS1, none, ,true);
	Sleep(20.0);
	GotoState('PhaseTwo');
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
	if(Pawn.Health == 421){
		GotoState('Swarm2');
	}
	else{
		GotoState('PhaseTwo');
	}
}

state Swarm2
{
Begin:
	MoveTo(PointS1, none, ,true);
	Sleep(30.0);
	GotoState('FinalPhase');
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
	PointA=(X=-7575, Y=-2000, Z=46129)
	PointB=(X=-6425, Y=-2000, Z=46129)
	PointC=(X=-7050, Y=-1600, Z=46129)
	PointS1=(X=-7050, Y=-2178, Z=46129)
	FaceThisWay = (Pitch=0,Yaw=16384,Roll=0)
}
