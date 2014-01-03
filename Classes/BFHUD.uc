/***************************************
// Author(s): Tyler Keller, Dewayne Cameron
// Date: 12/6/2013
// Status: Beta
// Being Used: Yes
// Description: HUD for Blood Falcon
***************************************/

class BFHUD extends HUD;

var Texture2D BFUI;
var Texture2D BFMissile;
var Texture2D BFMissileEmpty;
var Texture2D BFFlamethrower;
var Texture2D BFFlamethrowerEmpty;
var Texture2D BFTemplate;
var Texture2D BFBeamOverlay;
var Texture2D LightOn;
var Texture2D LightOff;
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
		//var float BeamLength;
		//var int BeamOverlayLength;


function drawHUD()
{

	//GunShipEquip = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GunShipEquip;
	//SuicideFighterEquip = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).SuicideFighterEquip;
	//DroneRank = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).DroneRank;
	//GunShipRank = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GunShipRank;
	//SuicideFighterRank = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).SuicideFighterRank;
	//Rank = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Rank;
	//PlayerDead = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PlayerDead;
	//Lives = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Lives;
	//BeamLength = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BeamLength;	
	Canvas.Font = BF_Font;
	CurHUDX = SizeX;
	CurHUDY = SizeY;
	CalcScale(CurHUDX,CurHUDY);
	//FOR CURRENT SELECTED WEAPON
	//Canvas.SetPos(271*RatX, 106*RatY);
	//Canvas.DrawTile(BFTemplate, 64*RatX, 64*RatY, 0, 0, 64, 64);
	//



	//if(Lives==0){
	//	GameOver();
	//}else{
		LoadUI();
	//}
	//BeamOverlayLength=(900-(900*BeamLength));
	
	//Canvas.SetPos(221*RatX, ((35+BeamOverlayLength)*RatY));

	//Canvas.DrawTile(BFBeamOverlay, 164*RatX, 2048*RatY, 0, (1007+BeamOverlayLength), 164, 2048);
	super.drawHUD();
}


function CalcScale(float ScreenX,float ScreenY)
{
		RatX = ScreenX/OldHUDX;
		RatY = ScreenY/OldHUDY;
}


function RankPosition()
{
	//if(RankHolder==1){
	//	Canvas.SetPos(271*RatX, 787*RatY);
	//}else if(RankHolder==2){
	//	Canvas.SetPos(271*RatX, 657*RatY);	
	//}else if(RankHolder==3){
	//	Canvas.SetPos(271*RatX, 527*RatY);	
	//}else if(RankHolder==4){
	//	Canvas.SetPos(271*RatX, 397*RatY);	
	//}else if(RankHolder==5){
	//	Canvas.SetPos(271*RatX, 267*RatY);	
	//}else{
	
	//}
}


function CleanHUD()
{
	//if((Rank+5)<=5){
	//	RankHolder = Rank + 5;
	//	RankPosition();
	//	Canvas.DrawTile(BFTemplate, 64*RatX, 64*RatY, 0, 0, 64, 64);
	//}
	//if((Rank+4)<=5){
	//	RankHolder = Rank + 4;
	//	RankPosition();
	//	Canvas.DrawTile(BFTemplate, 64*RatX, 64*RatY, 0, 0, 64, 64);
	//}
	//if((Rank+3)<=5){
	//	RankHolder = Rank + 3;
	//	RankPosition();
	//	Canvas.DrawTile(BFTemplate, 64*RatX, 64*RatY, 0, 0, 64, 64);
	//}
	//if((Rank+2)<=5){
	//	RankHolder = Rank + 2;
	//	RankPosition();
	//	Canvas.DrawTile(BFTemplate, 64*RatX, 64*RatY, 0, 0, 64, 64);
	//}
	//if((Rank+1)<=5){
	//	RankHolder = Rank + 1;
	//	RankPosition();
	//	Canvas.DrawTile(BFTemplate, 64*RatX, 64*RatY, 0, 0, 64, 64);
	//}
}


function LoadUI()
{
	Canvas.SetPos(0, 0);
	Canvas.DrawTile(BFUI, 1920*RatX, 1080*RatY, 0, 0, 1920, 1080);
	//if(GunShipEquip){ //GUNSHIP MISSILES
	//	RankHolder = GunShipRank;
	//	RankPosition();
	//	Canvas.DrawTile(BFMissile, 64*RatX, 64*RatY, 0, 0, 64, 64);
	//}
	//if(DroneEquip){ //Laser or Flamethrower
	//	RankHolder = DroneRank;
	//	RankPosition();
	//	Canvas.DrawTile(BFFlamethrower, 64*RatX, 64*RatY, 0, 0, 64, 64);
	//}
	//if(SuicideFighterEquip){ //SUICIDEFIGHTER MACHINEGUN?
	//	RankHolder = SuicideFighterRank;
	//	RankPosition();
	//	Canvas.DrawTile(BFFlameThrower, 64*RatX, 64*RatY, 0, 0, 64, 64);
	//}
	CleanHUD();
}


function GameOver()
{
	Canvas.SetPos(((Canvas.ClipX / 2) - 540), 0);
	Canvas.SetDrawColor(0,0,0);
	Canvas.DrawRect(1080,1080);
	Canvas.SetPos(((Canvas.ClipX / 2) - 90), Canvas.ClipY / 2);
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.Font = BF_Font;
	Canvas.DrawText("GAME OVER");
}


DefaultProperties
{
	BFUI = Texture2D'BF_HUD_Assets.Textures.BF_HUD_Interface'
	//BFMissile = Texture2D'BloodFalcon.Texture.BF_HUD_Missile'
	//BFFlamethrower = Texture2D'BloodFalcon.Texture.BF_HUD_FlameThrower'
	//BFTemplate = Texture2D'BloodFalcon.Texture.BF_HUD_IconTemplate'
	//BFBeamOverlay = Texture2D'BloodFalcon.Texture.BF_BeamOverlay'
	//LightOn = Texture2D'BloodFalcon.Texture.LightOn'
	//LightOff = Texture2D'BloodFalcon.Texture.LightOff'
	//PlayerIcon = Texture2D'BloodFalcon.Texture.PlayerShipIcon'
	BF_Font = MultiFont'UI_Fonts_Final.menus.Fonts_AmbexHeavy'
	//playerdead=false
	//Lives = 3
	OldHUDX=1920
	OldHUDY=1080
	RatX = 1
	RatY = 1
}

