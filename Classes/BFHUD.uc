/***************************************
// Author(s): Tyler Keller
// Date: 12/6/2013
// Status: Alpha
// Being Used: Yes
// Description: HUD for Blood Falcon
***************************************/

class BFHUD extends HUD
	dependson(BFPawn);

var BF_DeathMenu DeathMenu;
var Texture2D ArmorPiercing,BulletDamage,BulletSpeed,BulletSpread,FireRate,FlightSpeed,MeterGain,Shielding,BFTemplate,LightOn,LightOff,BloodMeterBlack,BayDoor1,BayDoor2,BayDoor3,BFUI;
var MultiFont BF_Font;
		var float OldHUDX; //HUD Scaling variables
		var float OldHUDY;
		var float CurHUDX;
		var float CurHUDY;
		var float RatX;
		var float RatY;
		var float MeterFull;
		var float MeterIncrement, B1I, B2I, B3I;


function drawHUD()
{
	//GunShipEquip = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GunShipEquip;
	CalcScale();
	Canvas.SetPos(0,0);
	Canvas.DrawTile(BFUI, 1920*RatX, 1080*RatY, 0, 0, 1920, 1080);
	
	if(MeterFull<MeterIncrement){
		MeterIncrement-=0.005;
	}else{
		MeterIncrement=MeterFull;
	}
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.B1.Closed){
		if(1>B1I){
			B1I+=0.005;
		}else{
			B1I=1;
		}
	}
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.B2.Closed){
		if(1>B2I){
			B2I+=0.005;
		}else{
			B2I=1;
		}
	}
	if(	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.B3.Closed){
		if(1>B3I){
			B3I+=0.005;
		}else{
			B3I=1;
		}
	}
	
	Canvas.SetPos(0,0);
	Canvas.DrawTile(BloodMeterBlack, 1024*RatX, 1024*RatY*MeterIncrement, 0, 0, 1024, 1024*MeterIncrement,,true);
	Canvas.SetPos(1490*RatX,921*RatY);
	Canvas.DrawTile(BayDoor1, 140*RatX, 140*RatY*B1I, 0, 0, 140, 140*B1I,,true);
	Canvas.SetPos(1630*RatX,921*RatY);
	Canvas.DrawTile(BayDoor2, 140*RatX, 140*RatY*B2I, 0, 0, 140, 140*B2I,,true);
	Canvas.SetPos(1770*RatX,921*RatY);
	Canvas.DrawTile(BayDoor3, 140*RatX, 140*RatY*B3I, 0, 0, 140, 140*B3I,,true);
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PlayerDead==true && B1I==1 && B2I==1 && B3I==1){
		GameOver();
	}

	Canvas.SetPos(1699*RatX,179*RatY);
	Canvas.DrawTile(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HBay1, 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
	Canvas.SetPos(1699*RatX,429*RatY);
	Canvas.DrawTile(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HBay2, 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
	Canvas.SetPos(1699*RatX,679*RatY);
	Canvas.DrawTile(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HBay3, 64*RatX, 64*RatY, 0, 0, 64, 64,,true);

	super.drawHUD();
}


function CalcScale()
{
	RatX = SizeX/OldHUDX;
	RatY = SizeY/OldHUDY;
	MeterFull = (10-BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter)/10;
}


function CleanHUD()
{

}


function GameOver()
{
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PlayerDead=false;
	BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GameOverActive = true;
	DeathMenu = new class'BF_DeathMenu';
	DeathMenu.Start();
}


DefaultProperties
{
	ArmorPiercing=Texture2D'BF_HUD_Assets.Textures.BF_HUD_ArmorPiercing'
	BulletDamage=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletDamage'
	BulletSpeed=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpeed'
	BulletSpread=Texture2D'BF_HUD_Assets.Textures.BF_HUD_BulletSpread'
	FireRate=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FireRate'
	Shielding=Texture2D'BF_HUD_Assets.Textures.BF_HUD_Shielding'
	FlightSpeed=Texture2D'BF_HUD_Assets.Textures.BF_HUD_FlightSpeed'
	MeterGain=Texture2D'BF_HUD_Assets.Textures.BF_HUD_MeterGain'
	BFUI=Texture2D'BF_HUD_Assets.Textures.BF_HUD_Interface'
	BFTemplate=Texture2D'BloodFalcon.Texture.BF_HUD_IconTemplate'
	LightOn=Texture2D'BloodFalcon.Texture.LightOn'
	LightOff=Texture2D'BloodFalcon.Texture.LightOff'
	BayDoor1=Texture2D'BF_HUD_Assets.Textures.BayDoor1'
	BayDoor2=Texture2D'BF_HUD_Assets.Textures.BayDoor2'
	BayDoor3=Texture2D'BF_HUD_Assets.Textures.BayDoor3'
	BF_Font=MultiFont'UI_Fonts_Final.menus.Fonts_AmbexHeavy'
	//BloodMeterRed=Texture2D'BF_HUD_Assets.Textures.BloodMeterRed'
	BloodMeterBlack=Texture2D'BF_HUD_Assets.Textures.BloodMeterBlack'
	OldHUDX=1920
	OldHUDY=1080
	RatX=1
	RatY=1
}

