package myth.gui.game 
{
	import myth.gamemode.GameModeEndless;
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.gui.background.GuiBackground;
	import myth.graphics.AssetList;
	import starling.display.Image;
	import myth.gui.components.GuiText;
	
	public class GuiHighscore extends GuiScreen
	{
		private var score:int
		
		public function GuiHighscore(s:int = 0) 
		{
			score = s;
		}
		
		override public function init():void 
		{ 
			addChild(background);

			var text:GuiText = new GuiText(screenWidth / 2, screenHeight / 2 - 200, 400, 100, "center", "center", "Score: " + score, 65, 0x000000, "Arial");
			addChild(text);
			
			addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 210, 450, 100, "Restart Level", 45, 0xf1d195, "GameFont"));
			addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 320, 450, 100, "Back to menu", 45, 0xf1d195, "GameFont"));
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
				main.switchGui(new GuiGame(new GameModeEndless(0)));
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiMainMenu(), true);
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}