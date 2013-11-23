//////////////////////////
// Author(s): Dewayne Cameron
// Date: 11/5/2013
// Status: Alpha
// Being Used: Yes
// Description: HUD for Blood Falcon
//////////////////////////

class BFHUD extends HUD;

var Texture2D Jetbar;
var MultiFont BF_Font;
var Texture2D Bomb;
var MultiFont StatusFont;


function drawHUD()
{
	super.drawHUD();
	drawTitle();
	drawPlayerBar();
	drawPBT();
	draw_PBT();
	drawBombIcon();
	activeWeapons();
	//drawLvlComplete();
	//drawGameOver();
}

function drawTitle()
{
	Canvas.SetPos(((Canvas.ClipX / 2) - 125), 10);
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.Font = BF_Font;
	Canvas.DrawText("BLOOD FALCON");
}

// draw text line above the draw_PBT over the Status bar
function drawPBT()
{
	Canvas.SetPos(33, 882);
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.Font = BF_Font;
	Canvas.DrawText("WEAPON",,0.5,0.5);
}

// draw text line under the drawPBT over the Status bar
function draw_PBT()
{

	Canvas.SetPos(36, 892);
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.Font = BF_Font;
	Canvas.DrawText("STATUS",,0.5,0.5);

}

// Draw the Player status bar
function drawPlayerBar()
{
	Canvas.SetPos( 5, 875);
	Canvas.SetDrawColor(255, 255, 255, 195 );
	Canvas.DrawTile(Jetbar, 128, 128, 0,0, Jetbar.SizeX, Jetbar.SizeY);

}

function activeWeapons()
{
	local bool Absorb;
	//local bool Basic;
	local bool W1;
	local bool W2;
	//local bool W3;
	//local bool W4;
	//local bool W5;
	//local bool W6;

	Absorb = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Absorb;
	//Basic = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).Basic;
	W1 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W1;
	W2 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W2;
	//W3 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W3;
	//W4 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W4;
	//W5 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W5;
	//W6 = BFGameInfo(class'WorldInfo'.static.GetWorldInfo().Game).W6;

	if(W1){     //weapon bay 1
	Canvas.SetDrawColor(0,255,0);
	Canvas.SetPos(75, 950);
	Canvas.DrawBox(7,11);
	//Canvas.SetDrawColor(255,0,0); if damaged turn this color 
	}else{
	Canvas.SetDrawColor(255,0,0);
	Canvas.SetPos(75, 950);
	Canvas.DrawBox(7,11);
	}

	if(W2){     //weapon bay 2
	Canvas.SetDrawColor(0,255,0);
	Canvas.SetPos(86, 940);
	Canvas.DrawBox(7,11);
	}else{
	Canvas.SetDrawColor(255,0,0);	
	Canvas.SetPos(86, 940);
	Canvas.DrawBox(7,11);
	}

	if(W1){     //weapon bay 3
	Canvas.SetDrawColor(0,255,0);	
	Canvas.SetPos(116, 950);
	Canvas.DrawBox(7,11);
	}else{
	Canvas.SetDrawColor(255,0,0);		
	Canvas.SetPos(116, 950);
	Canvas.DrawBox(7,11);
	}

	if(W2){     //weapon bay 4
	Canvas.SetDrawColor(0,255,0);	
	Canvas.SetPos(107, 940);
	Canvas.DrawBox(7,11);
	}else{
	Canvas.SetDrawColor(255,0,0);	
	Canvas.SetPos(107, 940);
	Canvas.DrawBox(7,11);
	}
	
	if(Absorb){     //weapon bay 5
	Canvas.SetDrawColor(0,50,155);	
	Canvas.SetPos(96, 920);
	Canvas.DrawBox(7,11);
	}else{
	Canvas.SetDrawColor(0,255,0);	
	Canvas.SetPos(96, 920);
	Canvas.DrawBox(7,11);
	}
}

function drawBombIcon()
{
	Canvas.SetPos( 15, 920);
	//Canvas.SetDrawColor(0, 255, 0, 195 );
	Canvas.SetDrawColor(255, 0, 0, 195 );
	Canvas.DrawTile(Bomb, 40, 40, 73,73, 126,126);
	
// when the bomb class is made and this function will change the color of the icon to indicate its been used and player is out of bombs 
	//Canvas.SetDrawColor(255, 0, 0, 195 );
}

/*function drawLvlComplete()
{
	Canvas.SetPos(((Canvas.ClipX / 2) - 225), Canvas.ClipY / 2);
	Canvas.SetDrawColor(0, 204, 0);
	Canvas.Font = StatusFont;
	Canvas.DrawText("LEVEL COMPLETE");
}*/

function drawGameOver()
{
	Canvas.SetPos(0,0);
	Canvas.SetDrawColor(255,255,255);
	Canvas.DrawRect(768,1024);//DoesntWork
	Canvas.SetPos(((Canvas.ClipX / 2) - 145), Canvas.ClipY / 2);
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.Font = StatusFont;
	Canvas.DrawText("GAME OVER");
}


DefaultProperties
{
	BF_Font = MultiFont'UI_Fonts_Final.menus.Fonts_AmbexHeavy'
	Jetbar = Texture2D'BloodFalcon.Texture.Jetbar'
	Bomb = Texture2D'BloodFalcon.Texture.BombICON'
	StatusFont = MultiFont'UI_Fonts.MultiFonts.MF_LargeFont'
}

