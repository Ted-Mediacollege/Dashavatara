package myth.data 
{
	import flash.net.SharedObject;
	import myth.data.GameData;
	
	public class SaveData 
	{
		public static var file:SharedObject;
		
		public static function init():void
		{
			file = SharedObject.getLocal("dashavatara_main");
			load();
		}
		
		public static function load():void
		{
			var f:int = int(file.data.first);
			
			if (f == 10)
			{
				GameData.LANG = int(file.data.lang);
				GameData.MUSIC = Boolean(file.data.music);
				GameData.SOUND = Boolean(file.data.sound);
				GameData.levelsUnlocked = int(file.data.unlocked);
			}
		}
		
		public static function save():void
		{
			file.data.first = 10;
			file.data.lang = GameData.LANG;
			file.data.music = GameData.MUSIC;
			file.data.sound = GameData.SOUND;
			file.data.unlocked = GameData.levelsUnlocked;
			
			file.flush();
		}
	}
}