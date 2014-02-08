package myth.gui 
{
	import myth.input.TouchType;
	import myth.gui.components.GuiButton;
	import myth.Main;
	import starling.display.Sprite;
	
	public class GuiScreen extends Sprite
	{
		public static var screenWidth:int = 1280;
		public static var screenHeight:int = 720;
		
		public var main:Main;
		public var buttonList:Vector.<GuiButton>;
		
		//called when gui contructed
		public function init():void { }
		
		//called every enter frame
		public function tick():void { }
		
		//called by touch input
		public function input(type:TouchType, data:Vector.<Number>):void { }
		
		//called by key input
		
		//button click
		public function action(id:GuiButton):void { }
		
		//called when gui gets destroyed
		public function destroy():void { }
		
		//called by the main
		public function preInit(m:Main):void
		{
			main = m;
			buttonList = new Vector.<GuiButton>();
		}
	}
}