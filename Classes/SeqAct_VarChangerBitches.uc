// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAct_VarChangerBitches extends SequenceAction;

var object AI;

event Activated()
{
	local BF_AI_GunShip LAI;
	LAI = BF_AI_GunShip(AI);
		LAI.FM = 0;
	AI = LAI;




}

defaultproperties
{
	ObjName="AI Var Changer"
	ObjCategory="BF Actions"

	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="AI",bWriteable=true,PropertyName=AI)
}
