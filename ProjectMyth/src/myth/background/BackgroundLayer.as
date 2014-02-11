package myth.background 
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	import myth.util.ScaleHelper;

	public class BackgroundLayer extends Sprite
	{		
		public var TILES:Vector.<Background>;
		
		public var textures:Vector.<Texture>;
		public var data:Vector.<int>;
		public var layerdepth:Number;
		public var textureSize:Number;
		
		public function BackgroundLayer(t:Vector.<Texture>, d:Vector.<int>, depth:Number, s:Number) 
		{
			TILES = new Vector.<Background>();
			
			textures = t;
			data = d;
			layerdepth = depth;
			textureSize = s;
		}
		
		public function build():void
		{
			
		}
		
		public function tick(camX:Number):void
		{
			for (var i:int = TILES.length - 1; i > -1; i-- )
			{
				if (isInside(TILES[i].id))
				{
					TILES[i].x = camX - TILES[i].id * textureSize;
				}
				else
				{
					removeChild(TILES[i]);
					TILES.splice(i, 1);
				}
			}
		}
		
		public function addBackground(id:int):void
		{
			
		}
		
		public function isInside(i:int):Boolean
		{
			if (ScaleHelper.tX(i * textureSize + textureSize) > -20 && ScaleHelper.tX(i * textureSize) < ScaleHelper.phoneX + 20 )
			{
				return true;
			}
			
			return false;
		}
	}
}