class SeqCond_DeathorAbsorb extends SequenceCondition;

var BF_Boss_1 Boss;
var BF_AI_Boss_1 BossController;
var Object BossIn;
var name CurState;


event Activated()
{
	Boss=BF_Boss_1(BossIn);
	BossController=BF_AI_Boss_1(Boss.Controller);
	BossController.IsInState(CurState);
	if(CurState=='Swarm1'){
		OutputLinks[0].bHasImpulse=true;
	}else if(CurState=='Swarm2'){
		OutputLinks[1].bHasImpulse=true;
	}else{
		OutputLinks[2].bHasImpulse=true;
	}
}


defaultproperties
{
	ObjName="Check State"
	ObjCategory="BF Boss"

	bAutoActivateOutputLinks=false

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="1")
	OutputLinks[1]=(LinkDesc="2")
	OutputLinks[2]=(LinkDesc="false")

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Check")
	
	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="Boss",PropertyName=BossIn,bWriteable=false)
}
