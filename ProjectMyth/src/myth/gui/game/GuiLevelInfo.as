package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;

	public class GuiLevelInfo extends GuiScreen
	{
		private var file_name:String;
		private var level_name:String;
		private var level_desc:String;
		private var level_diff:String;
		
		public function GuiLevelInfo(file:String, levelname:String, description:String, difficulty:String) 
		{
			file_name = file;
			level_name = levelname;
			level_desc = description;
			level_diff = difficulty;
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var t:GuiText = new GuiText(100, 100, 700, 400, "left", "top", "File: " + file_name + "\nName: " + level_name + "\nDescription: " + level_desc + "\nDifficulty: " + level_diff, 35, 0x000000);
			addChild(t);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 190, 450, 100, "Play", 45, 0x000000, "GameFont"));
			var b2:GuiButton = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Back To Level Select", 45, 0x000000, "GameFont"));
		}
		
		override public function tick():void 
		{ 
			background.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiGame(file_name));
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiLevelSelect());
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}