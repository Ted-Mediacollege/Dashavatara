package myth.gui.game 
{
	import myth.gamemode.GameModeEndless;
	import myth.gamemode.GameModeTutorial;
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.graphics.AssetList;
	import myth.data.GameData;
	import myth.util.RGB;
	import myth.lang.Lang;
	
	public class GuiGameSelect extends GuiScreen
	{		
		private var button_tutorial:GuiButton;
		private var flashDir:int;
		private var flashPos:int;
		private var flashing:Boolean;
		
		public function GuiGameSelect() 
		{
			
		}	
		
		override public function init():void 
		{ 
			addChild(background);
			
			addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2, 450, 100, Lang.trans(Lang.MENU, "mode.story"), 45, 0xf1d195, "GameFont"));
			addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 110, 450, 100, Lang.trans(Lang.MENU, "mode.endless"), 45, 0xf1d195, "GameFont"));
			button_tutorial = addButton(new GuiButton(2, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 110, 450, 100, Lang.trans(Lang.MENU, "mode.tutorial"), 45, 0xf1d195, "GameFont"));
			addButton(new GuiButton(3, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight - 80, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0xf1d195, "GameFont"));
			
			if (GameData.TUTORIAL)
			{
				flashing = true;
				flashDir = -5;
				flashPos = 200;
			}
		}
		
		override public function tick():void 
		{ 
			super.tick();
			background.tick();
			
			if (flashPos)
			{
				flashPos += flashDir;
				
				if (flashPos < 40)
				{
					flashDir = 5;
					flashPos = 40;
				}
				else if (flashPos > 200)
				{
					flashDir = -5;
					flashPos = 200;
				}
				
				button_tutorial.image.color = RGB.rgbToHex(new RGB(255, flashPos, flashPos));
			}
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiLevelSelect());
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiGame(new GameModeEndless(0)));
			}
			else if (b.buttonID == 2)
			{
				GameData.TUTORIAL = false;
				main.switchGui(new GuiGame(new GameModeTutorial(0)));
			}
			else if (b.buttonID == 3)
			{
				main.switchGui(new GuiMainMenu(), true);
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}