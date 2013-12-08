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
var int RankHolder; //Used in Rank Position
	var int Rank;
	var int DroneRank;
	var bool DroneEquip;
	var int GunShipRank;
	var bool GunShipEquip;
	var int SuicideFighterRank;
	var bool SuicideFighterEquip;	

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
	Canvas.Font = BF_Font;
	LoadUI();
	if(PlayerDead){
		GameOver();
	}
	super.drawHUD();
}

function RankPosition()
{
	if(RankHolder==1){
		Canvas.SetPos(9, 944);
	}else if(RankHolder==2){
		Canvas.SetPos(85, 944);	
	}else if(RankHolder==3){
		Canvas.SetPos(161, 944);	
	}else if(RankHolder==4){
		Canvas.SetPos(237, 944);	
	}else if(RankHolder==5){
		Canvas.SetPos(313, 944);	
	}else{
	
	}
}

function CleanHUD()
{
	if((Rank+5)<=5){
		RankHolder = Rank + 5;
		RankPosition();
		Canvas.DrawTile(BFTemplate, 64, 64, 0, 0, 64, 64);
	}
	if((Rank+4)<=5){
		RankHolder = Rank + 4;
		RankPosition();
		Canvas.DrawTile(BFTemplate, 64, 64, 0, 0, 64, 64);
	}
	if((Rank+3)<=5){
		RankHolder = Rank + 3;
		RankPosition();
		Canvas.DrawTile(BFTemplate, 64, 64, 0, 0, 64, 64);
	}
	if((Rank+2)<=5){
		RankHolder = Rank + 2;
		RankPosition();
		Canvas.DrawTile(BFTemplate, 64, 64, 0, 0, 64, 64);
	}
	if((Rank+1)<=5){
		RankHolder = Rank + 1;
		RankPosition();
		Canvas.DrawTile(BFTemplate, 64, 64, 0, 0, 64, 64);
	}
}

function LoadUI()
{
	Canvas.SetPos(-6, 936);
	Canvas.DrawTile(BFUI, 1024, 1024, 0, 0, 1024, 1024);
	if(GunShipEquip){ //GUNSHIP MISSILES
		RankHolder = GunShipRank;
		RankPosition();
		Canvas.DrawTile(BFMissile, 64, 64, 0, 0, 64, 64);
	}
	if(DroneEquip){
		RankHolder = DroneRank;
		RankPosition();
		Canvas.DrawTile(BFFlamethrower, 64, 64, 0, 0, 64, 64);
	}
	if(SuicideFighterEquip){ //SUICIDEFIGHTER MACHINEGUN?
		RankHolder = SuicideFighterRank;
		RankPosition();
		Canvas.DrawTile(BFFlameThrower, 64, 64, 0, 0, 64, 64);
	}

	CleanHUD();
	Canvas.SetPos(706,936);
	Canvas.SetDrawColor(0,0,0);
	Canvas.DrawText("1",,2.5,3);
}

/*function activeWeapons()
{
	if(W1){     //weapon bay 1
	Canvas.SetDrawColor(0,255,0);
	Canvas.SetPos(75, 950);
	Canvas.DrawBox(7,11);
	}
	//Canvas.SetDrawColor(255,0,0); if damaged turn this color 
}

function drawLvlComplete()
{
	Canvas.SetPos(((Canvas.ClipX / 2) - 225), Canvas.ClipY / 2);
	Canvas.SetDrawColor(0, 204, 0);
	Canvas.Font = StatusFont;
	Canvas.DrawText("LEVEL COMPLETE");
}*/

function GameOver()
{
	Canvas.SetPos(0,0);
	Canvas.SetDrawColor(0,0,0);
	Canvas.DrawRect(768,1024);//DoesntWork
	Canvas.SetPos(((Canvas.ClipX / 2) - 145), Canvas.ClipY / 2);
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.Font = BF_Font;
	Canvas.DrawText("GAME OVER");
}


DefaultProperties
{
	BFUI = Texture2D'BloodFalcon.Texture.BF_HUDUI'
	BFMissile = Texture2D'BloodFalcon.Texture.BF_HUD_Missile'
	BFMissileEmpty = Texture2D'BloodFalcon.Texture.BF_HUD_MissileEmpty'
	BFFlamethrower = Texture2D'BloodFalcon.Texture.BF_HUD_FlameThrower'
	BFFlamethrowerEmpty = Texture2D'BloodFalcon.Texture.BF_HUD_FlameThrowerEmpty'
	BFTemplate = Texture2D'BloodFalcon.Texture.BF_HUD_IconTemplate'
	BF_Font = MultiFont'UI_Fonts_Final.menus.Fonts_AmbexHeavy'
	playerdead=false
}

