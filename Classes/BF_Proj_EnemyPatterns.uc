class BF_Proj_EnemyPatterns extends BF_Enemy_Base;

var BF_Enemy_Base CurEn;
var() int AngularWidth;
var() int Bullets;
var() byte PatternNum;

function Straight()
{



}

function Scatter()
{



}


DefaultProperties
{
	ObjName="Fire Patterns"
	ObjCategory="BF Controllers"

	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Fire")
	InputLinks[1]=(LinkDesc="OneShot")
	InputLinks[2]=(LinkDesc="Stop")

	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="Enemy",PropertyName=CurEn)
	VariableLinks[1]=(ExpectedType=class'SeqVar_Byte',LinkDesc="Pattern",PropertyName=PatternNum)
	VariableLinks[2]=(ExpectedType=class'SeqVar_Int',LinkDesc="Width",bHidden=true,PropertyName=AngularWidth)
	VariableLinks[3]=(ExpectedType=class'SeqVar_Int',LinkDesc="Bullets",bHidden=true,PropertyName=Bullets)
}
