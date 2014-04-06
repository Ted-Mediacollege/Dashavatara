package myth.gamemode 
{
	import myth.gui.game.GuiGame;
	import myth.gui.game.GuiLose;
	import myth.gui.game.GuiWin;
	import myth.graphics.AssetList;
	import myth.world.WorldBackground;
	import myth.world.WorldEntityManager;
	import myth.world.WorldManagerBase;
	import myth.world.WorldObjectManager;
	import myth.world.WorldTiles;
	import myth.world.worldZones.WorldZoneManager;
	import myth.world.physicsWorld.PhysicsWorld;
	import myth.world.PlayerHolder;
	import myth.entity.player.PlayerType;
	import myth.data.LevelData;
	
	public class GameModeStory extends GameMode
	{
		public var level_name:String;
		public var level_id:int;
		
		public var levelData:LevelData;
		
		public function GameModeStory(lvlname:String, lvlID:int) 
		{
			super();
			
			level_name = lvlname;
			level_id = lvlID;
			
			levelData = new LevelData();
			levelData.loadFile(level_name);
		}
		
		override public function init():void
		{
			world.speed = levelData.startSpeed;
			world.endPointPosition = levelData.endPointPosition;
			
			AssetList.loadLevelAssets(levelData.theme);
		}
		
		override public function build():void
		{
			AssetList.soundLevel.playSound("levelMusic");
			
			world.physicsWorld = new PhysicsWorld();
			world.playerHolder = new PlayerHolder();			
			
			world.entityManager = new WorldEntityManager(levelData.enemyData);
			world.tiles = new WorldTiles(0, levelData.theme);
			world.background = new WorldBackground(levelData.backgroundAssetData, levelData.theme);
			world.objectManager = new WorldObjectManager(levelData.theme, levelData.ObjectData);
			world.zoneManager = new WorldZoneManager(levelData.zoneData);
		}
		
		override public function tick():void
		{
		}
		
		override public function onRestart():void
		{
			world.gui.main.switchGui(new GuiGame(new GameModeStory(level_name, level_id)));
		}
		
		override public function onDeath():void
		{
			world.gui.main.switchGui(new GuiLose(level_name, level_id));
		}
		
		override public function onWin():void
		{
			AssetList.soundCommon.playSound("winSound");
			world.gui.main.switchGui(new GuiWin(level_name, levelData.nextLvlName, level_id), true);
		}
	}
}