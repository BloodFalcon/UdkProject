//////////////////////////
// Author(s): Tyler Keller
// Date: 11/14/2013
// Status: Alpha
// Being Used: Yes
// Description: Rule set for random world generation
//////////////////////////

class SeqAct_RandGen extends SequenceAction;

var() Material Previous;
var() Material PreviousRow;
var() Material NewMat;
var int GenMat;

event Activated()
{
	if(InputLinks[0].bHasImpulse)
	{
		if(Previous == Material'BloodFalcon.Material.BFGrass' )  ///////////PREGRASS
		{
			if(PreviousRow == Material'BloodFalcon.Material.BFGrass' )
			{
			NewMat = Material'BloodFalcon.Material.BFGrass';
			}
			else if(PreviousRow == Material'BloodFalcon.Material.BFSand' )
			{
				GenMat = Rand(2);
				if(GenMat == 0)
				{
					NewMat = Material'BloodFalcon.Material.BFGrass';
					}else{
					NewMat = Material'BloodFalcon.Material.BFSand';
				}
			}
			else if(PreviousRow == Material'BloodFalcon.Material.BFWater' )
			{
				NewMat = Material'BloodFalcon.Material.BFSand';
			}
		}
		else if(Previous == Material'BloodFalcon.Material.BFSand' ) ///////////PRESAND
		{
			if(PreviousRow == Material'BloodFalcon.Material.BFGrass' )
			{
				GenMat = Rand(5);
				if(GenMat == 0)
				{
					NewMat = Material'BloodFalcon.Material.BFGrass';
					}else{
					NewMat = Material'BloodFalcon.Material.BFSand';
				}
			}
			else if(PreviousRow == Material'BloodFalcon.Material.BFSand' )
			{
				GenMat = Rand(5);
				if(GenMat == 0)
				{
					NewMat = Material'BloodFalcon.Material.BFGrass';
					}
					else if(GenMat == 1)
					{
					NewMat = Material'BloodFalcon.Material.BFSand';
					}else{
					NewMat = Material'BloodFalcon.Material.BFWater';
				}
			}
			else if(PreviousRow == Material'BloodFalcon.Material.BFWater' )
			{
				GenMat = Rand(5);
				if(GenMat == 0)
				{
					NewMat = Material'BloodFalcon.Material.BFSand';
					}else{
					NewMat = Material'BloodFalcon.Material.BFWater';
				}			
			}
		}
		else if(Previous == Material'BloodFalcon.Material.BFWater' ) ///////////PREWater
		{
			if(PreviousRow == Material'BloodFalcon.Material.BFGrass' )
			{
				NewMat = Material'BloodFalcon.Material.BFSand';
			}
			else if(PreviousRow == Material'BloodFalcon.Material.BFSand' )
			{
				GenMat = Rand(5);
				if(GenMat == 0)
				{
					NewMat = Material'BloodFalcon.Material.BFSand';
					}else{
					NewMat = Material'BloodFalcon.Material.BFWater';
				}				
			}
			else if(PreviousRow == Material'BloodFalcon.Material.BFWater' )
			{
				GenMat = Rand(3);
				if(GenMat == 0)
				{
					NewMat = Material'BloodFalcon.Material.BFWater';
					}
					else if(GenMat == 1)
					{
					NewMat = Material'BloodFalcon.Material.BFSand';
					}else{
					NewMat = Material'BloodFalcon.Material.BFWater';
				}			
			}
		}

		OutputLinks[0].bHasImpulse = TRUE;
	}
}


defaultproperties
{
	ObjName="RandGen"
	ObjCategory="BF Actions"

	InputLinks[0]=(LinkDesc="In")
	OutputLinks[0]=(LinkDesc="Out")

	VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="Pre",PropertyName=Previous)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Object',LinkDesc="PreRow",PropertyName=PreviousRow)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Object',LinkDesc="List Index",bWriteable=true,PropertyName=NewMat)

}
