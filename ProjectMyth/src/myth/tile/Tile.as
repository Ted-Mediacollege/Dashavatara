package myth.tile 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Tile extends Sprite
	{
		public var image:Image;
		public var id:int;
		
		public function Tile(t:Texture, px:Number, py:Number, i:int) 
		{
			image = new Image(t);
			image.x = px;
			image.y = py;
			addChild(image);
			
			id = i;
			
			flatten();
		}	
	}
}