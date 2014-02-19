class SeqAct_BloodMeter extends SequenceCondition;

event Activated()
{
BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter=10;
}

defaultproperties
{
	ObjName="Fill BloodMeter"
	ObjCategory="BF Actions"

	bAutoActivateOutputLinks=true

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="Out")

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="In")
	
	VariableLinks.Empty
}
