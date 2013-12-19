class SeqControl_BossLoop extends SequenceAction;

var() int LoopNum;

event Activated()
{
	if(InputLinks[0].bHasImpulse){

	}
}

defaultproperties
{
	ObjName="Boss Loop"
	ObjCategory="BF Controllers"

	bAutoActivateOutputLinks=false

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="Next")
	OutputLinks[1]=(LinkDesc="Trig")

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="T0")
	InputLinks[1]=(LinkDesc="T1")

	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Int',LinkDesc="#",PropertyName=LoopNum)
}
