class BF_Proj_EnemyPatterns extends SequenceAction;

enum EFireType
{
	Straight,
	Scatter,
	Arc,
};
var Object CurEn;
var BF_Enemy_Base CastEn;
var() EFireType FireType;
var() int AngularWidth; /** 360deg = 65536rot **/
var() int Bullets;
var() float Rate;
var() class<BF_Proj_Base> ProjType;
var BF_Proj_Base MyProj;
var Rotator SpreadIncrement;
var Rotator SpreadOffset;
var int BulletsLeft;


event Activated()
{
	CastEn=BF_Enemy_Base(CurEn);
	if(InputLinks[2].bHasImpulse || CurEn==none){
		OutputLinks[1].bHasImpulse=true;
	}else{
		if(FireType==Straight){
			Straight();
		}else if(FireType==Scatter){
			Scatter();
		}else if(FireType==Arc){
			Arc();
		}
	}
}

function Straight()
{
	MyProj = CastEn.spawn(ProjType, CastEn,, CastEn.Location, CastEn.Rotation);
	MyProj.Init(vector(CastEn.Rotation));
	OutputLinks[0].bHasImpulse=true;
}

function Scatter()
{
	SpreadIncrement.Yaw = (AngularWidth*DegToUnrRot)/Bullets;
	BulletsLeft=Bullets;
	SpreadOffset.Yaw = (AngularWidth*DegToUnrRot)/2;
	
	while(BulletsLeft>0){
		BulletsLeft--;
		MyProj = CastEn.spawn(ProjType, CastEn,, CastEn.Location, CastEn.Rotation); //MUST RENAME SOCKETS FOR PRECISE SPAWN LOCATION
		MyProj.Init(vector(CastEn.Rotation+SpreadOffset));
		SpreadOffset-=SpreadIncrement;
	}

	OutputLinks[0].bHasImpulse=true;
}

function Arc()
{

}


DefaultProperties
{
	ObjName="Fire Patterns"
	ObjCategory="BF Controllers"

	bAutoActivateOutputLinks=false

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="PerShot")
	OutputLinks[1]=(LinkDesc="Done")

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Fire")
	InputLinks[1]=(LinkDesc="OneShot")
	InputLinks[2]=(LinkDesc="Stop")

	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="Enemy",PropertyName=CurEn)
	VariableLinks[1]=(ExpectedType=class'SeqVar_Float',LinkDesc="Rate",bHidden=true,PropertyName=Rate,MaxVars=1,MinVars=0)
	VariableLinks[2]=(ExpectedType=class'SeqVar_Int',LinkDesc="Width",bHidden=true,PropertyName=AngularWidth,MaxVars=1,MinVars=0)
	VariableLinks[3]=(ExpectedType=class'SeqVar_Int',LinkDesc="Bullets",bHidden=true,PropertyName=Bullets,MaxVars=1,MinVars=0)

	//Variable Defaults
	Rate=1.0
	AngularWidth=90
	Bullets=3
}
