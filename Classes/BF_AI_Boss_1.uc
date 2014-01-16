class BF_AI_Boss_1 extends UDKBot;

event tick(float DeltaTime)
{
	local float Time;
	super.Tick(DeltaTime);
	Time+=DeltaTime;
	if(Time>=2){
	Pawn.Move(vect(50,50,0));
	Time=0;
	}
}

DefaultProperties
{
}
