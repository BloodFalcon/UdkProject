class SeqControl_Boss extends SequenceAction;

event Activated()
{



}

defaultproperties
{
	ObjName="Boss Controller"
	ObjCategory="BF Controllers"

	bAutoActivateOutputLinks=false
	
	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Start")

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="Spawn")


	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="NextNode",bWriteable=true,PropertyName=NextNode,bHidden=true)
}
