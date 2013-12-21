class BF_Proj_EnemyPatterns extends SequenceAction;

var BF_Enemy_Base CurEn;
var() int AngularWidth; /** 360deg = 65536rot **/
var() int Bullets;
var() float Rate;
var() class<BF_Proj_Base> ProjType;
var bool run; //extra
var BF_Proj_Base MyProj;

enum EFireType
{
	Straight,
	Scatter,
	Arc,
};

var() EFireType FireType;

event Activated()
{
	if(FireType==Straight){
		Straight();
	}else if(FireType==Scatter){
		Scatter();
	}else if(FireType==Arc){
		Arc();
	}
}

function tick(float DeltaTime)
{
	if(run){
		MyProj = CurEn.spawn(ProjType, CurEn,, CurEn.Location, CurEn.Rotation);
		MyProj.Init(vector(CurEn.Rotation));
	}
}

function Straight()
{
	run=true;
}

function Scatter()
{

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
	VariableLinks[1]=(ExpectedType=class'SeqVar_Float',LinkDesc="Rate",bHidden=true,PropertyName=Rate)
	VariableLinks[2]=(ExpectedType=class'SeqVar_Int',LinkDesc="Width",bHidden=true,PropertyName=AngularWidth)
	VariableLinks[3]=(ExpectedType=class'SeqVar_Int',LinkDesc="Bullets",bHidden=true,PropertyName=Bullets)

	//Variable Defaults
	//ProjType=class'BF_Proj_Missile'
	run=false
}
