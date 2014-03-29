package myth.data 
{
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import myth.entity.objects.ObjectType;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import starling.utils.AssetManager;
	import myth.data.Theme;
	
	public class LevelData 
	{
		
		public var levelData:Object;
		public var levelName:String;
		public var nextLvlName:String;
		public var enemyData:Vector.<Vector.<int>>;
		public var tileData:Vector.<int>;
		public var backgroundAssetData:Vector.<Vector.<int>>;
		public var zoneData:Vector.<Vector.<int>>;
		public var ObjectData:Vector.<Vector.<int>>;
		public var endPointPosition:Number;
		public var startSpeed:Number;
		public var levelLength:int;
		public var theme:int;
		
		public function LevelData()
		{	
		}
		
		public function loadFromString(data:String, _levelName:String):void
		{
			levelName = _levelName;
			var i:int;
			
			//parse
			levelData = JSON.parse(data);
			
			//theme
			theme = levelData.theme;
			Theme.MENU_THEME = theme;
			
			//set end point position
			for (i = 0; i < levelData.objects.length; i++) 
			{
				if(levelData.objects[i].type == ObjectType.endPort1){
					endPointPosition = levelData.objects[i].x;
				}
			}
			
			//set level startSpeed
			startSpeed = levelData.speed;
			nextLvlName = levelData.next_level_name;
			
			//set enemy data in vector
			enemyData = new Vector.<Vector.<int>>(levelData.enemies.length);
			for (i = 0; i < levelData.enemies.length; i++) 
			{
				enemyData[i] = new <int>[ levelData.enemies[i].type, levelData.enemies[i].spawnX, levelData.enemies[i].spawnY ];
			}
			
			//set tile data in vector
			tileData = new Vector.<int>(levelData.tiles.length);
			for (i = 0; i < levelData.tiles.length; i++) 
			{
				tileData[i] = levelData.tiles[i].type as int;
			}
			
			//level length
			levelLength = levelData.tiles.length;
			
			//set layer data in vector
			backgroundAssetData = new Vector.<Vector.<int>> (levelData.background_props.length);
			for (i = 0; i < levelData.background_props.length; i++) 
			{
				backgroundAssetData[i] = new <int>[ levelData.background_props[i].type, levelData.background_props[i].depth, levelData.background_props[i].x, levelData.background_props[i].y];
			}
			
			//set object data in vector
			ObjectData = new Vector.<Vector.<int>> (levelData.objects.length);
			for (i = 0; i < levelData.objects.length; i++) 
			{
				ObjectData[i] = new <int>[ levelData.objects[i].type, levelData.objects[i].x, levelData.objects[i].y];
			}
			
			//set zonedata in vector
			zoneData = new Vector.<Vector.<int>>(levelData.zones.length);
			for (i = 0; i < levelData.zones.length; i++) 
			{
				zoneData[i] = new <int>[ levelData.zones[i].type, levelData.zones[i].xPos, levelData.zones[i].deltaSpeed, levelData.zones[i].zonewidth ];
			}
		}
		
		public function loadFile(_levelName:String = "level_1"):void
		{
			var levelFile:File = File.applicationDirectory.resolvePath("JSONData/" + _levelName + ".json");
			var myFileStream:FileStream = new FileStream();
			myFileStream.open(levelFile, FileMode.READ);
			var jsonString:String = myFileStream.readUTFBytes(myFileStream.bytesAvailable);
			myFileStream.close();
			
			loadFromString(jsonString, _levelName);
		}
	}
}