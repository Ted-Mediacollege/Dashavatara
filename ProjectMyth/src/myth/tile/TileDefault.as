package myth.tile 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.BlendMode;
	
	public class TileDefault extends Tile
	{
		public function TileDefault(t:Texture, px:Number, py:Number, i:int) 
		{
			super(i);
			
			var image:Image = new Image(t);
			image.x = px;
			image.y = py;
			image.touchable = false;
			addChild(image);
			
			flatten();
		}	
	}
}