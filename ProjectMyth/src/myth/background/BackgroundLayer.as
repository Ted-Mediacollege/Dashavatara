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
		
		public function build(camX:Number):void
		{
			var lowestID:int = int(Math.floor(camX / textureSize));
			var highestID:int = int(Math.ceil((camX + 1280) / textureSize));
			
			for (var j:int = lowestID; j < highestID + 1; j++)
			{
				var f:Boolean = false;
				for (var k:int = TILES.length - 1; k > -1; k-- )
				{
					if (TILES[k].id == j)
					{
						f = true;
					}
				}
				
				if (!f)
				{
					addBackground(j, camX);
				}
			}
		}
		
		public function tick(camX:Number):void
		{
			for (var i:int = TILES.length - 1; i > -1; i-- )
			{
				if (isInside(TILES[i].id))
				{
					//TILES[i].x = -camX + TILES[i].id * textureSize;
					TILES[i].x = TILES[i].id * textureSize;
				}
				else
				{
					removeChild(TILES[i]);
					TILES.splice(i, 1);
				}
			}
			
			var lowestID:int = int(Math.floor(camX / textureSize));
			var highestID:int = int(Math.ceil((camX + 1280) / textureSize));
			
			for (var j:int = lowestID; j < highestID + 1; j++)
			{
				var f:Boolean = false;
				for (var k:int = TILES.length - 1; k > -1; k-- )
				{
					if (TILES[k].id == j)
					{
						f = true;
					}
				}
				
				if (!f)
				{
					addBackground(j, camX);
				}
			}
		}
		
		public function addBackground(id:int, camX:Number):void
		{
			if (id > -1 && id < data.length)
			{
				if (data[id] < textures.length)
				{
					var b:Background = new Background(textures[data[id]], -camX + id * textureSize, 0, 1, id);
					TILES.push(b);
					addChild(b);
				}
			}
		}
		
		public function isInside(i:int):Boolean
		{
			if (i * textureSize + textureSize > -1 && i * textureSize < 1281 )
			{
				return true;
			}
			
			return false;
		}
	}
}