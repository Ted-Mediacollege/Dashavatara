package myth.gui.game 
{
	import myth.gamemode.GameModeEndless;
	import myth.gamemode.GameModeTutorial;
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.graphics.AssetList;
	
	public class GuiGameSelect extends GuiScreen
	{		
		public function GuiGameSelect() 
		{
			
		}	
		
		override public function init():void 
		{ 
			addChild(background);
			
			addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 110, 450, 100, "Story mode", 45, 0xf1d195, "GameFont"));
			addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2, 450, 100, "Endless mode", 45, 0xf1d195, "GameFont"));
			addButton(new GuiButton(2, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 110, 450, 100, "Tutorial", 45, 0xf1d195, "GameFont"));
			addButton(new GuiButton(3, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight - 80, 450, 100, "Main Menu", 45, 0xf1d195, "GameFont"));
		}
		
		override public function tick():void 
		{ 
			super.tick();
			background.tick();
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
				main.switchGui(new GuiGame(new GameModeTutorial(5 + 4)));
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