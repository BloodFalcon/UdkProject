class SeqCond_Fire extends SequenceCondition;

var bool FireState;

event Activated()
{
	if(FireState)
	{
		OutputLinks[0].bHasImpulse = true;
	}
}

defaultproperties
{
	ObjName="Fire"
	ObjCategory="BF Actions"

	bAutoActivateOutputLinks = false

	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Bool',LinkDesc="Fire State",PropertyName=FireState)
}
