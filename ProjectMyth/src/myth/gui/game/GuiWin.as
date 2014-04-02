package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.gui.background.GuiBackground;
	import myth.graphics.AssetList;

	public class GuiWin extends GuiScreen
	{
		private var currentLevel:String;
		private var nextLevel:String;
		public function GuiWin(_currentLevel:String,_nextLevel:String) 
		{
			currentLevel = _currentLevel;
			nextLevel = _nextLevel;
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var b1:GuiButton = addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 60, 450, 100, "Restart", 25, 0x000000));
			var b2:GuiButton = addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, "Next Level", 25, 0x000000));
			var b3:GuiButton = addButton(new GuiButton(2, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 180, 450, 100, "Main Menu", 25, 0x000000));
		
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
				main.switchGui(new GuiGame(currentLevel));
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiGame(nextLevel));
			}
			else if (b.buttonID == 2)
			{
				main.switchGui(new GuiMainMenu(), true);
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}