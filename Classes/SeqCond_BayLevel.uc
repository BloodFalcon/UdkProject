class SeqCond_BayLevel extends SequenceCondition;

var BF_Enemy_Base Enemy;

event Activated()
{
	if(InputLinks[0].bHasImpulse){
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).RemainingBays<=0){
			OutputLinks[0].bHasImpulse=true;
		}else{
			OutputLinks[1].bHasImpulse=true;
		}
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.B1.Level>=3 || BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.B2.Level>=3 || BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.B3.Level>=3){
			OutputLinks[2].bHasImpulse=true;
		}else{
			OutputLinks[3].bHasImpulse=true;
		}
	}
}

defaultproperties
{
	ObjName="Check Bays and Levels"
	ObjCategory="Tut Level"

	bAutoActivateOutputLinks=false

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="Full Bays")
	OutputLinks[1]=(LinkDesc="Not Full")
	OutputLinks[2]=(LinkDesc="Level 3")
	OutputLinks[3]=(LinkDesc="Not 3")

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Check")
	
	VariableLinks.Empty
}
