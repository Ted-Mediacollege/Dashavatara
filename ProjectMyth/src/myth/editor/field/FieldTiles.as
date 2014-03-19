package myth.editor.field 
{
	import myth.tile.Tile;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import myth.graphics.TextureList;
	import myth.util.MathHelper;
	
	public class FieldTiles extends Sprite
	{
		public static var textureSize:Number = 127;
		
		public static var tile_names_sky:Vector.<String> = new <String>["sky_tile00", "sky_tile01"];
		
		public var tile_textures:Vector.<Texture>;
		
		public var TILES:Vector.<Sprite>;
		
		public function FieldTiles() 
		{
			
		}
		
		public function buildCommon(t:int):void
		{
			var tile_names:Vector.<String>;
			
			switch(t)
			{
				default: tile_names = tile_names_sky; break;
			}
			
			tile_textures = new Vector.<Texture>();
			for (var i:int = 0; i < tile_names.length; i++ )
			{
				tile_textures.push(TextureList.assets.getTexture(tile_names[i]));
			}
		}
		
		public function buildNew(a:int, t:int):void
		{
			buildCommon(t);
			
			var maxRandom:int = tile_textures.length;
			TILES = new Vector.<Sprite>();
			for (var i:int = 0; i < a; i++ )
			{
				var s:Sprite = new Sprite();
				s.x = i * textureSize;
				s.y = 768 - 128;
				s.touchable = false;
				addChild(s);
				
				TILES.push(s);
				
				var tile:Image = new Image(tile_textures[MathHelper.nextInt(maxRandom)]);
				s.addChild(tile);
				s.flatten();
			}
		}
		
		public function buildFile(t:int):void
		{
			buildCommon(t);
		}
		
		public function tick(camX:Number):void
		{
			x = -camX;
			
			var lowestID:int = int(Math.floor((-x - 256) / textureSize));
			var highestID:int = int(Math.ceil((-x + 1080) / textureSize));
			
			for (var i:int = TILES.length - 1; i > -1; i-- )
			{
				if (i < lowestID || i > highestID)
				{
					TILES[i].visible = false;
				}
				else
				{
					TILES[i].visible = true;
				}
			}
		}
	}
}