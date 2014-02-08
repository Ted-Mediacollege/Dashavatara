package myth.textures 
{
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	
	public class TextureList 
	{
		//textures
		[Embed(source="../../../lib/textures/gui.png")]
		public static var gui_textures:Class;
		
		//xml files
		[Embed(source = "../../../lib/textures/gui.xml", mimeType = "application/octet-stream")]
		public static var gui_xml:Class;
		
		//texture atlas
		public static var atlas_gui:TextureAtlas;
		
		public static function load():void
		{
			atlas_gui = new TextureAtlas(Texture.fromBitmap(new gui_textures()), XML(new gui_xml()));
		}
	}
}