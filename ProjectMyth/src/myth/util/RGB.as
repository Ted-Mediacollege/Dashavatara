package myth.util 
{
	public class RGB 
	{		
		public var r:int;
		public var g:int;
		public var b:int;
		
		public function RGB(red:int, green:int, blue:int) 
		{
			r = red;
			g = green;
			b = blue;
		}	
		
		public static function rgbToHex(rgb:RGB):uint 
		{
			return ((rgb.r << 16) | (rgb.g << 8) | rgb.b);
		}
		
		public static function hexToRgb(h:uint):RGB
		{	
			return new RGB((h >> 16) & 0xFF, (h >> 8) & 0xFF, (h) & 0xFF);
		}
	}
}