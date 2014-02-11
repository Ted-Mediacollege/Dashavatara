package myth.background 
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.Image;
	
	public class Background extends Sprite
	{	
		public var image:Image;
		public var z:Number;
		public var id:int;
		
		public function Background(t:Texture, px:Number, py:Number, pz:Number, i:int) 
		{
			image = new Image(t);
			image.x = px;
			image.y = py;
			addChild(image);
			
			z = pz;
			id = i;
			
			flatten();
		}	
	}
}