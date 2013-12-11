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
var MultiFont BF_Font;
var bool PlayerDead;
var int RankHolder; //Weapon and Life variables
	var int Rank;
	var int DroneRank;
	var bool DroneEquip;
	var int GunShipRank;
	var bool GunShipEquip;
	var int SuicideFighterRank;
	var bool SuicideFighterEquip;	
	var byte Lives;
		var float OldHUDX; //HUD Scaling variables
		var float OldHUDY;
		var float CurHUDX;
		var float CurHUDY;
		var float RatX;
		var float RatY;



function drawHUD()
{
	DroneEquip = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).DroneEquip;
	GunShipEquip = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GunShipEquip;
	SuicideFighterEquip = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).SuicideFighterEquip;
	DroneRank = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).DroneRank;
	GunShipRank = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).GunShipRank;
	SuicideFighterRank = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).SuicideFighterRank;
	Rank = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Rank;
	PlayerDead = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PlayerDead;
	Lives = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Lives;
	Canvas.Font = BF_Font;
	CurHUDX = Canvas.SizeX;
	CurHUDY = Canvas.SizeY;
	CalcScale(CurHUDX,CurHUDY);

	if(Lives==0){
		GameOver();
	}else{
		LoadUI();
	}
	super.drawHUD();
}

function CalcScale(float ScreenX,float ScreenY)
{
`log(ScreenX);
`log(ScreenY);
	if(ScreenX>OldHUDX){
		RatX = ScreenX/OldHUDX;
	}else if(ScreenX<OldHUDX){
		RatX = ScreenX/OldHUDX;
	}else{

	}

	if(ScreenY>OldHUDY){
		RatY = ScreenY/OldHUDY;
	}else if(ScreenY<OldHUDY){
		RatY = ScreenY/OldHUDY;
	}else{

	}

}

function RankPosition()
{
	//if(RankHolder==1){
	//	Canvas.SetPos(9*RatX, 944*RatY);
	//}else if(RankHolder==2){
	//	Canvas.SetPos(85*RatX, 944*RatY);	
	//}else if(RankHolder==3){
	//	Canvas.SetPos(161*RatX, 944*RatY);	
	//}else if(RankHolder==4){
	//	Canvas.SetPos(237*RatX, 944*RatY);	
	//}else if(RankHolder==5){
	//	Canvas.SetPos(313*RatX, 944*RatY);	
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
	local float X,Y;

	Canvas.SetPos(0, 0);
	Canvas.DrawTile(BFUI, 1920*RatX, 1080*RatY, 0, 0, 1920, 1080);
	if(GunShipEquip){ //GUNSHIP MISSILES
		RankHolder = GunShipRank;
		RankPosition();
		Canvas.DrawTile(BFMissile, 64*RatX, 64*RatY, 0, 0, 64, 64);
	}
	if(DroneEquip){
		RankHolder = DroneRank;
		RankPosition();
		Canvas.DrawTile(BFFlamethrower, 64*RatX, 64*RatY, 0, 0, 64, 64);
	}
	if(SuicideFighterEquip){ //SUICIDEFIGHTER MACHINEGUN?
		RankHolder = SuicideFighterRank;
		RankPosition();
		Canvas.DrawTile(BFFlameThrower, 64*RatX, 64*RatY, 0, 0, 64, 64);
	}

	CleanHUD();
	Canvas.StrLen(Lives,X,Y);
	Canvas.SetPos((706-(X/2)),936*RatY);
	Canvas.SetDrawColor(0,0,0);
	Canvas.DrawText(Lives,,2.5,3);
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
	BFUI = Texture2D'BloodFalcon.Texture.frame'
	BFMissile = Texture2D'BloodFalcon.Texture.BF_HUD_Missile'
	BFMissileEmpty = Texture2D'BloodFalcon.Texture.BF_HUD_MissileEmpty'
	BFFlamethrower = Texture2D'BloodFalcon.Texture.BF_HUD_FlameThrower'
	BFFlamethrowerEmpty = Texture2D'BloodFalcon.Texture.BF_HUD_FlameThrowerEmpty'
	BFTemplate = Texture2D'BloodFalcon.Texture.BF_HUD_IconTemplate'
	BF_Font = MultiFont'UI_Fonts_Final.menus.Fonts_AmbexHeavy'
	playerdead=false
	Lives = 3
	OldHUDX=1920
	OldHUDY=1080
	RatX = 1
	RatY = 1
}

