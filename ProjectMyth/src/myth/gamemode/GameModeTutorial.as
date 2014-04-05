package myth.gamemode 
{
	import myth.graphics.AssetList;
	import myth.tutorial.TutorialPanel;
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
	import myth.lang.Lang;
	import starling.display.Image;
	import starling.display.Sprite;
	import myth.graphics.Display;
	import myth.graphics.LayerID;
	
	public class GameModeTutorial extends GameMode
	{
		public var checkpointState:int;
		public var tutorialState:int;
		
		public var panelHolder:Sprite;
		public var panel:TutorialPanel;
		
		public function GameModeTutorial(start:int = 0) 
		{
		}
		
		override public function init():void
		{
			tutorialState = 0;
			
			world.speed = 6;
			world.endPointPosition = 2000;
			
			AssetList.loadLevelAssets(0, PlayerType.Fish, PlayerType.Fluit, PlayerType.Lion);
			
			GuiGame.restartText = "Restart Tutorial";
		}
		
		override public function build():void
		{
			//AssetList.soundLevel.playSound("levelMusic");
			
			world.physicsWorld = new PhysicsWorld();
			world.playerHolder = new PlayerHolder();			
			
			world.entityManager = new WorldEntityManager(new Vector.<Vector.<int>>());
			world.tiles = new WorldTiles(0, 0);
			world.background = new WorldBackground(new Vector.<Vector.<int>>(), 0);
			world.objectManager = new WorldObjectManager(0, new Vector.<Vector.<int>>());
			world.zoneManager = new WorldZoneManager(new Vector.<Vector.<int>>());
		}
		
		override public function tutorialBuild():void
		{
			world.gui.b1.visible = false;
			world.gui.b2.visible = false;
			world.gui.b3.visible = false;
			world.gui.b1.enabled = false;
			world.gui.b2.enabled = false;
			world.gui.b3.enabled = false;
			
			panelHolder = new Sprite();
			Display.add(panelHolder, LayerID.GameLevelBack);
			
			panel = new TutorialPanel("Welcome to the tutorial\n\nYou can acces the pause menu at any time bij pressing the pause button on the top right corner of the screen");
			panelHolder.addChild(panel)
		}
		
		override public function tick():void
		{
			world.endPointPosition = world.distance + 2000;
		}
		
		override public function onRestart():void
		{
			world.gui.main.switchGui(new GuiGame(new GameModeTutorial(0)));
		}
		
		override public function onDeath():void
		{
			world.gui.main.switchGui(new GuiGame(new GameModeTutorial(checkpointState)));
		}
	}
}