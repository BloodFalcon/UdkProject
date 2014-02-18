class SeqCond_CheckHealth extends SequenceCondition;

var BF_Enemy_Base Enemy;
var byte count;

event Activated()
{
	if(InputLinks[0].bHasImpulse){
		if((Enemy.Controller==none || Enemy==none || Enemy.Mesh==none) && count==0){
			OutputLinks[0].bHasImpulse=true;
			count++;
		}
	}
	OutputLinks[1].bHasImpulse=true;
}

defaultproperties
{
	ObjName="Check Health"
	ObjCategory="Tut Level"

	bAutoActivateOutputLinks=false

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="Dead")
	OutputLinks[1]=(LinkDesc="Alive")

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Check")
	
	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="Enemy",PropertyName=Enemy,bWriteable=false)
}
