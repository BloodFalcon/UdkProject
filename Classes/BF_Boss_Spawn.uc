// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class BF_Boss_Spawn extends SequenceAction;

var BF_Boss_Main Boss;
var() class<BF_Boss_Main> BossType;
var() actor Target;
var() class<BF_Boss_Aux> AuxType1;

event Activated()
{
	local vector SockLoc;
	local Rotator SockRot;
	local Actor A;
	//local SkeletalMeshSocket B;
	//local StaticMeshComponent C;
	//if(InputLinks[0].bHasImpulse==true){
		Boss = Target.Spawn(BossType,,,Target.Location,Target.Rotation,,false);
		
		if(Boss.Mesh.GetSocketByName('W1')!=none){
			Boss.Mesh.GetSocketWorldLocationAndRotation('W1',SockLoc,SockRot);
			//B = Boss.Mesh.GetSocketByName('W1');
			A = Boss.Spawn(AuxType1,Boss,,SockLoc,SockRot,,false);
			A.SetBase(Boss,,Boss.Mesh,'W1');
		//}
	}
}

defaultproperties
{
	ObjName="Spawn Boss"
	ObjCategory="BF Boss"

	bAutoActivateOutputLinks=false

	OutputLinks.Empty
	//OutputLinks[0]=(LinkDesc="PerShot")

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Start")

	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="Target",PropertyName=Target,MaxVars=1,MinVars=1)
	//VariableLinks[1]=(ExpectedType=class'SeqVar_Float',LinkDesc="Rate",bHidden=true,PropertyName=Rate,MaxVars=1,MinVars=0)
}
