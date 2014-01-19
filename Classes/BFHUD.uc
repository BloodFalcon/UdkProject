/***************************************
// Author(s): Tyler Keller
// Date: 12/6/2013
// Status: Alpha
// Being Used: Yes
// Description: HUD for Blood Falcon
***************************************/

class BFHUD extends HUD
	dependson(BFPawn);

var Texture2D BFUI;
var Texture2D BFMissile;
var Texture2D BFMissileEmpty;
var Texture2D BFFlamethrower;
var Texture2D BFFlamethrowerEmpty;
var Texture2D BFTemplate;
var Texture2D LightOn;
var Texture2D LightOff;
var Texture2D BloodMeterBlack;
var Texture2D BayDoor1, BayDoor2, BayDoor3;
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
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PlayerDead==true){
		GameOver();
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
	Canvas.SetPos(0, 0);
	Canvas.SetDrawColor(0,0,0);
	Canvas.DrawRect(1980,1080);
	Canvas.SetPos(((Canvas.ClipX / 2) - 90), Canvas.ClipY / 2);
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.DrawText("GAME OVER");
}


DefaultProperties
{
	BFUI = Texture2D'BF_HUD_Assets.Textures.BF_HUD_Interface'
	BFMissile = Texture2D'BloodFalcon.Texture.BF_HUD_Missile'
	BFFlamethrower = Texture2D'BloodFalcon.Texture.BF_HUD_FlameThrower'
	BFTemplate = Texture2D'BloodFalcon.Texture.BF_HUD_IconTemplate'
	LightOn = Texture2D'BloodFalcon.Texture.LightOn'
	LightOff = Texture2D'BloodFalcon.Texture.LightOff'
	BayDoor1 = Texture2D'BF_HUD_Assets.Textures.BayDoor1'
	BayDoor2 = Texture2D'BF_HUD_Assets.Textures.BayDoor2'
	BayDoor3 = Texture2D'BF_HUD_Assets.Textures.BayDoor3'
	//BF_Font = MultiFont'UI_Fonts_Final.menus.Fonts_AmbexHeavy'
	//BloodMeterRed = Texture2D'BF_HUD_Assets.Textures.BloodMeterRed'
	BloodMeterBlack = Texture2D'BF_HUD_Assets.Textures.BloodMeterBlack'
	OldHUDX=1920
	OldHUDY=1080
	RatX = 1
	RatY = 1
}

