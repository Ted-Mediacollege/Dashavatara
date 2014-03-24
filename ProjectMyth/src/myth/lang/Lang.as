package myth.lang 
{
	import myth.graphics.TextureList;
	import myth.data.GameData;
	
	public class Lang 
	{
		public static var language_list:Vector.<String> = new <String>["English", "Nederlands"];
		
		public static var language:Language;
		public static var currentLang:int = -1;
		
		public static var MENU:int = 0;
		public static var INGAME:int = 1;
		public static var EDITOR:int = 2;
		
		public static function init():void
		{
			setLanguage(0);//GameData.SYSTEM_LANG_ID);
		}
		
		public static function setLanguage(id:int):void
		{
			if (id == currentLang)
			{
				return;
			}
			
			switch(id)
			{
				case 1: language = new Language(TextureList.assets.getXml("lang_NL")); break;
				default: language = new Language(TextureList.assets.getXml("lang_ENG")); break;
			}
		}
		
		public static function trans(catigory:int, name:String):String
		{
			return language.getTranslation(catigory, name);
		}
	}
}