package myth.gamemode 
{
	import myth.gui.game.GuiEditor;
	import myth.data.LevelData;
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
	import myth.gui.game.GuiGame;
	
	public class GameModeEditor extends GameMode
	{
		private var editor_string:String;
		private var editor_saveID:int;
		
		public var levelData:LevelData;
		
		public function GameModeEditor(s:String, id:int) 
		{
			super();
			
			editor_string = s;
			editor_saveID = id;
			
			levelData = new LevelData();
			levelData.loadFromString(editor_string, "test");
		}
		
		override public function init():void
		{
			world.speed = levelData.startSpeed;
			world.endPointPosition = levelData.endPointPosition;
			
			AssetList.loadLevelAssets(levelData.theme, PlayerType.Fish, PlayerType.Fluit, PlayerType.Lion);
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
			world.gui.main.switchGui(new GuiGame(new GameModeEditor(editor_string, editor_saveID)));
		}
		
		override public function onPause():void
		{
			world.gui.main.switchGui(new GuiEditor(editor_string, editor_saveID));
		}
		
		override public function onDeath():void
		{
			world.gui.main.switchGui(new GuiEditor(editor_string, editor_saveID));
		}
		
		override public function onWin():void
		{
			world.gui.main.switchGui(new GuiEditor(editor_string, editor_saveID));
		}
	}
}