//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/20/2013
// Status: Alpha
// Being Used: Yes
// Description: Weapon Systems for Player
//////////////////////////

class SeqAct_ProjectileSpawner extends SequenceAction;

var() class<Projectile> PC0;
var() class<Projectile> PC1;
var() class<Projectile> PC2;
var() class<Projectile> PC3;
var() class<Projectile> PC4;
var() class<Projectile> PC5;
var() class<Projectile> PC6;
var() class<Projectile> PC7;

var bool Absorb;
var bool Basic;
var bool W1;
var bool W2;
var bool W3;
var bool W4;
var bool W5;
var bool W6;

event Activated()
{
	local Controller InstigatorController;
	local Pawn InstigatorPawn;
	local vector SpawnLoc, TargetLoc;
	local Projectile Proj;

	Absorb = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Absorb;
	Basic = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Basic;
	W1 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W1;
	W2 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W2;
	W3 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W3;
	W4 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W4;
	W5 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W5;
	W6 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W6;


	if ( VariableLinks.length < 3 || VariableLinks[0].LinkedVariables.length == 0 ||
		VariableLinks[1].LinkedVariables.length == 0 || VariableLinks[16].LinkedVariables.length == 0 )
	{
		ScriptLog("ERROR: All variable links must be filled");
	}
	else
	{
		// get the instigator
		if (VariableLinks[16].LinkedVariables.length > 0)
		{
			InstigatorController = Controller(SeqVar_Object(VariableLinks[16].LinkedVariables[0]).GetObjectValue());
			if (InstigatorController != None)
			{
				InstigatorPawn = InstigatorController.Pawn;
			}
			else
			{
				InstigatorPawn = Pawn(SeqVar_Object(VariableLinks[16].LinkedVariables[0]).GetObjectValue());
				if (InstigatorPawn != None)
				{
					InstigatorController = InstigatorPawn.Controller;
				}
				else if (SeqVar_Object(VariableLinks[16].LinkedVariables[0]).GetObjectValue() != None)
				{
					ScriptLog("ERROR: Instigator specified for" @ self @ "is not a Controller");
				}
			}
		}
		if(Absorb)
		{
		// get the spawn location
		SpawnLoc = SeqVar_Vector(VariableLinks[0].LinkedVariables[0]).VectValue;
		TargetLoc = SeqVar_Vector(VariableLinks[1].LinkedVariables[0]).VectValue;

		// spawn a projectile at the requested location and point it at the requested target
		Proj = GetWorldInfo().Spawn(PC0,,, SpawnLoc);
		if (InstigatorController != None)
		{
			Proj.Instigator = InstigatorPawn;
			Proj.InstigatorController = InstigatorController;
		}
		Proj.Init(Normal(TargetLoc - SpawnLoc));
		}else{
			if(Basic)
			{
			// get the spawn location
			SpawnLoc = SeqVar_Vector(VariableLinks[2].LinkedVariables[0]).VectValue;
			TargetLoc = SeqVar_Vector(VariableLinks[3].LinkedVariables[0]).VectValue;

			// spawn a projectile at the requested location and point it at the requested target
			Proj = GetWorldInfo().Spawn(PC1,,, SpawnLoc);
			if (InstigatorController != None)
			{
				Proj.Instigator = InstigatorPawn;
				Proj.InstigatorController = InstigatorController;
			}
			Proj.Init(Normal(TargetLoc - SpawnLoc));
			}

			if(W1)
			{
			// get the spawn location
			SpawnLoc = SeqVar_Vector(VariableLinks[4].LinkedVariables[0]).VectValue;
			TargetLoc = SeqVar_Vector(VariableLinks[5].LinkedVariables[0]).VectValue;

			// spawn a projectile at the requested location and point it at the requested target
			Proj = GetWorldInfo().Spawn(PC2,,, SpawnLoc);
			if (InstigatorController != None)
			{
				Proj.Instigator = InstigatorPawn;
				Proj.InstigatorController = InstigatorController;
			}
			Proj.Init(Normal(TargetLoc - SpawnLoc));
			}

			if(W2)
			{
			// get the spawn location
			SpawnLoc = SeqVar_Vector(VariableLinks[6].LinkedVariables[0]).VectValue;
			TargetLoc = SeqVar_Vector(VariableLinks[7].LinkedVariables[0]).VectValue;

			// spawn a projectile at the requested location and point it at the requested target
			Proj = GetWorldInfo().Spawn(PC3,,, SpawnLoc);
			if (InstigatorController != None)
			{
				Proj.Instigator = InstigatorPawn;
				Proj.InstigatorController = InstigatorController;
			}
			Proj.Init(Normal(TargetLoc - SpawnLoc));
			}

			if(W3)
			{
			// get the spawn location
			SpawnLoc = SeqVar_Vector(VariableLinks[8].LinkedVariables[0]).VectValue;
			TargetLoc = SeqVar_Vector(VariableLinks[9].LinkedVariables[0]).VectValue;

			// spawn a projectile at the requested location and point it at the requested target
			Proj = GetWorldInfo().Spawn(PC4,,, SpawnLoc);
			if (InstigatorController != None)
			{
				Proj.Instigator = InstigatorPawn;
				Proj.InstigatorController = InstigatorController;
			}
			Proj.Init(Normal(TargetLoc - SpawnLoc));
			}

			if(W4)
			{
			// get the spawn location
			SpawnLoc = SeqVar_Vector(VariableLinks[10].LinkedVariables[0]).VectValue;
			TargetLoc = SeqVar_Vector(VariableLinks[11].LinkedVariables[0]).VectValue;

			// spawn a projectile at the requested location and point it at the requested target
			Proj = GetWorldInfo().Spawn(PC5,,, SpawnLoc);
			if (InstigatorController != None)
			{
				Proj.Instigator = InstigatorPawn;
				Proj.InstigatorController = InstigatorController;
			}
			Proj.Init(Normal(TargetLoc - SpawnLoc));
			}

			if(W5)
			{
			// get the spawn location
			SpawnLoc = SeqVar_Vector(VariableLinks[12].LinkedVariables[0]).VectValue;
			TargetLoc = SeqVar_Vector(VariableLinks[13].LinkedVariables[0]).VectValue;

			// spawn a projectile at the requested location and point it at the requested target
			Proj = GetWorldInfo().Spawn(PC6,,, SpawnLoc);
			if (InstigatorController != None)
			{
				Proj.Instigator = InstigatorPawn;
				Proj.InstigatorController = InstigatorController;
			}
			Proj.Init(Normal(TargetLoc - SpawnLoc));
			}

			if(W6)
			{
			// get the spawn location
			SpawnLoc = SeqVar_Vector(VariableLinks[14].LinkedVariables[0]).VectValue;
			TargetLoc = SeqVar_Vector(VariableLinks[15].LinkedVariables[0]).VectValue;

			// spawn a projectile at the requested location and point it at the requested target
			Proj = GetWorldInfo().Spawn(PC7,,, SpawnLoc);
			if (InstigatorController != None)
			{
				Proj.Instigator = InstigatorPawn;
				Proj.InstigatorController = InstigatorController;
			}
			Proj.Init(Normal(TargetLoc - SpawnLoc));
			}
		}
	}
}


defaultproperties
{
	
	bCallHandler=false
	ObjName="Projectile Spawner"
	ObjCategory="BF Actions"
	VariableLinks(0)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" A  SL",MinVars=1,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" A  TL",MinVars=1,MaxVars=1)
		VariableLinks(2)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" B  SL",MinVars=1,MaxVars=1)
		VariableLinks(3)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" B  TL",MinVars=1,MaxVars=1)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P1 SL",MinVars=1,MaxVars=1)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P1 TL",MinVars=1,MaxVars=1)
		VariableLinks(6)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P2 SL",MinVars=1,MaxVars=1)
		VariableLinks(7)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P2 TL",MinVars=1,MaxVars=1)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P3 SL",MinVars=1,MaxVars=1)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P3 TL",MinVars=1,MaxVars=1)
		VariableLinks(10)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P4 SL",MinVars=1,MaxVars=1)
		VariableLinks(11)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P4 TL",MinVars=1,MaxVars=1)
	VariableLinks(12)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P5 SL",MinVars=1,MaxVars=1)
	VariableLinks(13)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P5 TL",MinVars=1,MaxVars=1)
		VariableLinks(14)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P6 SL",MinVars=1,MaxVars=1)
		VariableLinks(15)=(ExpectedType=class'SeqVar_Vector',LinkDesc=" P6 TL",MinVars=1,MaxVars=1)
	VariableLinks(16)=(ExpectedType=class'SeqVar_Object',LinkDesc="Instigator",MinVars=0,MaxVars=1)
   
}
