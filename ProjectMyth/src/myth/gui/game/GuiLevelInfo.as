package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;

	public class GuiLevelInfo extends GuiScreen
	{
		
		public function GuiLevelInfo() 
		{
			
		}
		
		override public function init():void 
		{ 
			var bg:GuiBackground = new GuiBackground();
			addChild(bg);
			
			var t:GuiText = new GuiText(20, 20, 400, 60, "left", "top", "GuiLevelInfo", 25, 0x000000);
			addChild(t);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 - 120, 450, 100, "Play Test Level", 25, 0x000000));
			var b2:GuiButton = addButton(new GuiButton(1, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 + 240, 450, 100, "Back To Level Select", 25, 0x000000));
		}
		
		override public function tick():void 
		{ 
			
		}
		
		override public function input(type:int, data:Vector.<Number>):void 
		{ 
			
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0)
			{
				main.createWorld();
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiLevelSelect());
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}