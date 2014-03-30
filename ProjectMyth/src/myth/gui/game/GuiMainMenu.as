package myth.gui.game 
{
	import myth.gui.background.GuiBackground;
	import myth.gui.components.GuiText;
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.graphics.TextureList;
	import starling.display.Image;
	import myth.data.GameData;
	import myth.lang.Lang;
	
	public class GuiMainMenu extends GuiScreen
	{
		public function GuiMainMenu() 
		{
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var version:GuiText = new GuiText(screenWidth - 220, screenHeight - 15, 200, 60, "right", "center", Lang.trans(Lang.MENU, "main.version") + " " + GameData.GAME_VERSION, 24, 0x000000, "Arial");
			addChild(version);
			
			if (GameData.DEVELOPMENT)
			{
				var dev:GuiText = new GuiText(20, 20, 550, 140, "left", "top", "!! DEVELOPMENT VERSION !!", 30, 0xFF0000, "Arial");
				addChild(dev);
			}
			
			var logo:Image = new Image(TextureList.assets.getTexture("gui_logo"));
			logo.pivotX = logo.width / 2;
			logo.x = 630;
			logo.y = 5;
			addChild(logo);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2, 450, 100, Lang.trans(Lang.MENU, "main.play"), 45, 0x000000, "GameFont"));
			var b3:GuiButton = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 110, 450, 100, Lang.trans(Lang.MENU, "main.editor"), 45, 0x000000, "GameFont"));
			var b4:GuiButton = addButton(new GuiButton(2, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 220, 450, 100, Lang.trans(Lang.MENU, "main.options"), 45, 0x000000, "GameFont"));
			var b5:GuiButton = addButton(new GuiButton(3, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, Lang.trans(Lang.MENU, "main.credits"), 45, 0x000000, "GameFont"));
		}
		
		override public function tick():void 
		{ 
			background.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiLevelSelect());
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiEditor());
			}
			else if (b.buttonID == 2)
			{
				main.switchGui(new GuiOptions(), true);
			}
			else if (b.buttonID == 3)
			{
				main.switchGui(new GuiCredits(), true);
			}
		}
		
		override public function destroy():void 
		{ 
		}
	}
}