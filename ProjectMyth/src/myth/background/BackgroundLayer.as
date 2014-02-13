package myth.background 
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	import myth.util.ScaleHelper;

	public class BackgroundLayer extends Sprite
	{		
		public var TILES:Vector.<Background>;
		public var changed:Boolean = true;
		
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
		
		public function build(camX:Number):void
		{
			x = -camX;
			
			var lowestID:int = int(Math.floor((x - 256) / textureSize));
			var highestID:int = int(Math.ceil((x + 1280) / textureSize));
			
			for (var j:int = lowestID; j < highestID + 1; j++)
			{
				addBackground(j);
			}
		}
		
		public function tick(camX:Number):void
		{
			x = -camX;
			
			var lowestID:int = int(Math.floor((-x - 256) / textureSize));
			var highestID:int = int(Math.ceil((-x + 1280) / textureSize));
			
			for (var i:int = TILES.length - 1; i > -1; i-- )
			{
				if (TILES[i].id < lowestID || TILES[i].id > highestID)
				{
					removeChild(TILES[i]);
					TILES.splice(i, 1);
				}
			}
				
			for (var j:int = lowestID; j < highestID + 1; j++)
			{
				var f:Boolean = false;
				for (var k:int = TILES.length - 1; k > -1; k-- )
				{
					if (TILES[k].id == j)
					{
						f = true;
						break;
					}
				}
				
				if (!f)
				{
					addBackground(j);
				}
			}
			
			if (changed)
			{
				//flatten();
				changed = false;
				trace("FLATTEN");
			}
		}
		
		public function addBackground(id:int):void
		{
			if (id > -1 && id < data.length)
			{
				if (data[id] < textures.length)
				{
					if (!changed)
					{
						//unflatten();
						changed = true;
						trace("UNFLATTEN");
					}
					
					var b:Background = new Background(textures[data[id]], id * textureSize, 0, 1, id);
					TILES.push(b);
					addChild(b);
				}
			}
		}
	}
}