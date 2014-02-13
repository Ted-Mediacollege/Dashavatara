package myth.world 
{
	import myth.background.Background;
	import myth.background.BackgroundLayer;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	
	public class WorldBackground extends Sprite
	{
		public var LAYERS:Vector.<BackgroundLayer>;
		private var test:Number = 1;
		
		public function WorldBackground() 
		{
		}
		
		public function build(camX:Number):void
		{
			LAYERS = new Vector.<BackgroundLayer>();
			
			var v:Vector.<int> = new Vector.<int>();
			v.push(0, 1, 2, 3, 4, 5, 6, 7, 0, 1, 2, 3, 4, 5, 6, 7);
			
			var l:BackgroundLayer = new BackgroundLayer(TextureList.atlas_background.getTextures("tiles"), v, 5, 256);
			l.build(0);
			LAYERS.push(l);
			addChild(l);
		}
		
		public function tick(camX:Number):void
		{
			test += 5;
			
			for (var i:int = LAYERS.length - 1; i > -1; i-- )
			{
				LAYERS[i].tick(test);
			}
		}
	}
}