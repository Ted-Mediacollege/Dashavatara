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

		public var tile_textures:Vector.<Texture>;
		
		public var TILES:Vector.<Sprite>;
		public var TILES_IDS:Vector.<int>;
		
		public function FieldTiles() 
		{
			
		}
		
		public function buildCommon(t:int):void
		{
			var tile_names:Vector.<String> = EditorFiles.getTileNames(t);
			tile_textures = new Vector.<Texture>();
			for (var i:int = 0; i < tile_names.length; i++ )
			{
				tile_textures.push(AssetList.assets.getTexture(tile_names[i]));
			}
		}
		
		public function buildNew(a:int, t:int):void
		{
			buildCommon(t);
			
			var maxRandom:int = tile_textures.length;
			TILES = new Vector.<Sprite>();
			TILES_IDS = new Vector.<int>();
			
			for (var i:int = 0; i < a; i++ )
			{
				var s:Sprite = new Sprite();
				s.x = i * textureSize;
				s.y = 768 - 128;
				s.touchable = false;
				addChild(s);
				
				var rand:int = MathHelper.nextInt(maxRandom);
				
				TILES.push(s);
				TILES_IDS.push(rand);
				
				var tile:Image = new Image(tile_textures[rand]);
				s.addChild(tile);
				s.flatten();
			}
		}
		
		public function buildFile(a:Array, t:int):void
		{
			buildCommon(t);
			
			TILES = new Vector.<Sprite>();
			TILES_IDS = new Vector.<int>();
			
			var arrayLength:int = a.length;
			for (var i:int = 0; i < arrayLength; i++ )
			{
				var s:Sprite = new Sprite();
				s.x = i * textureSize;
				s.y = 768 - 128;
				s.touchable = false;
				addChild(s);

				TILES.push(s);
				TILES_IDS.push(a[i].type);
				
				var tile:Image = new Image(tile_textures[a[i].type]);
				s.addChild(tile);
				s.flatten();
			}
		}
		
		public function saveData(saveFile:Object):void
		{
			saveFile.tiles = new Array();
			var tileLength:int = TILES_IDS.length;
			for (var l:int = 0; l < tileLength; l++ )
			{
				var ti:Object = new Object();
				ti.type = TILES_IDS[l];
				saveFile.tiles.push(ti);
			}
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