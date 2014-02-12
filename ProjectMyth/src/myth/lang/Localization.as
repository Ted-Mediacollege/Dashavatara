package myth.lang 
{
	public class Localization 
	{
		[Embed(source = "../../../lib/lang/lang_ENG.xml", mimeType = "application/octet-stream")]
		public static var xml_english:Class;
		
		public static var languages:Vector.<Language>;
		
		public static var MENU:int = 0;
		public static var INGAME:int = 1;
		
		public static function init():void
		{
			languages = new Vector.<Language>();
			
			languages.push(new Language(new XML(new xml_english())));
		}
		
		public static function getTranslation(catigory:int, string:String):String
		{
			return "NOT FOUND";
		}
	}
}