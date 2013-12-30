class BF_SoulInventory;

/**Current Ship Inventory*/
var CollectedSouls CS; 

struct SoulStats
{
	/**Absorbed Enemy Type*/
	var() class<BF_Enemy_base> EType;
	/**Current Upgrade Level*/
	var() byte L;
	/**Enemy Mesh*/
	var() SkeletalMesh M;
		structdefaultproperties
		{
			EType=class'BF_Enemy_Base'
			Level=0
		    M=SkeletalMesh'BloodFalcon.SkeletalMesh.Player'
		}
};

struct CollectedSouls
{
	var() SoulStats Current;
	var() SoulStats B1;
	var() SoulStats B2;
	var() SoulStats B3;
};

DefaultProperties
{
}
