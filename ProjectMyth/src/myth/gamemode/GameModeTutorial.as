package myth.gamemode 
{
	import myth.entity.player.EntityPlayer03;
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
	import myth.input.TouchType;
	import myth.util.TimeHelper;
	
	public class GameModeTutorial extends GameMode
	{
		public var checkpointState:int;
		public var tutorialState:int;
		
		public var panelHolder:Sprite;
		public var panel:TutorialPanel;
		public var panelActive:Boolean;
		
		public var timer:Number = -10;
		public var buttonFlash:int = 20;
		
		public var tutorial_begin:int = 0;
		public var tutorial_jumper:int = 5;
		
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
			
			setState(0);
			
			world.inputEnabled = false;
		}
		
		public function setState(state:int):void
		{
			tutorialState = state;
			
			if (state == tutorial_begin + 0)
			{
				world.inputEnabled = false;
				setPanel("Welcome to the tutorial!");
			}
			else if (state == tutorial_begin + 1)
			{
				world.inputEnabled = false;
				setPanel("You can acces the pause menu at any time bij pressing the pause button on the top-right corner of your screen.");
			}
			else if (state == tutorial_begin + 2)
			{
				timer = -1;
				world.gui.puaseButton.visible = true;
				setPanel("The walking character on your screen is one of the 3 characters.\n\nTo switch to another character press on one of the 3 buttons in the top-left corner of your screen.");
				world.gui.b1.visible = true;
				world.gui.b2.visible = true;
				world.gui.b3.visible = true;
			}
			else if (state == tutorial_begin + 3)
			{
				removePanel();
				world.gui.b1.visible = true;
				world.gui.b2.visible = true;
				world.gui.b3.visible = true;
				world.gui.b1.enabled = true;
				world.gui.b2.enabled = true;
				world.gui.b3.enabled = true;
			}
			else if (state == tutorial_begin + 4)
			{
				setPanel("Well done!");
			}
			else if (state == tutorial_jumper + 0)
			{
				world.playerHolder.switchAvatar(0);
				world.gui.b1.visible = true;
				setPanel("This is the jump character.\n\nYou can jump by tapping on the screen.");
			}
			else if (state == tutorial_jumper + 1)
			{
				removePanel();
				world.inputEnabled = true;
			}
			else if (state == tutorial_jumper + 2)
			{
				world.inputEnabled = false;
				(world.player as EntityPlayer03).canjump = false;
				setPanel("Well done!\n\n");
			}
		}
		
		public function setPanel(text:String):void
		{
			if (panel != null)
			{
				panelHolder.removeChild(panel);
				panel = null;
			}
			panel = new TutorialPanel(text);
			panelHolder.addChild(panel);
			panelActive = true;
		}
		
		public function removePanel():void
		{
			panelHolder.removeChild(panel);
			panel = null;
			panelActive = false;
		}
		
		override public function onButtonPress(buttonID:int):void
		{
			if (tutorialState == tutorial_begin + 3 && (buttonID == world.gui.b1.buttonID || buttonID == world.gui.b3.buttonID))
			{
				if (timer < 0)
				{
					timer = 4;
				}
			}
		}
		
		override public function onClick(type:int, data:Vector.<Number>):void
		{
			if (type == TouchType.CLICK && panelActive)
			{
				setState(tutorialState + 1);
			}
			
			if (tutorialState == tutorial_jumper + 1)
			{
				if (timer < 0)
				{
					timer = 4;
				}
			}
		}
		
		public function timerEnded():void
		{
			if (tutorialState == tutorial_begin + 3)
			{
				world.gui.b1.visible = false;
				world.gui.b2.visible = false;
				world.gui.b3.visible = false;
				world.gui.b1.enabled = false;
				world.gui.b2.enabled = false;
				world.gui.b3.enabled = false;
				setState(tutorial_begin + 4);
			}
			else if (tutorialState == tutorial_jumper + 1)
			{
				setState(tutorial_jumper + 2);
			}
		}
		
		public function onButtonFlash():void
		{
			if (tutorialState == tutorial_begin + 1)
			{
				world.gui.puaseButton.visible = !world.gui.puaseButton.visible;
			}
			if (tutorialState == tutorial_begin + 2)
			{
				world.gui.b1.visible = !world.gui.b1.visible;
				world.gui.b2.visible = !world.gui.b2.visible;
				world.gui.b3.visible = !world.gui.b3.visible;
			}
		}
		
		override public function tick():void
		{
			buttonFlash--;
			if (buttonFlash < 0)
			{
				buttonFlash = 20;
				onButtonFlash();
			}
			
			if (timer > 0)
			{
				timer -= TimeHelper.deltaTime;
				if (timer < 0)
				{
					timerEnded();
				}
			}
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