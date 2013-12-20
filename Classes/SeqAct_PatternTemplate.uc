class SeqAct_PatternTemplate extends SequenceAction;

var() float Delay0;
var() Actor Node0;
var() bool Fire0;
var() float Delay1;
var() Actor Node1;
var() bool Fire1;
var() float Delay2;
var() Actor Node2;
var() bool Fire2;
var() float Delay3;
var() Actor Node3;
var() bool Fire3;
var() float Delay4;
var() Actor Node4;
var() bool Fire4;
var() float Delay5;
var() Actor Node5;
var() bool Fire5;
var() float Delay6;
var() Actor Node6;
var() bool Fire6;
var() float Delay7;
var() Actor Node7;
var() bool Fire7;
var() float Delay8;
var() Actor Node8;
var() bool Fire8;
var() float Delay9;
var() Actor Node9;
var() bool Fire9;
var() float Delay10;
var() Actor Node10;
var() bool Fire10;
var() float Delay11;
var() Actor Node11;
var() bool Fire11;
var() float Delay12;
var() Actor Node12;
var() bool Fire12;
var() float Delay13;
var() Actor Node13;
var() bool Fire13;
var() float Delay14;
var() Actor Node14;
var() bool Fire14;
var() float Delay15;
var() Actor Node15;
var() bool Fire15;
var() float Delay16;
var() Actor Node16;
var() bool Fire16;

var int step;
var int Offset;
var float Delay;
var Object NextNode;
var bool Abort;
var bool Fire;

event Activated()
{

if(NextNode.IsA('BF_Enemy_GunShip')){

	}
	if(Node0 != none && step == 0){
		Delay = Delay0;
		NextNode = Node0;
		Fire = Fire0;
		step = 1;
		OutputLinks[0].bHasImpulse=true;
	}else if(Node1 != none && step == 1){
		Delay = Delay1;
		NextNode = Node1;
		Fire = Fire1;
		step = 2;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node2 != none && step == 2){
		Delay = Delay2;
		NextNode = Node2;
		Fire = Fire2;
		step = 3;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node3 != none && step == 3){
		Delay = Delay3;
		NextNode = Node3;
		Fire = Fire3;
		step = 4;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node4 != none && step == 4){
		Delay = Delay4;
		NextNode = Node4;
		Fire = Fire4;
		step = 5;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node5 != none && step == 5){
		Delay = Delay5;
		NextNode = Node5;
		Fire = Fire5;
		step = 6;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node6 != none && step == 6){
		Delay = Delay6;
		NextNode = Node6;
		Fire = Fire6;
		step = 7;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node7 != none && step == 7){
		Delay = Delay7;
		NextNode = Node7;
		Fire = Fire7;
		step = 8;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node8 != none && step == 8){
		Delay = Delay8;
		NextNode = Node8;
		Fire = Fire8;
		step = 9;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node9 != none && step == 9){
		Delay = Delay9;
		NextNode = Node9;
		Fire = Fire9;
		step = 10;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node10 != none && step == 10){
		Delay = Delay10;
		NextNode = Node10;
		Fire = Fire10;
		step = 11;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node11 != none && step == 11){
		Delay = Delay11;
		NextNode = Node11;
		Fire = Fire11;
		step = 12;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node12 != none && step == 12){
		Delay = Delay12;
		NextNode = Node12;
		Fire = Fire12;
		step = 13;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node13 != none && step == 13){
		Delay = Delay13;
		NextNode = Node13;
		Fire = Fire13;
		step = 14;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node14 != none && step == 14){
		Delay = Delay14;
		NextNode = Node14;
		Fire = Fire14;
		step = 15;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node15 != none && step == 15){
		Delay = Delay15;
		NextNode = Node15;
		Fire = Fire15;
		step = 16;
		OutputLinks[1].bHasImpulse=true;
	}else if(Node16 != none && step == 16){
		Delay = Delay16;
		NextNode = Node16;
		Fire = Fire16;
		step = 17;
		OutputLinks[1].bHasImpulse=true;
	}else{
		step = 0;
		OutputLinks[2].bHasImpulse=true;
	}


}

defaultproperties
{
	step = 0
	Abort = 0
	Delay = 0
	Offset = 0
	Fire = 0

	ObjName="Pattern Template"
	ObjCategory="BF Patterns"

	bAutoActivateOutputLinks=false
	
	InputLinks.Empty
	InputLinks[0]=(LinkDesc="Start")

	OutputLinks.Empty
	OutputLinks[0]=(LinkDesc="Spawn")
	OutputLinks[1]=(LinkDesc="Move")
	OutputLinks[2]=(LinkDesc="Done")

	VariableLinks.Empty
	VariableLinks[0]=(ExpectedType=class'SeqVar_Object',LinkDesc="NextNode",bWriteable=true,PropertyName=NextNode)
	VariableLinks[1]=(ExpectedType=class'SeqVar_Float',LinkDesc="Delay",bWriteable=true,PropertyName=Delay)
	VariableLinks[2]=(ExpectedType=class'SeqVar_Bool',LinkDesc="Fire",bWriteable=true,PropertyName=Fire)
	
	//VariableLinks[3]=(ExpectedType=class'SeqVar_Object',LinkDesc="Enemy",PropertyName=Enemy)
	
	//VariableLinks[3]=(ExpectedType=class'SeqVar_Bool',LinkDesc="Abort",bWriteable=true,PropertyName=Abort)

	//VariableLinks[0]=(ExpectedType=class'SeqVar_Int',LinkDesc="Offset",bWriteable=true,PropertyName=Offset)
}
