//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Modify Vector Components with one Node
//////////////////////////

class SeqAct_AddToVect extends SequenceAction;

var vector InVector;
var vector OutVector;
var float X, Y, Z;

event Activated()
{
		OutVector.X = (InVector.X + X);
		OutVector.Y = (InVector.Y + Y);
		OutVector.Z = (InVector.Z + Z);
		OutputLinks[0].bHasImpulse = true;
}


defaultproperties
{
	ObjName="Add To Vector"
	ObjCategory="BF Actions"

	VariableLinks.Empty
	VariableLinks(0)=(ExpectedType=class'SeqVar_Vector',LinkDesc="In V", PropertyName=InVector)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Float',LinkDesc="X",PropertyName=X)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Float',LinkDesc="Y",PropertyName=Y)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Float',LinkDesc="Z",PropertyName=Z)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Vector',LinkDesc="Out V",bWriteable=true,PropertyName=OutVector)
}
