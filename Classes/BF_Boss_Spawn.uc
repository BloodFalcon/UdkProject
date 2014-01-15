// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class BF_Boss_Spawn extends SequenceAction;

var BF_Boss_Main Boss;
var() class<BF_Boss_Main> BossType;
var() actor Target;
var() class<BF_Boss_Aux> AuxType1;
var Object AuxAtt;
var Object BossBody;

event Activated()
{
	local vector SockLoc;
	local Rotator SockRot;
	local Actor A;
	//if(InputLinks[0].bHasImpulse==true){
		Boss = Target.Spawn(BossType,,,Target.Location,Target.Rotation,,);
		//B=Boss.Mesh.GetSocketByName('W1');
		if(Boss.Mesh.GetSocketByName('W1')!=none){
			Boss.Mesh.GetSocketWorldLocationAndRotation('W1',SockLoc,SockRot);
			A = Boss.Spawn(AuxType1,Boss,,SockLoc,SockRot,,);
			AuxAtt=A;
			BossBody=Boss;
			OutputLinks[0].bHasImpulse=true;

		//}
	}
}

defaultproperties
{
	ObjName="Spawn Boss"
	ObjCategory="BF Boss"

	bAutoActivateOutputLinks=false

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="Attach")

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Start")

	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="Target",PropertyName=Target,MaxVars=1,MinVars=1)
	VariableLinks[1]=(ExpectedType=class'SeqVar_Object',LinkDesc="Attachment",bHidden=false,PropertyName=AuxAtt,bWriteable=true)
	VariableLinks[2]=(ExpectedType=class'SeqVar_Object',LinkDesc="Boss Body",bHidden=false,PropertyName=BossBody,bWriteable=true)
}
