class SeqAct_ZigZag extends SequenceAction;

var int MoveTo;
var int Start;
var int i;

event Activated()
{
	if(InputLinks[0].bHasImpulse==true){
		Start = RandRange(84,86);
		MoveTo = Start;
		OutputLinks[0].bHasImpulse=true;
	}
	
	if(InputLinks[1].bHasImpulse==true){
		if(i==0){
			MoveTo-=8;
			i++;
		}else{
			MoveTo-=10;
			i=0;
		}
		OutputLinks[1].bHasImpulse=true;
	}

	if(InputLinks[3].bHasImpulse==true || Start<0){
		OutputLinks[3].bHasImpulse=true;
	}
}

defaultproperties
{
	i=0
	MoveTo=0
	Start=85

	bAutoActivateOutputLinks=false

	ObjName="ZigZag"
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