class SeqCond_BayLevel extends SequenceCondition;

var BF_Enemy_Base Enemy;
var bool BOS;
var bool LOS;

event Activated()
{
	if(InputLinks[0].bHasImpulse){
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.BayOpen==false && BOS!=true){
			OutputLinks[0].bHasImpulse=true;
			BOS=true;
		}else{
			OutputLinks[1].bHasImpulse=true;
		}
		if((BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.B1.Level>=3 || BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.B2.Level>=3 || BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.B3.Level>=3) && LOS!=true){
			OutputLinks[2].bHasImpulse=true;
			LOS=true;
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
