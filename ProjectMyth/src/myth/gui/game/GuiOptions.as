package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;
	import myth.util.Debug;
	import myth.lang.Lang;

	public class GuiOptions extends GuiScreen
	{	
		public function GuiOptions() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var b:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0x000000, "GameFont"));
			
			var b1:GuiButton = addButton(new GuiButton(10, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 110, 450, 100, "DEBUG1: " + Debug.USER[0], 25, 0x000000));
			var b2:GuiButton = addButton(new GuiButton(11, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 220, 450, 100, "DEBUG2: " + Debug.USER[1], 25, 0x000000));
			var b3:GuiButton = addButton(new GuiButton(12, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 330, 450, 100, "DEBUG3: " + Debug.USER[2], 25, 0x000000));

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
				trace(Debug.USER[0], Debug.USER[1], Debug.DrawRectsColliders, Debug.DrawRectsColliders);
				main.switchGui(new GuiMainMenu(), true);
			}
			else if (b.buttonID == 10)
			{
				if (Debug.USER[0] == -1)
				{
					Debug.USER[0] = 0;
				}
				else
				{
					Debug.USER[0] = -1;
				}
				b.buttonText.text = "DEBUG1: " + Debug.USER[0];
			}
			else if (b.buttonID == 11)
			{
				if (Debug.USER[1] == -1)
				{
					Debug.USER[1] = 2;
				}
				else
				{
					Debug.USER[1] = -1;
				}
				b.buttonText.text = "DEBUG2: " + Debug.USER[1];
			}
			else if (b.buttonID == 12)
			{
				if (Debug.USER[2] == -1)
				{
					Debug.USER[2] = 1;
				}
				else
				{
					Debug.USER[2] = -1;
				}
				b.buttonText.text = "DEBUG3: " + Debug.USER[2];
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}