// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class SeqAct_MarkAsKillable extends SequenceAction;

var BF_Enemy_Base Enemy;


event Activated()
{
	if(InputLinks[0].bHasImpulse){
		if(Enemy!=none){
			Enemy.killable=true;
		}
	}else{
		if(Enemy!=none){
			Enemy.killable=false;
		}
	}
}

defaultproperties
{
	ObjName="Mark As Killable"
	ObjCategory="Tut Level"

	bAutoActivateOutputLinks=false

	OutputLinks.Empty

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Killable")
	InputLinks[1]=(LinkDesc="Invincible")
	
	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="Enemy",PropertyName=Enemy,bWriteable=true)
}
