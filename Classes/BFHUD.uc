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
var bool playerdead;

function drawHUD()
{
	LoadUI();
	playerdead = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).playerdead;
	if(playerdead){
	//GameOver();
	}
	super.drawHUD();
}

function LoadUI()
{
	Canvas.SetPos(0, 0);
	Canvas.DrawTile(BFUI, 1024, 1024, 0, 0, 1024, 1024);
	Canvas.SetPos(13, 13);
	Canvas.DrawTile(BFMissile, 43, 40, 0, 0, 128, 128);
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

/*function drawLvlComplete()
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
	Canvas.Font = StatusFont;
	Canvas.DrawText("GAME OVER");
}

*/
DefaultProperties
{
	BFUI = Texture2D'BloodFalcon.Texture.BF_HUDUI'
	BFMissile = Texture2D'BloodFalcon.Texture.BF_HUD_Missile'
	playerdead=false
}

