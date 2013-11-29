class SeqAct_AI_Template extends SequenceAction;

var int MoveTo;
var int Start;
var int i;

event Activated()
{
	if(InputLinks[0].bHasImpulse==true){

		OutputLinks[0].bHasImpulse=true;
	}
	
	if(InputLinks[1].bHasImpulse==true){

		OutputLinks[1].bHasImpulse=true;
	}
	
	if(InputLinks[2].bHasImpulse==true){

		OutputLinks[2].bHasImpulse=true;
	}
	
	if(InputLinks[3].bHasImpulse==true){

		OutputLinks[3].bHasImpulse=true;
	}
}

defaultproperties
{
	i=0
	MoveTo=0
	Start=76

	bAutoActivateOutputLinks=false

	ObjName="Put Name Here"
	ObjCategory="BF Patterns"
	
	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Spawn")
	InputLinks[1]=(LinkDesc="Move")
	InputLinks[2]=(LinkDesc="Fire")
	InputLinks[3]=(LinkDesc="Kill")

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="S")
	OutputLinks[1]=(LinkDesc="M")
	OutputLinks[2]=(LinkDesc="F")
	OutputLinks[3]=(LinkDesc="K")


	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Int',LinkDesc="Start",bWriteable=true,PropertyName=Start)
	VariableLinks[1]=(ExpectedType=class'SeqVar_Int',LinkDesc="MoveTo",bWriteable=true,PropertyName=MoveTo)
}
