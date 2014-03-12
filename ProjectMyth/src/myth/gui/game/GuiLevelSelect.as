package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;

	public class GuiLevelSelect extends GuiScreen
	{
		
		public function GuiLevelSelect() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var t:GuiText = new GuiText(50, 50, 400, 60, "left", "top", "GuiLevelSelect", 25, 0x000000);
			addChild(t);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 60, 450, 100, "Test Level 1", 25, 0x000000));
			var b2:GuiButton = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 170, 450, 100, "Test Level 2", 25, 0x000000));
			var b3:GuiButton = addButton(new GuiButton(2, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 280, 450, 100, "Test Level 3", 25, 0x000000));
			var b5:GuiButton = addButton(new GuiButton(4, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 390, 450, 100, "testlevel", 25, 0x000000));
			var b4:GuiButton = addButton(new GuiButton(3, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Main Menu", 25, 0x000000));
		}
		
		override public function tick():void 
		{ 
			background.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.switchGui(new GuiLevelInfo("level_1"));
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiLevelInfo("level_2"));
			}
			else if (b.buttonID == 2)
			{
				main.switchGui(new GuiLevelInfo("level_3"));
			}
			else if (b.buttonID == 3)
			{
				main.switchGui(new GuiMainMenu());
			}
			else if (b.buttonID == 4)
			{
				main.switchGui(new GuiLevelInfo("testlevel"));
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}