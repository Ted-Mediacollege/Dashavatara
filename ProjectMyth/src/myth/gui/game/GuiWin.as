package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.gui.background.GuiBackground;
	import myth.graphics.AssetList;
	import myth.lang.Lang;
	import myth.data.GameData;
	import myth.gamemode.GameModeStory;

	public class GuiWin extends GuiScreen
	{
		private var currentLevel:String;
		private var nextLevel:String;
		private var levelID:int;
		
		public function GuiWin(_currentLevel:String,_nextLevel:String,id:int) 
		{
			currentLevel = _currentLevel;
			nextLevel = _nextLevel;
			levelID = id;
			
			if (GameData.levelsUnlocked < levelID + 1)
			{
				GameData.levelsUnlocked = levelID + 1;
			}
		}
		
		override public function init():void 
		{ 
			addChild(background);

			var b1:GuiButton = addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 60, 450, 100, Lang.trans(Lang.INGAME, "menu.restart"), 45, 0xf1d195, "GameFont"));
			if (nextLevel != "end")
			{
				var b2:GuiButton = addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, Lang.trans(Lang.INGAME, "menu.next"), 45, 0xf1d195, "GameFont"));
			}
			var b3:GuiButton = addButton(new GuiButton(2, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 180, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0xf1d195, "GameFont"));
		
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
				main.switchGui(new GuiGame(new GameModeStory(currentLevel, levelID)));
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiGame(new GameModeStory(nextLevel, levelID + 1)));
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