class BFInventoryManager extends InventoryManager;

/** Holds the current "Fire" status for both firing modes */
//var BFWeapon1 LocBFWeapon1;



simulated event PostBeginPlay()
{
	super.PostBeginPlay();
}

defaultproperties
{
        PendingFire(0)=0
        PendingFire(1)=0
	    PendingFire(2)=0
	    PendingFire(3)=0
	    PendingFire(4)=0

}
