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
/**Used for scaling.*/
var float OldHUDX, OldHUDY, CurHUDX, CurHUDY, RatX, RatY;
/**Used for animating textures*/
var float MeterFull, MeterIncrement, B1I, B2I, B3I;


function drawHUD()
{
	local float XL;
	local float YL;

	CalcScale();
	/*Draws the HUD background.*/
	Canvas.SetPos(0,0);
	Canvas.DrawTile(BFUI, 1920*RatX, 1080*RatY, 0, 0, 1920, 1080);
	BloodMeter();
	BossHealthBar();
	BayDoors();
	UpgradeBays();
	ShipSelectorCursor();
	/*Updates HUD after the player dies.*/
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).PlayerDead==true && B1I==1 && B2I==1 && B3I==1){
		GameOver();
	}

	/*Draws all the HUD text.*/
		Canvas.SetDrawColor(0,0,0);
		//Total Score
		Canvas.StrLen(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore), XL, YL);
		Canvas.SetPos((225-(XL))*RatX,0);
		Canvas.DrawText(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillScore),,2*RatX,2*RatY);
		//Kill Streak
		Canvas.StrLen(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillCount), XL, YL);
		Canvas.SetPos((225-(XL))*RatX,1050*RatY);
		Canvas.DrawText(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).KillCount),,2*RatX,2*RatY);
		//Ship Name
		Canvas.StrLen(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDName, XL, YL);
 		Canvas.SetPos((1694-(XL))*RatX,1048*RatY);
 		Canvas.DrawText(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDName,,2*RatX,2*RatY);
		//Upgrade Names
		Canvas.SetDrawColor(255,0,0);
		Canvas.StrLen(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB1, XL, YL);
		Canvas.SetPos((1694-(XL))*RatX,771*RatY);
		Canvas.DrawText(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB1,,2*RatX,2*RatY);
		Canvas.StrLen(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB2, XL, YL);
		Canvas.SetPos((1694-(XL))*RatX,523*RatY);
		Canvas.DrawText(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB2,,2*RatX,2*RatY);
		Canvas.StrLen(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB3, XL, YL);
		Canvas.SetPos((1694-(XL))*RatX,275*RatY);
		Canvas.DrawText(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HB3,,2*RatX,2*RatY);
		Canvas.Reset();
	/*End HUD text.*/
	super.drawHUD();
}


/**Animates the blood meter.*/
function BloodMeter()
{
	if(MeterFull<MeterIncrement){
		MeterIncrement-=0.005;
	}else{
		MeterIncrement=MeterFull;
	}	
	Canvas.SetPos(0,0);
	Canvas.DrawTile(BloodMeterBlack, 1024*RatX, 1024*RatY*MeterIncrement, 0, 0, 1024, 1024*MeterIncrement,,true);
}


/**Displays the boss's health bar.*/
function BossHealthBar()
{
	local float XL;
	local float YL;

	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase != none){
		Canvas.StrLen(string(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Health), XL, YL);
		if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase!=none){
		Canvas.SetPos(Canvas.Project(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Location).X-XL,Canvas.Project(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Location).Y-200);
		Canvas.SetDrawColor(0,255,0);
		Canvas.DrawText(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BossBase.Health,,2,2,);
		}
	}
}


/**Draws the bay doors opening and closing when you absorb and die.*/
function BayDoors()
{
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
	Canvas.SetPos(1497*RatX,910*RatY);
	Canvas.DrawTile(BayDoorClosed, 132*RatX, 132*RatY*B1I, 0, 0, 132, 132*B1I,,true);
	Canvas.SetPos(1629*RatX,910*RatY);
	Canvas.DrawTile(BayDoorClosed, 132*RatX, 132*RatY*B2I, 0, 0, 132, 132*B2I,,true);
	Canvas.SetPos(1761*RatX,910*RatY);
	Canvas.DrawTile(BayDoorClosed, 132*RatX, 132*RatY*B3I, 0, 0, 132, 132*B3I,,true);
}


/**Draws the corrosponding upgrade icon, per slot, from the bottom up.*/
function UpgradeBays()
{
	Canvas.SetPos(1629*RatX,624*RatY);
	Canvas.DrawTile(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HBay1, 128*RatX, 128*RatY, 0, 0, 128, 128,,true);
	Canvas.SetPos(1629*RatX,376*RatY);
	Canvas.DrawTile(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HBay2, 128*RatX, 128*RatY, 0, 0, 128, 128,,true);
	Canvas.SetPos(1629*RatX,128*RatY);
	Canvas.DrawTile(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.Current.HUDuP.HBay3, 128*RatX, 128*RatY, 0, 0, 128, 128,,true);
}


/**Draws the cursor showing which ship you are using.*/
function ShipSelectorCursor()
{
	if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.BayNumber==1){
		Canvas.SetPos(1529*RatX,861*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
	}else if(BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).CS.BayNumber==2){
		Canvas.SetPos(1661*RatX,861*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
	}else{
		Canvas.SetPos(1793*RatX,861*RatY);
		Canvas.DrawTile(Texture2D'BF_HUD_Assets.Textures.Selector', 64*RatX, 64*RatY, 0, 0, 64, 64,,true);
	}
}


/**Calculates the ration between the original resolution and the current resolution. Used for all scaling.*/
function CalcScale()
{
	RatX = SizeX/OldHUDX;
	RatY = SizeY/OldHUDY;
	MeterFull = (10-BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).BloodMeter)/10;
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
	BFUI=Texture2D'BF_HUD_Assets.Textures.BF_HUD_Interface'
	BayDoor=Texture2D'BF_HUD_Assets.Textures.BayDoor'
	BayDoorOpen=Texture2D'BF_HUD_Assets.Textures.BayDoorOpen'
	BayDoorClosed=Texture2D'BF_HUD_Assets.Textures.BayDoorClosed'
	BF_Font=MultiFont'UI_Fonts_Final.menus.Fonts_AmbexHeavy'
	BloodMeterBlack=Texture2D'BF_HUD_Assets.Textures.BloodMeterBlack'
	OldHUDX=1920
	OldHUDY=1080
	RatX=1
	RatY=1
}

