//////////////////////////
// Author(s): Tyler Keller, Sean Mackey
// Date: 11/5/2013
// Credit: 
// http://udn.epicgames.com/
// Status: Alpha
// Being Used: Yes
// Description: HUD for Blood Falcon
//////////////////////////

class BFHUD extends HUD;

var Texture2D Jetbar;
var MultiFont BF_Font;
var Texture2D Bomb;
//var WeapStatus WeapStatus;

function drawHUD()
{
	super.drawHUD();
	drawTitle();
	drawPlayerBar();
	darwPBT();
	darw_PBT();
	drawBombIcon();
	activeWeapons();
}

function drawTitle()
{
	Canvas.SetPos(((Canvas.ClipX / 2) - 125), 10);
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.Font = BF_Font;
	Canvas.DrawText("BLOOD FALCON");
}

//------------------------------------------------------------------------------------------------------------
// Created By Dewayne Cameron 
// This is the HUD concept for Blood Falcon a stuuts bar with Text and Weapons Indicator renders at the lower
// left hand conner of the screen 


// draw text line above the draw_PBT over the Status bar
function darwPBT()
{
	Canvas.SetPos(33, 882);
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.Font = BF_Font;
	Canvas.DrawText("WEAPON",,0.5,0.5);
}


// draw text line under the drawPBT over the Status bar
function darw_PBT()
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
	//if(WeapStatus.Absorb)
	//{
	//weapon bay 1
	//Canvas.SetPos(75, 950);
	//Canvas.DrawBox(7,11);
	//Canvas.SetDrawColor(0,255,0);
	//}else{
	//Canvas.SetPos(75, 950);
	//Canvas.DrawBox(7,11);
	//Canvas.SetDrawColor(255,0,0);
	//}
	
	//Canvas.SetDrawColor(255,0,0); if damaged turn this color 

	/*//weapon bay 2
	Canvas.SetPos(86, 940);
	Canvas.DrawBox(7,11);
	Canvas.SetDrawColor(255,0,0);
	
	//weapon bay 3
	Canvas.SetPos(116, 950);
	Canvas.DrawBox(7,11);
	Canvas.SetDrawColor(255,0,0);

	//weapon bay 4
	Canvas.SetPos(107, 940);
	Canvas.DrawBox(7,11);
	Canvas.SetDrawColor(255,0,0);
	
	//weapon bay 5
	Canvas.SetPos(96, 920);
	Canvas.DrawBox(7,11);
	Canvas.SetDrawColor(255,0,0);*/
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

//------------------------------------------------------------------------------------------------------------------
// End Dewayne Cameron Scripts




DefaultProperties
{
	BF_Font = MultiFont'UI_Fonts_Final.menus.Fonts_AmbexHeavy'
	Jetbar = Texture2D'BloodFalcon.Texture.Jetbar'
	Bomb = Texture2D'BloodFalcon.Texture.BombICON'
}

