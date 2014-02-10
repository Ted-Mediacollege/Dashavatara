package myth.graphics 
{
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	
	public class TextureList 
	{
		//textures
		[Embed(source="../../../lib/textures/gui.png")]
		public static var gui_textures:Class;
		[Embed(source="../../../lib/textures/gui_achtergrond.png")]
		public static var gui_background_textures:Class;
		
		//xml files
		[Embed(source = "../../../lib/textures/gui.xml", mimeType = "application/octet-stream")]
		public static var gui_xml:Class;
		[Embed(source = "../../../lib/textures/gui_achtergrond.xml", mimeType = "application/octet-stream")]
		public static var gui_background_xml:Class;
		
		//texture atlas
		public static var atlas_gui:TextureAtlas;
		public static var atlas_gui_background:TextureAtlas;
		
		public static function load():void
		{
			atlas_gui = new TextureAtlas(Texture.fromBitmap(new gui_textures()), XML(new gui_xml()));
			atlas_gui_background = new TextureAtlas(Texture.fromBitmap(new gui_background_textures()), XML(new gui_background_xml()));
		}
	}
}