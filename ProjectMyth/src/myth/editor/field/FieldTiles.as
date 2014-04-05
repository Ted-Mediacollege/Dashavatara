package myth.editor.field 
{
	import myth.data.Theme;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import myth.graphics.AssetList;
	import myth.util.MathHelper;
	import myth.editor.EditorFiles;
	
	public class FieldTiles extends Sprite
	{
		public static var textureSize:Number = 127;
		public var TILES:Vector.<Image>;
		
		public function FieldTiles() 
		{
			
		}
		
		public function build(t:int):void
		{
			var tile_names:Vector.<String> = EditorFiles.getTileNames(t);
			var tile_textures:Vector.<Texture> = new Vector.<Texture>();
			for (var j:int = 0; j < tile_names.length; j++ )
			{
				tile_textures.push(AssetList.assets.getTexture(tile_names[j]));
			}
			
			var maxRandom:int = tile_textures.length;
			TILES = new Vector.<Image>();
			
			for (var i:int = 0; i < 13; i++ )
			{
				var tile:Image = new Image(tile_textures[MathHelper.nextInt(maxRandom)]);
				tile.x = i * textureSize;
				tile.y = 768 - 128;
				tile.touchable = false;
				addChild(tile);
				TILES.push(tile);
			}
		}
		
		public function tick(camX:Number):void
		{
			x = -camX;
			
			for (var i:int = TILES.length - 1; i > -1; i-- )
			{
				if (TILES[i].x + TILES[i].width < -x)
				{
					TILES[i].x += 13 * 127;
				}
				else if (TILES[i].x > -x + 1280)
				{
					TILES[i].x -= 13 * 127;
				}
			}
		}
	}
}