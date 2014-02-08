package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;

	public class GuiLevelSelect extends GuiScreen
	{
		
		public function GuiLevelSelect() 
		{
			
		}
		
		override public function init():void 
		{ 
			var t:GuiText = new GuiText(20, 20, 400, 60, "left", "top", "GuiLevelSelect", 25, 0x000000);
			addChild(t);
			
			var b1:GuiButton = addButton(new GuiButton(0, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 - 120, 450, 100, "Test Level", 25, 0x000000));
			var b2:GuiButton = addButton(new GuiButton(1, TextureList.atlas_gui.getTexture("button_small"), screenWidth / 2, screenHeight / 2 + 240, 450, 100, "Main Menu", 25, 0x000000));
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
				main.switchGui(new GuiLevelInfo());
			}
			else if (b.buttonID == 1)
			{
				main.switchGui(new GuiMainMenu());
			}
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}