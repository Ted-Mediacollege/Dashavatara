package myth.data 
{
	import flash.net.SharedObject;
	import myth.data.GameData;
	
	public class SaveData 
	{
		public static var file:SharedObject;
		public static var saveVersion:int = 13;
		
		public static function init():void
		{
			file = SharedObject.getLocal("dashavatara_main");
			load();
		}
		
		public static function load():void
		{
			var f:int = int(file.data.first);
			
			if (f == saveVersion)
			{
				GameData.LANG = int(file.data.lang);
				GameData.MUSIC = Boolean(file.data.music);
				GameData.SOUND = Boolean(file.data.sound);
				GameData.levelsUnlocked = int(file.data.unlocked);
				GameData.levelList = file.data.level_list;
				GameData.levelnames = file.data.level_names;
				
				trace("[SAVED-DATA]: Loaded! (version "+saveVersion+")");
			}
			else
			{
				file.clear();
				trace("[SAVED-DATA]: not found, creating new file.");
			}
		}
		
		public static function save():void
		{
			file.data.first = saveVersion;
			file.data.lang = GameData.LANG;
			file.data.music = GameData.MUSIC;
			file.data.sound = GameData.SOUND;
			file.data.unlocked = GameData.levelsUnlocked;
			file.data.level_list = GameData.levelList;
			file.data.level_names = GameData.levelnames;
			
			file.flush();
			trace("[SAVED-DATA]: saved!");
		}
	}
}