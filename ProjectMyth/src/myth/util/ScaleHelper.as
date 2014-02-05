package myth.util 
{
	public class ScaleHelper 
	{
		public static var scaleX:Number;
		public static var scaleY:Number;
		
		public static var screenX:int = 1280
		public static var screenY:int = 720;
		public static var centerX:int;
		public static var centerY:int;
		
		public static var phoneX:int;
		public static var phoneY:int;
		
		public static function init(width:int, height:int):void
		{
			centerX = int(screenX / 2);
			centerY = int(screenY / 2);
			
			phoneX = width;
			phoneY = height;
			
			scaleX = width / screenX;
			scaleY = height / screenY;
		}
		
		public static function sX(px:Number):Number
		{
			return px * scaleX;
		}
		
		public static function sY(py:Number):Number
		{
			return py * scaleY;
		}
	}
}