class BF_Enemy_EmptyBay extends BF_Enemy_Base;

event PostBeginPlay()
{
	NPCInfo.FireRate=0.4;
	NPCInfo.ProjClass=class'BF_Proj_Red_Line';
	NPCInfo.SoulClass=class'BF_Enemy_Drone';
	NPCInfo.SoulMesh=SkeletalMesh'BF_Fighters.SkeletalMesh.Drone_W2';
	NPCInfo.Level=0;
	NPCInfo.Size=1;
	NPCInfo.Speed=0;
	NPCInfo.bFXEnabled=false;
	NPCInfo.Closed=true;
}


DefaultProperties
{

}
