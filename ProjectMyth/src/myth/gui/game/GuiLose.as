package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.gui.background.GuiBackground;
	import myth.graphics.AssetList;
	import starling.display.Image;
	import myth.lang.Lang;

	public class GuiLose extends GuiScreen
	{
		
		private var levelName:String;
		private var levelID:int;
		
		public function GuiLose(_levelName:String,id:int)
		{
			levelName = _levelName;
			levelID = id;
		}
		
		override public function init():void 
		{ 
			var bg:Image = new Image(AssetList.assets.getTexture("gui_lose"));
			addChild(bg);
			
			var b1:GuiButton = addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 60, 450, 100, Lang.trans(Lang.INGAME, "menu.restart"), 45, 0xf1d195, "GameFont"));
			var b2:GuiButton = addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0xf1d195, "GameFont"));
		}
		
		override public function tick():void 
		{ 
			super.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiGame(levelName, levelID));
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