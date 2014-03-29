package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;
	import starling.display.Image;
	import myth.lang.Lang;

	public class GuiLevelSelect extends GuiScreen
	{
		public var chapter:int = 1;
		public var map1:Image;
		public var map2:Image;
		
		public function GuiLevelSelect() 
		{
			
		}
		
		override public function init():void 
		{ 
			background = null;
			setBackground(1);
			
			addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth - 245, screenHeight - 30, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0x000000, "GameFont"));
			
			addButton(new GuiButton(10, TextureList.assets.getTexture("map_button_1a"), 160, 120, 138, 139, ""));
		}
		
		public function setBackground(id:int):void
		{
			chapter = id;
			if (map1 != null)
			{
				removeChild(map1);
				map1 = null;
				
				if (map2 != null)
				{
					removeChild(map2);
					map2 = null;
				}
			}
			
			switch(id)
			{
				case 1: map1 = new Image(TextureList.assets.getTexture("map_1")); break;
				case 2: map1 = new Image(TextureList.assets.getTexture("map_2")); break;
				case 3: map1 = new Image(TextureList.assets.getTexture("map_31")); map2 = new Image(TextureList.assets.getTexture("map_32")); addChild(map2); break;
			}
			
			addChild(map1);
		}
		
		override public function tick():void 
		{ 
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiMainMenu());
			}
			
			if (b.buttonID == 10)
			{
				main.switchGui(new GuiLevelInfo("level_1"));
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}