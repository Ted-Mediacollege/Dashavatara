package myth.world 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myth.entity.enemy.EntityEnemyBase;
	import myth.entity.player.EntityPlayer03;
	import myth.entity.player.EntityPlayer01v2;
	import myth.entity.player.EntityPlayer01v4;
	import myth.entity.player.EntityPlayer02v2;
	import myth.gamemode.GameMode;
	import myth.gamemode.GameModeEditor;
	import myth.gui.game.GuiEditor;
	import myth.gui.game.GuiGame;
	import myth.gui.game.GuiLose;
	import myth.gui.game.GuiWin;
	import myth.gui.GuiScreen;
	import myth.world.physicsWorld.PhysicsWorld;
	import myth.world.WorldEntityManager;
	import myth.entity.player.EntityPlayer01;
	import myth.entity.player.EntityPlayerBoar;
	import myth.entity.player.EntityPlayerBase;
	import myth.gui.components.GuiButton;
	import myth.Main;
	import myth.world.worldZones.WorldZoneManager;
	import starling.animation.Juggler;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Shape;
	import starling.display.Sprite;
	import myth.graphics.AssetList;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import myth.util.TimeHelper;
	import myth.util.ScaleHelper;
	import myth.input.TouchType;
	import nape.util.Debug;
	import starling.events.TouchPhase;
	import starling.core.Starling;
	import myth.entity.player.PlayerType;
	import myth.entity.objects.ObjectType;
	import treefortress.spriter.SpriterClip;
	import starling.core.Starling;
	import flash.display.Loader;
	import myth.data.LevelData;
	import myth.graphics.Display;
	import myth.graphics.LayerID;
	
	public class World
	{
		public var gamemode:GameMode;
		
		private var worldBuild:Boolean;
		public var gui:GuiGame;
		
		public var tiles:WorldTiles;
		public var background:WorldBackground;
		
		public var distance:Number = 0;
		public var speed:Number;
		public var deltaSpeed:Number;
		public var endPointPosition:Number;
		private var levelComplete:Boolean = false;
		
		public var entityManager:WorldEntityManager;
		public var objectManager:WorldObjectManager;
		public var zoneManager:WorldZoneManager;
		public var playerHolder:PlayerHolder;
		
		private var debugShape:Shape = new Shape();
		public var debugShape2:Shape = new Shape();
		public var attackShape:Shape = new Shape();
		
		public var physicsWorld:PhysicsWorld;
		
		public var gameJuggler:Juggler;
		
		public var player:EntityPlayerBase;
		
		public var backgroundBatch:QuadBatch = new QuadBatch;
		
		public function World(g:GuiGame, gm:GameMode) 
		{
			gamemode = gm;
			gamemode.preInit(this);
			
			gameJuggler = new Juggler();
			EntityPlayerBase.levelStart();
			gui = g;
		}
		
		public function init():void {
			gamemode.init();
		}
		
		public function build():void {
			gamemode.build();
			gui.build();
			
			Display.add(background,LayerID.GameLevelBack);
			Display.add(entityManager,LayerID.GamePlayer);
			Display.add(objectManager,LayerID.GamePlayerFront);
			Display.add(tiles,LayerID.GameLevel2);
			Display.add(debugShape,LayerID.DebugLayer);
			Display.add(debugShape2,LayerID.DebugLayer);
			Display.add(attackShape,LayerID.DebugLayer);
			
			worldBuild = true;
		}
		
		public function onRemove():void {
			AssetList.soundLevel.stopAllSounds();
			myth.util.Debug.test(function():void { 
				Starling.current.nativeOverlay.removeChild(physicsWorld.shape);
			}, myth.util.Debug.DrawArracks);
		}
		
		public function tick():void
		{
			gamemode.tick();
			
			if (worldBuild) {
				gameJuggler.advanceTime(TimeHelper.deltaTime);
				
				if(!levelComplete){
					if (distance > endPointPosition-500) {
						player.levelDone();
					}else {
						deltaSpeed = speed*TimeHelper.deltaTimeScale;
						distance += deltaSpeed;
					}
				}
				
				physicsWorld.tick();
				zoneManager.tick();
				player.tick();
				playerHolder.tick();
				
				tiles.tick(distance);
				background.tick(distance);
				entityManager.tick(deltaSpeed,distance);
				objectManager.tick(deltaSpeed, distance);
				
				if (player.x < -200) {
					gamemode.onDeath();
				}else if (player.x > 1480 || levelComplete) {
					gamemode.onWin();
				}
			}
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void
		{	
			player.input(type, data, e);
			
			var touchCount:int =  e.touches.length;
			//draw point
			myth.util.Debug.test(function():void { 
				debugShape.graphics.clear();
				debugShape.graphics.beginFill(0x000000, 0.2);
				debugShape.graphics.lineStyle(2, 0x00ff00, 0.7);
				debugShape.graphics.drawCircle(e.touches[0].getLocation(Main.gui).x,e.touches[0].getLocation(Main.gui).y,20);
				debugShape.graphics.endFill();
			}, myth.util.Debug.DrawArracks);
		}
	}
}