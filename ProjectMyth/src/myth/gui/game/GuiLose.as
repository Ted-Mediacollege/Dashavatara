package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.gui.background.GuiBackground;
	import myth.graphics.TextureList;
	import starling.display.Image;

	public class GuiLose extends GuiScreen
	{
		
		private var levelName:String;
		public function GuiLose(_levelName:String) 
		{
			levelName = _levelName;
		}
		
		override public function init():void 
		{ 
			var bg:Image = new Image(TextureList.assets.getTexture("gui_lose"));
			addChild(bg);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 60, 450, 100, "Restart", 45, 0x000000, "GameFont"));
			var b2:GuiButton = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, "Main Menu", 45, 0x000000, "GameFont"));
		}
		
		override public function tick():void 
		{ 
			super.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiGame(levelName));
			}
			else
			{
				main.switchGui(new GuiMainMenu(), true);
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}