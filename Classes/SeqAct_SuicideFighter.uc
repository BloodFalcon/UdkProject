class SeqAct_SuicideFighter extends SequenceAction;


var int MoveTo;
var int Start;
var int i;
var BF_Enemy_SuicideFighter Fighter;

event Activated()
{
	if(InputLinks[0].bHasImpulse==true){
		Start = RandRange(74,78);
		MoveTo = Start;
		OutputLinks[0].bHasImpulse=true;
	}
	
	if(InputLinks[1].bHasImpulse==true){
		if(i==0)
		{
		MoveTo-=9;
		FreezeFighter();
		i++;
		}
		OutputLinks[1].bHasImpulse=true;
	}
	if(InputLinks[2].bHasImpulse==true){
		if(i==1){
			MoveTo-=9;
			i++;
		}
		else{
			MoveTo-=9;
			i=0;
		}
		OutputLinks[2].bHasImpulse=true;
	}

	if(InputLinks[3].bHasImpulse==true || Start<0){
		OutputLinks[3].bHasImpulse=true;
	}
}

function FreezeFighter()
{
	`log("Fighter Frozen");
	
}

defaultproperties
{
	i=0
	MoveTo=0
	Start=85

	bAutoActivateOutputLinks=false

	ObjName="Suicide Pattern"
	ObjCategory="BF Patterns"
	
	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Spawn")
	InputLinks[1]=(LinkDesc="Move to Screen")
	InputLinks[2]=(LinkDesc="Dive Bomb")
	InputLinks[3]=(LinkDesc="Kill")

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="S")
	OutputLinks[1]=(LinkDesc="M")
	OutputLinks[2]=(LinkDesc="Dive Bomb")
	OutputLinks[3]=(LinkDesc="K")


	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Int',LinkDesc="Start",bWriteable=true,PropertyName=Start)
	VariableLinks[1]=(ExpectedType=class'SeqVar_Int',LinkDesc="MoveTo",bWriteable=true,PropertyName=MoveTo)
	VariableLinks[2]=(ExpectedType=class'SeqVar_Int',LinkDesc="Dive Location",bWriteable=true,PropertyName=DiveLocation)
}

