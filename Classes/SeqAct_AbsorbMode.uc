// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAct_AbsorbMode extends SequenceAction;

	var bool P1;

event Activated()
{

	if(InputLinks[0].bHasImpulse == true){
		BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).P0 = true;
	}

	if(InputLinks[1].bHasImpulse == true){
		BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).P0 = false;
	}


}

defaultproperties
{
	ObjName="Absorb Mode Toggle"
	ObjCategory="BF Actions"

	InputLinks[0]=(LinkDesc="Absorb")
	InputLinks[1]=(LinkDesc="Weapon")

	VariableLinks.Empty

}
