package myth.gamemode 
{
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
	
	public class GameModeEndless extends GameMode
	{
		public var theme:int;
		public var timer:Number;
		
		public function GameModeEndless(t:int) 
		{
			theme = t;
		}
		
		override public function init():void
		{
			world.speed = 6;
			world.endPointPosition = 2000;
			
			timer = 600;
			
			AssetList.loadLevelAssets(theme, PlayerType.Fish, PlayerType.Fluit, PlayerType.Lion);
		}
		
		override public function build():void
		{
			//AssetList.soundLevel.playSound("levelMusic");
			
			world.physicsWorld = new PhysicsWorld();
			world.playerHolder = new PlayerHolder();			
			
			world.entityManager = new WorldEntityManager(new Vector.<Vector.<int>>());
			world.tiles = new WorldTiles(0, theme);
			world.background = new WorldBackground(new Vector.<Vector.<int>>(), theme);
			world.objectManager = new WorldObjectManager(theme, new Vector.<Vector.<int>>());
			world.zoneManager = new WorldZoneManager(new Vector.<Vector.<int>>());
		}
		
		override public function tick():void
		{
			if (!isNaN(world.deltaSpeed))
			{
				timer += world.deltaSpeed;
			}
				
			if (timer > 700)
			{
				timer = 0;
				
				world.background.addToQueue(0, 2, world.distance + (1300 * 2), 260);
			}
			
			world.endPointPosition = world.distance + 2000;
			
			//trace("Distance: " + (world.distance / 127));
		}
		
		override public function onRestart():void
		{
			world.gui.main.switchGui(new GuiGame(new GameModeEndless(theme)));
		}
		
		override public function onDeath():void
		{
			world.gui.main.switchGui(new GuiGame(new GameModeEndless(theme)));
		}
	}
}