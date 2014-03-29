package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;
	import starling.display.Image;
	import starling.display.BlendMode;

	public class GuiLevelInfo extends GuiScreen
	{
		private var file_name:String;
		private var level_name:String;
		private var level_desc:String;
		private var level_diff:String;
		
		private var backgroundmap:int;
		
		public function GuiLevelInfo(bgID:int, file:String, levelname:String, description:String, difficulty:String) 
		{
			backgroundmap = bgID;
			
			file_name = file;
			level_name = levelname;
			level_desc = description;
			level_diff = difficulty;
		}
		
		override public function init():void 
		{ 
			switch(backgroundmap)
			{
				case 0: var m1:Image = new Image(TextureList.assets.getTexture("map_1")); addChild(m1); break;
				case 1: var m2:Image = new Image(TextureList.assets.getTexture("map_2")); addChild(m2); break;
				case 2: var m3:Image = new Image(TextureList.assets.getTexture("map_31")); addChild(m3); var m4:Image = new Image(TextureList.assets.getTexture("map_32")); m4.x = 640; m4.blendMode = BlendMode.NONE; addChild(m4); break;
			}
			
			var t:GuiText = new GuiText(100, 100, 700, 400, "left", "top", "File: " + file_name + "\nName: " + level_name + "\nDescription: " + level_desc + "\nDifficulty: " + level_diff, 35, 0x000000);
			addChild(t);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 190, 450, 100, "Play", 45, 0x000000, "GameFont"));
			var b2:GuiButton = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Back To Level Select", 45, 0x000000, "GameFont"));
		}
		
		override public function tick():void 
		{ 
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