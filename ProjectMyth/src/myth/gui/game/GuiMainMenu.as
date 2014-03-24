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
			
			var version:GuiText = new GuiText(screenWidth - 220, screenHeight - 15, 200, 60, "right", "center", Lang.trans(Lang.MENU, "main.version") + " " + GameData.GAME_VERSION + " " + GameData.testOS, 24, 0x000000, "Arial");
			addChild(version);
			
			var logo:Image = new Image(TextureList.assets.getTexture("gui_logo"));
			logo.pivotX = 250;
			logo.x = 630;
			logo.y = 40;
			addChild(logo);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 50, 450, 100, Lang.trans(Lang.MENU, "main.play"), 25, 0x31407F));
			var b3:GuiButton = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, Lang.trans(Lang.MENU, "main.editor"), 25, 0x000000));
			var b4:GuiButton = addButton(new GuiButton(2, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 170, 450, 100, Lang.trans(Lang.MENU, "main.options"), 25, 0x000000));
			var b5:GuiButton = addButton(new GuiButton(3, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 280, 450, 100, Lang.trans(Lang.MENU, "main.credits"), 25, 0x000000));
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
				main.switchGui(new GuiOptions());
			}
			else if (b.buttonID == 3)
			{
				main.switchGui(new GuiCredits());
			}
		}
		
		override public function destroy():void 
		{ 
		}
	}
}