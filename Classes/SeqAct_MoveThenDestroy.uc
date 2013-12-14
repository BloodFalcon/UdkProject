// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAct_MoveThenDestroy extends SeqAct_Destroy;


event Activated()
{
}

defaultproperties
{
	ObjName="Move Then Destroy"
	ObjCategory="BF Actions"
}
