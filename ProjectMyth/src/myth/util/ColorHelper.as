package myth.util 
{
	public class ColorHelper 
	{
		public static function invertHex(h:uint):uint 
		{
			var rgb:Vector.<uint> = hexToRgb(h);	
			return rgbToHex(255 - rgb[0], 255 - rgb[1], 255 - rgb[2]);
		}
	}
}