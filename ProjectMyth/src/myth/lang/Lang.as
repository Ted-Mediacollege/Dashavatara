package myth.lang 
{
	import myth.graphics.AssetList;
	import myth.data.GameData;
	
	public class Lang 
	{
		public static var language_list:Vector.<String> = new < String > ["English", "Nederlands"];//, "Test" , "Yolo"];
		
		public static var language:Language;
		public static var currentLang:int = -1;
		
		public static var MENU:int = 0;
		public static var INGAME:int = 1;
		public static var EDITOR:int = 2;
		public static var TUTORIAL:int = 3;
		
		public static function init():void
		{
			setLanguage(GameData.LANG);
		}
		
		public static function setLanguage(id:int):void
		{
			if (id == currentLang)
			{
				return;
			}
			
			currentLang = id;
			
			switch(id)
			{
				case 1: language = new Language(AssetList.assets.getXml("lang_NL")); break;
				case 2: language = new Language(AssetList.assets.getXml("lang_TEST")); break;
				case 99: language = new Language(AssetList.assets.getXml("lang_YOLO")); break;
				default: language = new Language(AssetList.assets.getXml("lang_ENG")); break;
			}
		}
		
		public static function trans(catigory:int, name:String):String
		{
			return language.getTranslation(catigory, name);
		}
	}
}