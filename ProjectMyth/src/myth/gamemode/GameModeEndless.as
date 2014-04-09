package myth.gamemode 
{
	import myth.gamemode.event.EventBase;
	import myth.gamemode.event.EventEnemiesFlying;
	import myth.gamemode.event.EventPillarShort;
	import myth.graphics.AssetList;
	import myth.gui.game.GuiHighscore;
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
	import myth.util.MathHelper;
	
	public class GameModeEndless extends GameMode
	{
		public var theme:int;
		public var currentEvent:EventBase;
		
		public function GameModeEndless(t:int) 
		{
			theme = t;
		}
		
		override public function init():void
		{
			world.speed = 8;
			world.endPointPosition = 2000;
			
			AssetList.loadLevelAssets(theme);
		}
		
		override public function build():void
		{
			AssetList.soundLevel.playSound("levelMusic");
			
			world.physicsWorld = new PhysicsWorld();
			world.playerHolder = new PlayerHolder();			
			
			world.entityManager = new WorldEntityManager(new Vector.<Vector.<int>>());
			world.tiles = new WorldTiles(0, theme);
			world.background = new WorldBackground(new Vector.<Vector.<int>>(), theme);
			world.objectManager = new WorldObjectManager(theme, new Vector.<Vector.<int>>());
			world.zoneManager = new WorldZoneManager(new Vector.<Vector.<int>>());
			
			currentEvent = new EventPillarShort(this);
		}
		
		override public function tick():void
		{
			if (!isNaN(world.deltaSpeed))
			{
				currentEvent.distLeft -= world.deltaSpeed;
				currentEvent.tick();
				if (currentEvent.distLeft < 0)
				{
					newEvent();
				}
			}
			
			world.endPointPosition = world.distance + 2000;
			
			world.speed = 6 + (world.distance / 5000);
		}
		
		public function newEvent():void
		{
			switch(MathHelper.nextInt(2))
			{
				case 0: currentEvent = new EventPillarShort(this); break;
				case 1: currentEvent = new EventEnemiesFlying(this); break;
				default: currentEvent = new EventPillarShort(this); break;
			}
			
			currentEvent.init();
		}
		
		override public function onRestart():void
		{
			world.gui.main.switchGui(new GuiGame(new GameModeEndless(theme)));
		}
		
		override public function onDeath():void
		{
			world.gui.main.switchGui(new GuiHighscore(int(world.distance / 127)), true);
		}
	}
}