package myth.util 
{
	import myth.gui.GuiScreen;
	import flash.geom.Point;
	
	public class ScaleHelper 
	{
		//screen scale X Y
		public static var scaleX:Number;
		public static var scaleY:Number;
		
		//game resolutie X Y
		public static var screenX:int = 1280
		public static var screenY:int = 768;
		
		//phone resolutie X Y
		public static var phoneX:int;
		public static var phoneY:int;
		
		//init func called bij loader
		public static function init(width:int, height:int):void
		{
			//save phone resolution
			phoneX = width;
			phoneY = height;
			
			//calculate scale
			scaleX = width / screenX;
			scaleY = height / screenY;
		}
		
		//translate X (game resolution to phone resolution)
		public static function tX(px:Number):Number
		{
			return px * scaleX;
		}
		
		//translate Y (game resolution to phone resolution)
		public static function tY(py:Number):Number
		{
			return py * scaleY;
		}
		
		//revert X (phone resolution to game resolution)
		public static function rX(px:Number):Number
		{
			return px / scaleX;
		}
		
		//revert Y (phone resolution to game resolution)
		public static function rY(py:Number):Number
		{
			return py / scaleY;
		}
	}
}