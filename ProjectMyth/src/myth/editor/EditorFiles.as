package myth.editor 
{
	import myth.data.Theme;
	
	public class EditorFiles 
	{
		//NEED TO BE THE SAME IN WorldTiles2.as
		private static var tiles_sky:Vector.<String> = new <String>["sky_tile00", "sky_tile01"];
		private static var tiles_earth:Vector.<String> = new <String>["earth_tile00", "earth_tile01"];
		private static var tiles_hell:Vector.<String> = new < String > [""];
		
		private static var objects_sky:Vector.<String> = new <String>["sky_pilar"];
		private static var objects_earth:Vector.<String> = new <String>["earth_pilaar"];
		private static var objects_hell:Vector.<String> = new <String>["earth_pilaar"];
		
		//NEED TO BE THE SAME IN WorldBackground.as
		private static var background_sky:Vector.<String> = new <String>["sky_tree"];
		private static var background_earth:Vector.<String> = new <String>["earth_tree"];
		private static var background_hell:Vector.<String> = new <String>["earth_tree"];
		
		private static var enemies:Vector.<String> = new <String>[""];
		
		public function EditorFiles() 
		{
		}
		
		public static function getEnemieNames():Vector.<String>
		{
			return enemies;
		}
		
		public static function getLuchtName(theme:int):String
		{
			switch(theme)
			{
				case Theme.SKY:   return "sky_lucht";
				case Theme.EARTH: return "earth_lucht";
				default:          return "";
			}
		}
		
		public static function getTileNames(theme:int):Vector.<String>
		{
			switch(theme)
			{
				case Theme.SKY:   return tiles_sky;
				case Theme.EARTH: return tiles_earth;
				default:          return tiles_hell;
			}
		}
		
		public static function getObjectNames(theme:int):Vector.<String>
		{
			switch(theme)
			{
				case Theme.SKY:   return objects_sky;
				case Theme.EARTH: return objects_earth;
				default:          return objects_hell;
			}
		}
		
		public static function getBackgroundNames(theme:int):Vector.<String>
		{
			switch(theme)
			{
				case Theme.SKY:   return background_sky;
				case Theme.EARTH: return background_earth;
				default:          return background_hell;
			}
		}
	}
}