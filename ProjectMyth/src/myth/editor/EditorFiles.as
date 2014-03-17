package myth.editor 
{
	import starling.textures.Texture;
	import myth.graphics.TextureList;
	
	public class EditorFiles 
	{
		public static var LIST_TILES:Vector.<EditorFiles> = new Vector.<EditorFiles>();
		public static var LIST_ENTITIES:Vector.<EditorFiles> = new Vector.<EditorFiles>();
		public static var LIST_OBJECTS:Vector.<EditorFiles> = new Vector.<EditorFiles>();
		
		public static var TILE_SKY_0:EditorFiles = new EditorFiles(0, "sky_tile00", 0);
		public static var TILE_SKY_1:EditorFiles = new EditorFiles(0, "sky_tile01", 1);
		
		public var artName:String;
		public var fileID:int;
		public var art:Texture;
		public var catigory:int;
		
		public function EditorFiles(type:int, art:String, cat:int, id:int) 
		{
			artName = art;
			fileID = id;
			catigory = cat;
			
			switch(type)
			{
				case 0: LIST_TILES.push(this); break;
				case 1: LIST_ENTITIES.push(this); break;
				default: LIST_OBJECTS.push(this); break;
			}
		}
		
		public static function loadTextures():void
		{
			for (var i:int = LIST_TILES.length - 1; i > -1; i-- )
			{
				LIST_TILES[i].art = TextureList.assets.getTexture(LIST_TILES[i].artName);
			}
			
			for (var j:int = LIST_ENTITIES.length - 1; j > -1; j-- )
			{
				LIST_ENTITIES[i].art = TextureList.assets.getTexture(LIST_ENTITIES[i].artName);
			}
			
			for (var k:int = LIST_OBJECTS.length - 1; k > -1; k-- )
			{
				LIST_OBJECTS[i].art = TextureList.assets.getTexture(LIST_OBJECTS[i].artName);
			}
		}
		
		public static function unLoadTextures():void
		{
			for (var i:int = LIST_TILES.length - 1; i > -1; i-- )
			{
				LIST_TILES[i].art = null;
			}
			
			for (var j:int = LIST_ENTITIES.length - 1; j > -1; j-- )
			{
				LIST_ENTITIES[j].art = null;
			}
			
			for (var k:int = LIST_OBJECTS.length - 1; k > -1; k-- )
			{
				LIST_OBJECTS[k].art = null;
			}
		}
	}
}