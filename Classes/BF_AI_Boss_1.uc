class BF_AI_Boss_1 extends UDKBot;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
}

event tick(float DeltaTime)
{
	local float Time;
	super.Tick(DeltaTime);
	Time+=DeltaTime;
	if(Time>=1){
	Move(vect(50,50,0));
	Time=0;
	}
}

DefaultProperties
{
}
