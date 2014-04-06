package myth.world 
{
	import flash.events.TimerEvent;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import myth.util.ScaleHelper;
	import myth.graphics.AssetList;
	import myth.data.Theme;
	import starling.display.Image;
	import myth.util.MathHelper;
	import starling.textures.TextureSmoothing;
	
	public class WorldTiles extends Sprite
	{				
		//NEED TO BE THE SAME IN EditorFiles.as
		private static var textures_sky:Vector.<String> = new <String>["sky_tile00", "sky_tile01"];
		private static var textures_earth:Vector.<String> = new <String>["earth_tile00", "earth_tile01"];
		private static var textures_hell:Vector.<String> = new <String>["hell_tile00", "hell_tile01", "hell_tile02", "hell_tile03"];
		
		public var TILES:Vector.<Image>;
		public var changed:Boolean = true;
		public var textureSize:Number = 127;
		
		public function WorldTiles(camX:Number, theme:int) 
		{
			TILES = new Vector.<Image>();

			x = -camX;
			
			var textureNames:Vector.<String> = getTexturesForTheme(theme);
			var maxRand:int = textureNames.length;
			for (var i:int = 0; i < 13; i++ )
			{
				var t:Image = new Image(AssetList.assets.getTexture(textureNames[MathHelper.nextInt(maxRand)]));
				t.smoothing = TextureSmoothing.NONE;
				t.x = i * textureSize;
				t.y = 768 - 128;
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

			for (var i:int = TILES.length - 1; i > -1; i-- )
			{
				if (TILES[i].x + TILES[i].width < -x)
				{
					TILES[i].x += 13 * textureSize;
				}
			}
		}
	}
}