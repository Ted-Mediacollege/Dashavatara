package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;
	import myth.util.Debug;

	public class GuiOptions extends GuiScreen
	{	
		public function GuiOptions() 
		{
			
		}
		
		override public function init():void 
		{ 
			addChild(background);
			
			var t:GuiText = new GuiText(50, 50, 400, 60, "left", "top", "GuiOptions", 25, 0x000000);
			addChild(t);			

			var b:GuiButton = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Main Menu", 25, 0x000000));
			
			var b1:GuiButton = addButton(new GuiButton(10, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 110, 450, 100, "DEBUG1: " + Debug.USER[0], 25, 0x000000));
			var b2:GuiButton = addButton(new GuiButton(11, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 220, 450, 100, "DEBUG2: " + Debug.USER[1], 25, 0x000000));
			
			var b3:GuiButton = addButton(new GuiButton(12, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 330, 450, 100, "DRAW ATTACK: " + Debug.DrawArracks, 25, 0x000000));
			var b4:GuiButton = addButton(new GuiButton(13, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, 440, 450, 100, "DRAW COLLIDERS: " + Debug.DrawRectsColliders, 25, 0x000000));
		}
		
		override public function tick():void 
		{ 
			background.tick();
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				trace(Debug.USER[0], Debug.USER[1], Debug.DrawRectsColliders, Debug.DrawRectsColliders);
				main.switchGui(new GuiMainMenu());
			}
			else if (b.buttonID == 10)
			{
				if (Debug.USER[0] == 1)
				{
					Debug.USER[0] = 0;
				}
				else
				{
					Debug.USER[0] = 1;
				}
				b.buttonText.text = "DEBUG1: " + Debug.USER[0];
			}
			else if (b.buttonID == 11)
			{
				if (Debug.USER[1] == 1)
				{
					Debug.USER[1] = 0;
				}
				else
				{
					Debug.USER[1] = 1;
				}
				b.buttonText.text = "DEBUG2: " + Debug.USER[1];
			}
			else if (b.buttonID == 12)
			{
				if (Debug.DrawArracks == 1)
				{
					Debug.DrawArracks = 0;
				}
				else
				{
					Debug.DrawArracks = 1;
				}
				b.buttonText.text = "DRAW ATTACK: " + Debug.DrawArracks;
			}
			else if (b.buttonID == 13)
			{
				if (Debug.DrawRectsColliders == 1)
				{
					Debug.DrawRectsColliders = 0;
				}
				else
				{
					Debug.DrawRectsColliders = 1;
				}
				b.buttonText.text = "DRAW COLLIDERS: " + Debug.DrawRectsColliders;
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}