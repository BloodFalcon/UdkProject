//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Toggle for Absorbtion Mode
//////////////////////////

class SeqAct_AbsorbMode extends SequenceAction;

event Activated()
{


	if(InputLinks[0].bHasImpulse == true){
		OutputLinks[0].bHasImpulse = true;
		OutputLinks[1].bDisabled = true;
	}

	if(InputLinks[1].bHasImpulse == true){
		//BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Absorb = false;
		OutputLinks[0].bDisabled = true;
		OutputLinks[1].bDisabled = true;
	}

	if(InputLinks[2].bHasImpulse == true){
		//BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Absorb = true;
		OutputLinks[1].bHasImpulse = true;
		OutputLinks[0].bDisabled = true;
	}

}

defaultproperties
{
	ObjName="Absorb Mode Toggle"
	ObjCategory="BF Actions"

	OutputLinks[0]=(LinkDesc="L")
	OutputLinks[1]=(LinkDesc="R")

	InputLinks[0]=(LinkDesc="Basic")
	InputLinks[1]=(LinkDesc="Released")
	InputLinks[2]=(LinkDesc="Absorb")

	VariableLinks.Empty

}
