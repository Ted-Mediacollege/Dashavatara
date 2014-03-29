package myth.background 
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.Image;
	
	public class Background extends Image
	{	
		public var z:Number;
		public var posX:Number;
		
		public function Background(t:Texture, px:Number, py:Number, pz:Number, sx:Number, sy:Number) 
		{
			super(t);
			x = px;
			y = py;
			scaleX = sx;
			scaleY = sy;
			touchable = false;
			
			z = pz;
			posX = px;
		}	
	}
}