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
	import myth.data.Theme;

	public class WorldTiles2 extends Sprite
	{				
		//NEED TO BE THE SAME IN EditorFiles.as
		private static var textures_sky:Vector.<String> = new <String>["sky_tile00", "sky_tile01"];
		private static var textures_earth:Vector.<String> = new <String>["earth_tile00", "earth_tile01"];
		private static var textures_hell:Vector.<String> = new <String>[""];
		
		public var TILES:Vector.<Tile>;
		public var changed:Boolean = true;
		public var textureSize:Number = 127;
		
		public function WorldTiles2() 
		{
			TILES = new Vector.<Tile>();
		}
		
		public function build(camX:Number, d:Vector.<int>, theme:int):void
		{
			x = -camX;
			
			var textureNames:Vector.<String> = getTexturesForTheme(theme);
			var tileLength:int = d.length;
			for (var i:int = 0; i < tileLength; i++ )
			{
				var t:Tile = new TileDefault(TextureList.assets.getTexture(textureNames[d[i]]), i * textureSize, 768 - 128, i);
				t.visible = false;
				TILES.push(t);
				addChild(t);
			}
		}
		
		public function getTexturesForTheme(theme:int):Vector.<String>
		{
			switch(theme)
			{
				case Theme.SKY:   return textures_sky;
				case Theme.EARTH: return textures_earth;
				default:          return textures_hell;
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
		}
	}
}