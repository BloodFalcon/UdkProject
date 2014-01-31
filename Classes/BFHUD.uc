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
var Texture2D BloodMeterBlack,BayDoor,BayDoorOpen,BayDoorClosed,BFUI;
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
	local float XL;
	local float YL;

	CalcScale();
	Canvas.SetPos(0,0);
	Canvas.DrawTile(BFUI, 1920*RatX, 1080*RatY, 0, 0, 1920, 1080);
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase != none){
		Canvas.StrLen(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Health), XL, YL);
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase!=none){
		Canvas.SetPos(Canvas.Project(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Location).X-XL,Canvas.Project(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Location).Y-200);
		Canvas.SetDrawColor(0,255,0);
		Canvas.DrawText(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Health,,2,2,);
		}
	}
		Canvas.SetDrawColor(0,0,0);
		Canvas.StrLen(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore), XL, YL);
		Canvas.SetPos((225-(XL))*RatX,0);
		Canvas.DrawText(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore),,2*RatX,2*RatY);
		Canvas.StrLen(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillCount), XL, YL);
		Canvas.SetPos((225-(XL))*RatX,1050*RatY);
		Canvas.DrawText(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillCount),,2*RatX,2*RatY);
		Canvas.StrLen(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.SoulClass.Name), XL, YL);
 		Canvas.SetPos((1694-(XL))*RatX,1048*RatY);
 		Canvas.DrawText(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.SoulClass.Name),,2*RatX,2*RatY);
		
		Canvas.SetDrawColor(255,0,0);
		Canvas.StrLen(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB1, XL, YL);
		Canvas.SetPos((1694-(XL))*RatX,275*RatY);
		Canvas.DrawText(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB1,,2*RatX,2*RatY);
		Canvas.StrLen(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB2, XL, YL);
		Canvas.SetPos((1694-(XL))*RatX,523*RatY);
		Canvas.DrawText(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB2,,2*RatX,2*RatY);
		Canvas.StrLen(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB3, XL, YL);
		Canvas.SetPos((1694-(XL))*RatX,771*RatY);
		Canvas.DrawText(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB3,,2*RatX,2*RatY);
		Canvas.Reset();
	

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
	Canvas.SetPos(1497*RatX,910*RatY);
	Canvas.DrawTile(BayDoorClosed, 132*RatX, 132*RatY*B1I, 0, 0, 132, 132*B1I,,true);
	Canvas.SetPos(1629*RatX,910*RatY);
	Canvas.DrawTile(BayDoorClosed, 132*RatX, 132*RatY*B2I, 0, 0, 132, 132*B2I,,true);
	Canvas.SetPos(1761*RatX,910*RatY);
	Canvas.DrawTile(BayDoorClosed, 132*RatX, 132*RatY*B3I, 0, 0, 132, 132*B3I,,true);
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PlayerDead==true && B1I==1 && B2I==1 && B3I==1){
		GameOver();
	}

	Canvas.SetPos(1629*RatX,128*RatY);
	Canvas.DrawTile(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HBay1, 128*RatX, 128*RatY, 0, 0, 128, 128,,true);
	Canvas.SetPos(1629*RatX,376*RatY);
	Canvas.DrawTile(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HBay2, 128*RatX, 128*RatY, 0, 0, 128, 128,,true);
	Canvas.SetPos(1629*RatX,624*RatY);
	Canvas.DrawTile(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HBay3, 128*RatX, 128*RatY, 0, 0, 128, 128,,true);

	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.BayNumber==1){
		Canvas.SetPos(1529*RatX,862*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
		Canvas.SetPos(1661*RatX,862*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector_Dark', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
		Canvas.SetPos(1793*RatX,862*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector_Dark', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
	}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.BayNumber==2){
		Canvas.SetPos(1529*RatX,862*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector_Dark', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
		Canvas.SetPos(1661*RatX,862*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
		Canvas.SetPos(1793*RatX,862*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector_Dark', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
	}else{
		Canvas.SetPos(1529*RatX,862*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector_Dark', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
		Canvas.SetPos(1661*RatX,862*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector_Dark', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
		Canvas.SetPos(1793*RatX,862*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
	}

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
	BFUI=Texture2D'BF_HUD_Assets.BF_HUD_Interface'
	BFTemplate=Texture2D'BF_HUD_Assets.Textures.BF_HUD_IconTemplate'
	LightOn=Texture2D'BloodFalcon.Texture.LightOn'
	LightOff=Texture2D'BloodFalcon.Texture.LightOff'
	BayDoor=Texture2D'BF_HUD_Assets.Textures.BayDoor'
	BayDoorOpen=Texture2D'BF_HUD_Assets.Textures.BayDoorOpen'
	BayDoorClosed=Texture2D'BF_HUD_Assets.Textures.BayDoorClosed'
	BF_Font=MultiFont'UI_Fonts_Final.menus.Fonts_AmbexHeavy'
	//BloodMeterRed=Texture2D'BF_HUD_Assets.Textures.BloodMeterRed'
	BloodMeterBlack=Texture2D'BF_HUD_Assets.Textures.BloodMeterBlack'
	OldHUDX=1920
	OldHUDY=1080
	RatX=1
	RatY=1
}

