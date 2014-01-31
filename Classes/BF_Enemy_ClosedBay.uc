class BF_Enemy_ClosedBay extends BF_Enemy_Base;



event PostBeginPlay()
{
	NPCInfo.FireRate=0;
	NPCInfo.ProjClass=none;
	NPCInfo.SoulClass=class'BF_Enemy_ClosedBay';
	NPCInfo.SoulMesh=none;
	NPCInfo.Level=0;
	NPCInfo.Size=1;
	NPCInfo.Speed=0;
	NPCInfo.bFXEnabled=false;
	NPCInfo.Closed=true;
}

DefaultProperties
{

}
