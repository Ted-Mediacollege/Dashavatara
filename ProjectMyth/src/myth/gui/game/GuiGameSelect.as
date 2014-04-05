package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.graphics.AssetList;
	
	public class GuiGameSelect extends GuiScreen
	{		
		public function GuiGameSelect() 
		{
			
		}	
		
		override public function init():void 
		{ 
			addChild(background);
			
			var b1:GuiButton = addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 110, 450, 100, "Story mode", 45, 0xf1d195, "GameFont"));
			var b2:GuiButton = addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2, 450, 100, "Endless mode", 45, 0xf1d195, "GameFont"));
			var b3:GuiButton = addButton(new GuiButton(2, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 110, 450, 100, "Tutorial", 45, 0xf1d195, "GameFont"));
			addButton(new GuiButton(3, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight - 80, 450, 100, "Main Menu", 45, 0xf1d195, "GameFont"));
			
			b1.enabled = false;
			b2.enabled = false;
			b3.enabled = false;
			b1.image.color = 0x777777;
			b2.image.color = 0x777777;
			b3.image.color = 0x777777;
		}
		
		override public function tick():void 
		{ 
			super.tick();
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
				
			}
			else if (b.buttonID == 2)
			{
				
			}
			else if (b.buttonID == 3)
			{
				main.switchGui(new GuiMainMenu(), true);
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}