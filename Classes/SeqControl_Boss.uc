class SeqControl_Boss extends SequenceAction;

var() int TrigNum;
var int CurNum;
var bool FirstRun;
var bool ResetNode;

event Activated()
{
	if(InputLinks[0].bHasImpulse){
		FirstRun=true;
		ResetNode=false;
	}

	if(FirstRun){
		CurNum=TrigNum;
		FirstRun=false;
	}

	CurNum--;

	if(CurNum<=0){
		OutputLinks[1].bIsActivated = true;
		OutputLinks[0].bIsActivated = true;
	}else{
		OutputLinks[1].bIsActivated = true;
	}
}

defaultproperties
{
	ObjName="Boss Trigger"
	ObjCategory="BF Controllers"

	TrigNum=2
	CurNum=2
	FirstRun=true
	ResetNode=true

	bAutoActivateOutputLinks=false

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="Next")
	OutputLinks[1]=(LinkDesc="Trig")

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="T0")
	InputLinks[1]=(LinkDesc="T1")
	InputLinks[2]=(LinkDesc="T2",bHidden=true)
	InputLinks[3]=(LinkDesc="T3",bHidden=true)
	InputLinks[4]=(LinkDesc="T4",bHidden=true)
	InputLinks[5]=(LinkDesc="T5",bHidden=true)
	InputLinks[6]=(LinkDesc="T6",bHidden=true)
	InputLinks[7]=(LinkDesc="T7",bHidden=true)
	InputLinks[8]=(LinkDesc="T8",bHidden=true)
	InputLinks[9]=(LinkDesc="T9",bHidden=true)
	InputLinks[10]=(LinkDesc="Reset",bHidden=true)

	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Int',LinkDesc="#",PropertyName=TrigNum)
}
