package myth.world 
{
	import flash.events.TimerEvent;
	import myth.tile.TileWater;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import myth.util.ScaleHelper;
	import myth.tile.Tile;
	import myth.tile.TileDefault;
	import myth.graphics.TextureList;

	public class WorldTiles2 extends Sprite
	{		
		public var TILES:Vector.<Tile>;
		public var changed:Boolean = true;
		
		public var textures:Vector.<Texture>;
		public var data:Vector.<int>;
		public var datalength:int;
		public var textureSize:Number = 127;
		
		public static var waterTiles:Vector.<Texture>;
		
		public function WorldTiles2(d:Vector.<int>) 
		{
			TILES = new Vector.<Tile>();
			
			waterTiles = TextureList.atlas_background.getTextures("water");
			textures = TextureList.atlas_background.getTextures("ground");
			data = d;
			datalength = data.length;
		}
		
		public function build(camX:Number):void
		{
			x = -camX;
			
			var lowestID:int = 0;
			var highestID:int = data.length - 1;
			
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
					TILES[i].visible = false;
				}
				else
				{
					TILES[i].visible = true;
				}
			}
			
			/*
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
				flatten();
				changed = false;
			}*/
		}
		
		public function addTile(id:int):void
		{
			if (id > -1 && id < data.length)
			{
				if (data[id] < textures.length)
				{
					if (!changed)
					{
						unflatten();
						changed = true;
						//trace("UNFLATTEN");
					}
					
					var t:Tile = getTileFromData(data[id], id * textureSize, 768 - 128, id);
					t.visible = false;
					TILES.push(t);
					addChild(t);
				}
			}
		}
		
		public function getTileFromData(id:int, px:Number, py:Number, pos:int):Tile
		{
			switch(id)
			{
				//case 0: return new TileDefault(textures[0], px, py, pos);
				//case 0: return new TileWater(px, py, pos);
				default: return new TileWater(px, py, pos);
				//default: return new TileDefault(textures[0], px, py, pos);
			}
		}
		
		public function getTileAt(distance:Number):int
		{
			var pos:int = int(distance / textureSize);
			if (pos > -1 && pos < datalength)
			{
				return data[pos];
			}
			return 0;
		}
	}
}