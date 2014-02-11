package myth.world 
{
	import myth.background.Background;
	import myth.background.BackgroundLayer;
	import starling.display.Sprite;
	
	public class WorldBackground extends Sprite
	{
		public var LAYERS:Vector.<BackgroundLayer>;
		
		public function WorldBackground() 
		{
		}
		
		public function build(camX:Number):void
		{
			/*
			
			var l:BackgroundLayer = new BackgroundLayer();
			LAYERS.push(l);
			addChild(l);
			
			*/
		}
		
		public function tick(camX:Number):void
		{
			for (var i:int = LAYERS.length - 1; i > -1; i-- )
			{
				LAYERS[i].tick(camX);
			}
		}
	}
}