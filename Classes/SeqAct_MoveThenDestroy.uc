// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAct_MoveThenDestroy extends SeqAct_Destroy;

var actor Move;

event Activated()
{
	Move.SetLocation(vect(9999,9999,9999));
}

defaultproperties
{
	ObjName="Move Then Destroy"
	ObjCategory="BF Actions"

	VariableLinks[1]=(ExpectedType=class'SeqVar_Object',LinkDesc="Move",PropertyName=Move)
}
