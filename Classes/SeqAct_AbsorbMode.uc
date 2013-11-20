//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Toggle for Absorbtion Mode
//////////////////////////

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
