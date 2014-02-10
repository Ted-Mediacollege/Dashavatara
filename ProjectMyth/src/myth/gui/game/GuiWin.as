package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.gui.background.GuiBackground;

	public class GuiWin extends GuiScreen
	{
		
		public function GuiWin() 
		{
			
		}
		
		override public function init():void 
		{ 
			var bg:GuiBackground = new GuiBackground();
			addChild(bg);
			
			var t:GuiText = new GuiText(20, 20, 400, 60, "left", "top", "GuiWin", 25, 0x000000);
			addChild(t);
		}
		
		override public function tick():void 
		{ 
			
		}
		
		override public function input(type:int, data:Vector.<Number>):void 
		{ 
			
		}
		
		override public function action(b:GuiButton):void 
		{ 
			
		}
		
		override public function destroy():void 
		{ 
			
		}
	}
}