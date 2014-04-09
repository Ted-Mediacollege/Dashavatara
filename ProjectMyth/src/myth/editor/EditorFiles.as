package myth.editor 
{
	import myth.data.Theme;
	
	public class EditorFiles 
	{
		//NEED TO BE THE SAME IN WorldTiles2.as
		private static var tiles_sky:Vector.<String> = new <String>["sky_tile00", "sky_tile01"];
		private static var tiles_earth:Vector.<String> = new <String>["earth_tile00", "earth_tile01"];
		private static var tiles_hell:Vector.<String> = new < String > ["hell_tile00", "hell_tile01", "hell_tile02", "hell_tile03"];
		
		private static var objects_sky:Vector.<String> = new <String>["sky_pilar"];
		private static var objects_earth:Vector.<String> = new <String>["earth_pilaar"];
		private static var objects_hell:Vector.<String> = new <String>["hell_pilar"];
		
		//NEED TO BE THE SAME IN WorldBackground.as
		private static var background_sky:Vector.<String> = new <String>["sky_tree", "sky_flower", "common_easteregg1"];
		private static var background_earth:Vector.<String> = new <String>["broken tower", "earth_bush", "earth_grass1", "earth_grass2", "earth_tree", "earth_veg", "earth_venus_flytrap"];
		private static var background_hell:Vector.<String> = new <String>["hell_bg_rock1", "hell_bg_rock2", "hell_bg_rock3", "hell_bg_rock4", "hell_bg_stalag"];
		
		private static var enemies:Vector.<String> = new <String>["editor_enemie", "editor_enemie", "editor_enemie2", "editor_rock"];
		
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
				default:          return "hell_lucht";
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