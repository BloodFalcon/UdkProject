class SeqAct extends SequenceAction;

var BF_Enemy_GunShip CurEn;

event Activated()
{

	if(InputLinks[0].bHasImpulse){
		CurEn.FireWeaps = true;
	}else{
		CurEn.FireWeaps = false;
	}
}

defaultproperties
{
	ObjName="Fire Control"
	ObjCategory="BF Controllers"

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="On")
	InputLinks[1]=(LinkDesc="Off")


	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="Enemy",PropertyName=CurEn)
}
