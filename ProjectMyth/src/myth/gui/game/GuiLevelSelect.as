package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.AssetList;
	import myth.gui.background.GuiBackground;
	import starling.display.Image;
	import myth.lang.Lang;
	import myth.gui.components.GuiButtonLevel;
	import starling.display.BlendMode;
	import myth.data.GameData;

	public class GuiLevelSelect extends GuiScreen
	{
		public var map:Image;
		
		public var levelList:XML;
		public var levelListLength:int;
		
		public function GuiLevelSelect() 
		{
			
		}
		
		override public function init():void 
		{ 
			levelList = AssetList.assets.getXml("level_list");
			levelListLength = levelList.children().length();
			
			map = new Image(AssetList.assets.getTexture("map"));
			map.blendMode = BlendMode.NONE;
			addChild(map);
			
			addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth - 245, screenHeight - 30, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0x000000, "GameFont"));

			for (var i:int = 0; i < levelListLength; i++ )
			{
				if (levelList.level[i].@id <= GameData.levelsUnlocked)
				{
					addButton(new GuiButtonLevel(levelList.level[i].@id, levelList.level[i].@x, levelList.level[i].@y, levelList.level[i].@file));
				}
			}
		}
		
		override public function tick():void 
		{ 
			super.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID > 99)
			{
				var lb:GuiButtonLevel = (b as GuiButtonLevel);
				//main.switchGui(new GuiLevelInfo(chapter, lb.file_name, lb.level_name, lb.level_description, lb.level_difficulty));
				main.switchGui(new GuiGame(lb.file_name));
			}
			else if (b.buttonID == 0)
			{
				main.switchGui(new GuiMainMenu(), true);
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}