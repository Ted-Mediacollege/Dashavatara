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
	import myth.gui.components.GuiButtonLevel;
	import starling.display.BlendMode;
	import myth.data.GameData;

	public class GuiLevelSelect extends GuiScreen
	{
		public var chapter:int = 0;
		public var map1:Image;
		public var map2:Image;
		
		public var levelList:XML;
		public var levelListLength:int;
		
		public function GuiLevelSelect() 
		{
			
		}
		
		override public function init():void 
		{ 
			background = null;
			
			levelList = TextureList.assets.getXml("level_list");
			levelListLength = levelList.children().length();
			
			switchChapter(0);
		}
		
		public function switchChapter(id:int):void
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
				case 0: map1 = new Image(TextureList.assets.getTexture("map_1")); break;
				case 1: map1 = new Image(TextureList.assets.getTexture("map_2")); break;
				case 2: map1 = new Image(TextureList.assets.getTexture("map_31")); map2 = new Image(TextureList.assets.getTexture("map_32")); map2.blendMode = BlendMode.NONE; addChild(map2); break;
			}
			
			map1.blendMode = BlendMode.NONE;
			addChild(map1);
			
			setButtons();
		}
		
		public function setButtons():void
		{
			removeAllButtons();
			
			addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth - 245, screenHeight - 30, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0x000000, "GameFont"));
			
			if(chapter > 0) { addButton(new GuiButton(1, TextureList.assets.getTexture("map_button_left"), 50, screenHeight - 50, 85, 159, "")); }
			if(chapter < 2) { addButton(new GuiButton(2, TextureList.assets.getTexture("map_button_right"), 170, screenHeight - 50, 85, 159, "")); }
			
			for (var i:int = 0; i < levelListLength; i++ )
			{
				if (levelList.level[i].@chapter == chapter)
				{
					if (levelList.level[i].@id <= GameData.levelsUnlocked)
					{
						addButton(new GuiButtonLevel(levelList.level[i].@id, levelList.level[i].@x, levelList.level[i].@y));
					}
				}
			}
		}
		
		override public function tick():void 
		{ 
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID > 99)
			{
				main.switchGui(new GuiLevelInfo("level_1"));
			}
			else if (b.buttonID == 0)
			{
				main.switchGui(new GuiMainMenu());
			}
			else if (b.buttonID == 1)
			{
				switchChapter(chapter - 1);
			}
			else if (b.buttonID == 2)
			{
				switchChapter(chapter + 1);
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}