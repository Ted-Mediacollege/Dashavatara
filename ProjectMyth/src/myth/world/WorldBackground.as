package myth.world 
{
	import myth.background.Background;
	import myth.background.BackgroundLayer;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	import myth.util.TimeHelper;
	
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
			v.push(0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3);
			
			var l:BackgroundLayer = new BackgroundLayer(TextureList.atlas_background.getTextures("tiles"), v, 5, 512);
			l.y = 400;
			l.build(0);
			LAYERS.push(l);
			addChild(l);
			
			var l2:BackgroundLayer = new BackgroundLayer(TextureList.atlas_background.getTextures("tiles"), v, 5, 512);
			l2.y = 600;
			l2.build(0);
			LAYERS.push(l2);
			addChild(l2);
		}
		
		public function tick(camX:Number):void
		{
			test += TimeHelper.deltatime * 70;
			
			for (var i:int = LAYERS.length - 1; i > -1; i-- )
			{
				if (i == 0)
				{
					LAYERS[i].tick(test);
				}
				else
				{
					LAYERS[i].tick(test * 2);
				}
			}
		}
	}
}