package myth.world 
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	import myth.util.ScaleHelper;
	import myth.tile.Tile;
	import myth.graphics.TextureList;

	public class WorldTiles extends Sprite
	{		
		public var TILES:Vector.<Tile>;
		public var changed:Boolean = true;
		
		public var textures:Vector.<Texture>;
		public var data:Vector.<int>;
		public var textureSize:Number = 127;
		
		public function WorldTiles(d:Vector.<int>) 
		{
			TILES = new Vector.<Tile>();
			
			textures = TextureList.atlas_background.getTextures("water");
			data = d;
		}
		
		public function build(camX:Number):void
		{
			x = -camX;
			
			var lowestID:int = int(Math.floor((x - 256) / textureSize));
			var highestID:int = int(Math.ceil((x + 1280) / textureSize));
			
			for (var j:int = lowestID; j < highestID + 1; j++)
			{
				addTile(j);
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
					addTile(j);
				}
			}
			
			if (changed)
			{
				//flatten();
				changed = false;
				//trace("FLATTEN");
			}
		}
		
		public function addTile(id:int):void
		{
			if (id > -1 && id < data.length)
			{
				if (data[id] < textures.length)
				{
					if (!changed)
					{
						//unflatten();
						changed = true;
						//trace("UNFLATTEN");
					}
					
					var t:Tile = new Tile(textures[data[id]], id * textureSize, 768 - 128, id);
					TILES.push(t);
					addChild(t);
				}
			}
		}
	}
}