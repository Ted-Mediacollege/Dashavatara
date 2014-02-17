package myth.world 
{
	import myth.background.Background;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	import myth.util.TimeHelper;
	
	public class WorldBackground extends Sprite
	{
		public var Backgrounds:Vector.<Background>;
		
		public function WorldBackground() 
		{
			Backgrounds = new Vector.<Background>();
		}
		
		public function build(camX:Number):void
		{
			x = -camX;
			
			for (var i:int = 0; i < 0; i++ )
			{
				var b:Background = new Background(null, 0, 0, 0);
				b.visible = false;
				Backgrounds.push(b);
				addChild(b);
			}
		}
		
		public function tick(camX:Number):void
		{
			x = -camX;
			
			for (var i:int = Backgrounds.length - 1; i > -1; i-- )
			{
				Backgrounds[i].visible = false;
			}
		}
	}
}