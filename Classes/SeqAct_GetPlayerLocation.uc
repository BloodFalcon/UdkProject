// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAct_GetPlayerLocation extends SequenceAction;

var Vector pawnLocation;
var BFPawn PPawn;

event Activated()
{

if(InputLinks[0].bHasImpulse)
{
	pawnLocation = PPawn.Location;
}

OutputLinks[0].bHasImpulse=true;

}

defaultproperties
{
	ObjName="Player Location"
	ObjCategory="BF Actions"
	
	
	InputLinks[0]=(LinkDesc="In")
	OutputLinks[0]=(LinkDesc="Out")

	VariableLinks(0)=(ExpectedType=class'SeqVar_Vector',LinkDesc="Location",bWriteable=true,PropertyName=pawnLocation)
}
