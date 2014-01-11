/***************************************
// Author(s): Tyler Keller, Dewayne Cameron
// Date: 12/6/2013
// Status: Beta
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
//var Texture2D PlayerShipIcon;
var MultiFont BF_Font;
//var bool PlayerDead;
//var int RankHolder; //Weapon and Life variables
	//var int Rank;
	//var int DroneRank;
	//var bool DroneEquip;
	//var int GunShipRank;
	//var bool GunShipEquip;
	//var int SuicideFighterRank;
	//var bool SuicideFighterEquip;	
	//var byte Lives;
		var float OldHUDX; //HUD Scaling variables
		var float OldHUDY;
		var float CurHUDX;
		var float CurHUDY;
		var float RatX;
		var float RatY;
		var float MeterFull;
		var float MeterIncrement;
		//var float BeamLength;
		//var int BeamOverlayLength;


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
	Canvas.SetPos(0,0);
	Canvas.DrawTile(BloodMeterBlack, 1024*RatX, 1024*RatY*MeterIncrement, 0, 0, 1024, 1024*MeterIncrement,,true);
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
	Canvas.SetPos(((Canvas.ClipX / 2) - 540), 0);
	Canvas.SetDrawColor(0,0,0);
	Canvas.DrawRect(1980,1080);
	Canvas.SetPos(((Canvas.ClipX / 2) - 90), Canvas.ClipY / 2);
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.Font = BF_Font;
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
	//BF_Font = MultiFont'UI_Fonts_Final.menus.Fonts_AmbexHeavy'
	//BloodMeterRed = Texture2D'BF_HUD_Assets.Textures.BloodMeterRed'
	BloodMeterBlack = Texture2D'BF_HUD_Assets.Textures.BloodMeterBlack'
	OldHUDX=1920
	OldHUDY=1080
	RatX = 1
	RatY = 1
}

