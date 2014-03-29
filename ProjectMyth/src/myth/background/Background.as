package myth.background 
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.Image;
	
	public class Background extends Sprite
	{	
		public var image:Image;
		public var z:Number;
		public var posX:Number;
		
		public function Background(t:Texture, px:Number, py:Number, pz:Number, sx:Number, sy:Number) 
		{
			image = new Image(t);
			x = px;
			y = py;
			image.scaleX = sx;
			image.scaleY = sy;
			addChild(image);
			
			touchable = false;
			
			z = pz;
			posX = px;
			
			flatten();
		}	
	}
}