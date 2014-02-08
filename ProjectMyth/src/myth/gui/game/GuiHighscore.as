package myth.gui.game 
{
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;

	public class GuiHighscore extends GuiScreen
	{
		
		public function GuiHighscore() 
		{
			
		}
		
		override public function init():void 
		{ 
			var t:GuiText = new GuiText(20, 20, 400, 60, "left", "top", "GuiHighscore", 25, 0x000000);
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