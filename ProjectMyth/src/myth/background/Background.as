package myth.background 
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.Image;
	
	public class Background extends Sprite
	{	
		public var image:Image;
		
		public var posX:Number;
		public var posY:Number;
		public var posZ:Number;
		
		public function Background(t:Texture, px:Number, py:Number, pz:Number) 
		{
			image = new Image(t);
			image.x = px;
			image.y = py;
			addChild(image);
			
			flatten();
		}	
	}
}