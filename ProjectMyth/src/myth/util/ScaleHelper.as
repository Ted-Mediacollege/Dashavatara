package myth.util 
{
	import myth.gui.GuiScreen;
	
	public class ScaleHelper 
	{
		public static var scaleX:Number;
		public static var scaleY:Number;
		
		public static var screenX:int = 1280
		public static var screenY:int = 720;
		
		public static var phoneX:int;
		public static var phoneY:int;
		
		public static function init(width:int, height:int):void
		{
			phoneX = width;
			phoneY = height;
			
			scaleX = width / screenX;
			scaleY = height / screenY;
		}
		
		public static function tX(px:Number):Number
		{
			return px * scaleX;
		}
		
		public static function tY(py:Number):Number
		{
			return py * scaleY;
		}
	}
}