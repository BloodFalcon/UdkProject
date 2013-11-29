class SeqAct_SuicideDrop extends SequenceAction;

var int MoveTo;
var int Start;
var bool Firing;
var int Wait;
var int StepNum;

event Activated()
{
	if(InputLinks[0].bHasImpulse==true){
		Start = RandRange(83,87);
		MoveTo = Start;
		OutputLinks[0].bHasImpulse=true;
	}
	
	if(InputLinks[1].bHasImpulse==true){
		movement();
		//OutputLinks[1].bHasImpulse=true;
	}
	
	if(InputLinks[2].bHasImpulse==true){
		if(Firing){
			Firing=false;
			OutputLinks[3].bHasImpulse=true;
		}else{
			Firing=true;
			OutputLinks[2].bHasImpulse=true;
		}
	}
	
	if(InputLinks[3].bHasImpulse==true){

		OutputLinks[4].bHasImpulse=true;
	}
}

function movement()
{
	if(StepNum==0){
		MoveTo-=9;
		Wait=3;
		StepNum++;
		OutputLinks[5].bHasImpulse=true;
	}else if(StepNum==1){
		MoveTo-=63;
		Wait=3;
		StepNum++;
	}else if(StepNum==2){
		Wait=0;
		StepNum = 0;
		OutputLinks[4].bHasImpulse=true;
	}

	OutputLinks[1].bHasImpulse=true;
}

defaultproperties
{
	Wait=0
	StepNum=1
	MoveTo=85
	Start=85
	Firing=false

	bAutoActivateOutputLinks=false

	ObjName="Suicide Drop"
	ObjCategory="BF Patterns"
	
	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Spawn")
	InputLinks[1]=(LinkDesc="Move")
	InputLinks[2]=(LinkDesc="TogFire")
	InputLinks[3]=(LinkDesc="Kill")

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="S")
	OutputLinks[1]=(LinkDesc="M")
	OutputLinks[2]=(LinkDesc="F")
	OutputLinks[3]=(LinkDesc="SF")
	OutputLinks[4]=(LinkDesc="K")
	OutputLinks[5]=(LinkDesc="AUX")


	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Int',LinkDesc="Start",bWriteable=true,PropertyName=Start)
	VariableLinks[1]=(ExpectedType=class'SeqVar_Int',LinkDesc="MoveTo",bWriteable=true,PropertyName=MoveTo)
	VariableLinks[2]=(ExpectedType=class'SeqVar_Int',LinkDesc="Delay",bWriteable=true,PropertyName=Wait)
}
