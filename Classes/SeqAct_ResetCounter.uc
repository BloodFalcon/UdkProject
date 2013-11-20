//////////////////////////
// Author(s): Tyler Keller
// Date: 11/14/2013
// Status: Stable
// Being Used: Yes
// Description: Resets index for objectlist
//////////////////////////

class SeqAct_ResetCounter extends SequenceAction;

var() int Reset;
var int ListIndex;

event Activated()
{
	if(InputLinks[0].bHasImpulse)
	{
		if(ListIndex < Reset)
		{
			ListIndex++;
		}else{
			ListIndex = 0;
		}

		OutputLinks[0].bHasImpulse = TRUE;
	}
}


defaultproperties
{
	ObjName="Reset Counter"
	ObjCategory="BF Actions"

	InputLinks[0]=(LinkDesc="In")
	OutputLinks[0]=(LinkDesc="Out")

	VariableLinks(0)=(ExpectedType=class'SeqVar_Int',LinkDesc="Reset",PropertyName=Reset)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="List Index",bWriteable=true,PropertyName=ListIndex)

}
