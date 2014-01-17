class BF_AI_Boss_1 extends UDKBot;

var Actor Target;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}

auto state Idle
{
 event SeePlayer(Pawn Seen)
 {
 super.SeePlayer(Seen);
 Target = Seen;
 GotoState('Following');
 }
 Begin:
}

state Following
{
 Begin:
 MoveToward(Target, Target, 1000);
 goto 'Begin';
}

DefaultProperties
{
}
