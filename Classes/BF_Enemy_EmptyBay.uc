class BF_Enemy_EmptyBay extends BF_Enemy_Base;

event PostBeginPlay()
{
	NPCInfo.FireRate=0;
	NPCInfo.ProjClass=none;
	NPCInfo.SoulClass=class'BF_Enemy_EmptyBay';
	NPCInfo.SoulMesh=none;
	NPCInfo.Level=0;
	NPCInfo.Size=1;
	NPCInfo.Speed=0;
	NPCInfo.bFXEnabled=false;
	NPCInfo.Closed=true;
	NPCInfo.HUDuP.HBay1=Texture2D'BF_HUD_Assets.Textures.BF_HUD_IconTemplate';
	NPCInfo.HUDuP.HBay2=Texture2D'BF_HUD_Assets.Textures.BF_HUD_IconTemplate';
	NPCInfo.HUDuP.HBay3=Texture2D'BF_HUD_Assets.Textures.BF_HUD_IconTemplate';
}


DefaultProperties
{
}
