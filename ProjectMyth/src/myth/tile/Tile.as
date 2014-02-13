package myth.tile 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Tile extends Sprite
	{
		public static var GROUND:int = 0;
		public static var WATER:int = 1;
		
		public var id:int;
		
		public function Tile(i:int) 
		{
			id = i;
		}	
	}
}