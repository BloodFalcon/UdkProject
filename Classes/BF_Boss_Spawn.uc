class BF_Boss_Spawn extends SequenceAction;

var BF_Boss_Main Boss;
var() class<BF_Boss_Main> BossType;
var() class<BF_Boss_Aux> Gun;
var() array<name> GunsSocks;
var() class<BF_Boss_Aux> Turret;
var() array<name> TurretSocks;
var() class<BF_Boss_Aux> BodyPiece;
var() array<name> BodyPieceSocks;
var() actor Target;
var Object BossOut;


event Activated()
{
	local vector SockLoc;
	local Rotator SockRot;
	local BF_Boss_Aux A;
	local int ArrayPos;
	local name SockName;
	ArrayPos=0;

	Boss=Target.Spawn(BossType,,,Target.Location,Target.Rotation,,);
	while(ArrayPos<=(GunsSocks.Length-1)){
		SockName=GunsSocks[ArrayPos];
		if(Boss.Mesh.GetSocketByName(SockName)!=none){
			Boss.Mesh.GetSocketWorldLocationAndRotation(SockName,SockLoc,SockRot);
			A=Boss.Spawn(Gun,Boss,,SockLoc,SockRot,,);
			A.BossBase=Boss;
			A.Sock=SockName;
			BossOut=Boss;
		}
		ArrayPos++;
	}
	ArrayPos=0;

	while(ArrayPos<=(TurretSocks.Length-1)){
	SockName=TurretSocks[ArrayPos];
	if(Boss.Mesh.GetSocketByName(SockName)!=none){
		Boss.Mesh.GetSocketWorldLocationAndRotation(SockName,SockLoc,SockRot);
		A=Boss.Spawn(Turret,Boss,,SockLoc,SockRot,,);
		A.BossBase=Boss;
		A.Sock=SockName;
		BossOut=Boss;
	}
	ArrayPos++;
	}
	ArrayPos=0;

	while(ArrayPos<=(BodyPieceSocks.Length-1)){
		SockName=BodyPieceSocks[ArrayPos];
		if(Boss.Mesh.GetSocketByName(SockName)!=none){
			Boss.Mesh.GetSocketWorldLocationAndRotation(SockName,SockLoc,SockRot);
			A=Boss.Spawn(BodyPiece,Boss,,SockLoc,SockRot,,);
			A.BossBase=Boss;
			A.Sock=SockName;
			BossOut=Boss;
		}
		ArrayPos++;
	}
	ArrayPos=0;
	OutputLinks[0].bHasImpulse=true;
}


defaultproperties
{
	ObjName="Spawn Boss"
	ObjCategory="BF Boss"

	bAutoActivateOutputLinks=false

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="Done")

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Spawn")

	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="Location",PropertyName=Target,MaxVars=1,MinVars=1)
	VariableLinks[1]=(ExpectedType=class'SeqVar_Object',LinkDesc="Boss",PropertyName=BossOut,bWriteable=true)
}

