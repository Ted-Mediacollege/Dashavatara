package myth.gui 
{
	import myth.input.TouchType;
	import myth.gui.components.GuiButton;
	import myth.Main;
	
	public class GuiScreen 
	{
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