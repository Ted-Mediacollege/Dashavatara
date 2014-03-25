package myth.world 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myth.entity.enemy.EntityEnemyBase;
	import myth.entity.player.EntityPlayer03;
	import myth.entity.player.EntityPlayer01v2;
	import myth.entity.player.EntityPlayer01v4;
	import myth.entity.player.EntityPlayer02v2;
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
	import starling.display.Shape;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
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
		private var lvlName:String;
		
		private var worldBuild:Boolean;
		public var gui:GuiGame;
		
		public var tiles:WorldTiles2;
		public var background:WorldBackground;
		
		public var players:Vector.<EntityPlayerBase> = new Vector.<EntityPlayerBase>;
		public var player:EntityPlayerBase;
		private var currentPlayer:int = 1;
		
		public var distance:Number = 0;
		public var speed:Number;
		public var deltaSpeed:Number;
		public var endPointPosition:Number;
		private var levelComplete:Boolean = false;
		
		public var entityManager:WorldEntityManager;
		public var objectManager:WorldObjectManager;
		private var zoneManager:WorldZoneManager;
		
		private var debugShape:Shape = new Shape();
		public var debugShape2:Shape = new Shape();
		public var attackShape:Shape = new Shape();
		
		public var physicsWorld:PhysicsWorld;
		
		private var animTransform:SpriterClip;
		private var transformCircle:Image;
		
		public var levelData:LevelData;
		public var gameJuggler:Juggler;
		
		public function World(g:GuiGame ,levelName:String = "level_1", _editorTesting:Boolean = false, _editorString:String = null) 
		{
			gameJuggler = new Juggler();
			EntityPlayerBase.levelStart();
			gui = g;
			lvlName = levelName;
			levelData = new LevelData();
			if (_editorTesting) {
				levelData.loadFromString(_editorString, levelName);
			}
			else {
				levelData.loadFile(levelName);
			}
			speed = levelData.startSpeed;
			endPointPosition = levelData.endPointPosition;
		}
		
		public function init():void {
			TextureList.loadLevelAssets(0,PlayerType.Fish,PlayerType.Fluit,PlayerType.Lion);
		}
		
		public function build():void {
			physicsWorld = new PhysicsWorld();
			
			//player
			players[0] = new EntityPlayer03(); 
			//players[1] = new EntityPlayer01v2(); 
			players[1] = new EntityPlayer01v4();
			//players[2] = new EntityPlayer02v2(); 
			players[2] = new EntityPlayerBoar(); 
			 
			player = players[1];
			currentPlayer = 1;
			physicsWorld.playerBody.userData.graphic = player;
			
			gui.build();
			//entityManager
			entityManager = new WorldEntityManager(levelData.enemyData);
			//tiles
			tiles = new WorldTiles2();
			tiles.build(0, levelData.tileData, levelData.theme);
			//background asser manager
			//backgroundAssetData
			background = new WorldBackground(levelData.backgroundAssetData, levelData.levelLength * 127, levelData.theme); //MOET ACHTER TILES GELADEN WORDEN
			
			//object manager
			objectManager = new WorldObjectManager(levelData.ObjectData);
			//zoneManager
			zoneManager = new WorldZoneManager(levelData.zoneData);
			
			//add childs
			Display.add(background,LayerID.GameLevelBack);
			
			transformCircle = new Image(TextureList.assets.getTexture("common_tadaa"));
			transformCircle.pivotX = 102;
			transformCircle.pivotY = 100;
			Display.add(transformCircle,LayerID.GamePlayerBack);
			
			Display.add(player,LayerID.GamePlayer);
			Display.add(entityManager,LayerID.GamePlayer);
			Display.add(objectManager,LayerID.GamePlayerFront);
			Display.add(tiles,LayerID.GameLevel2);
			//debug
			Display.add(debugShape,LayerID.DebugLayer);
			Display.add(debugShape2,LayerID.DebugLayer);
			Display.add(attackShape,LayerID.DebugLayer);
						
			animTransform = TextureList.spriterLoader.getSpriterClip("transAnim");
			animTransform.playbackSpeed = 1.5;
			Display.add(animTransform,LayerID.GamePlayerFront);
			gameJuggler.add(animTransform);
			animTransform.visible = false;
			
			animTransform.animationComplete.add(
				function(clip:SpriterClip):void
				{
					animTransform.visible = false;
					animTransform.stop();
					transformCircle.visible = false;
				}
			);
			
			worldBuild = true;
		}
		
		public function onRemove():void {
			myth.util.Debug.test(function():void { 
				Starling.current.nativeOverlay.removeChild(physicsWorld.shape);
			}, myth.util.Debug.DrawArracks);
		}
		
		
		
		//LOOP
		private var sps:Boolean = true;
		public function tick():void
		{
			
			gameJuggler.advanceTime(TimeHelper.deltaTime);
			if (worldBuild) {
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
				
				tiles.tick(distance);
				background.tick(distance);
				entityManager.tick(deltaSpeed,distance);
				objectManager.tick(deltaSpeed,distance);
				///trace("damage "+damage);
				//player1.x += speed;
				//trace("distance: "+ distance+" DetaTime: " +  TimeHelper.deltatime);
				
				if (player.x < -200)
				{
					if (levelData.nextLvlName == "editor") {
						gui.main.switchGui(new GuiEditor(GuiGame.editorString));
					} else {
						gui.main.switchGui(new GuiLose(lvlName));
					}
				}else if (player.x > 1480 || levelComplete) {
					if (levelData.nextLvlName == "editor") {
						gui.main.switchGui(new GuiEditor(GuiGame.editorString));
					} else {
						gui.main.switchGui(new GuiWin(lvlName,levelData.nextLvlName));
					}
				}
				
				animTransform.x = player.x;
				animTransform.y = player.y;
				transformCircle.x = player.x;
				transformCircle.y = player.y - 90;
				transformCircle.rotation += 2;
			}
		}
		
		public function switchAvatar(id:int):void {
			if(id !=currentPlayer){
				var playerPosX:int = player.x;
				var playerPosY:int = player.y;
				player.removeFromParent();
				if (id==0) {
					player = players[0];
					currentPlayer = 0;
				}else if (id==1) {
					player = players[1];
					currentPlayer = 1;
				}else {
					player = players[2];
					currentPlayer = 2;
				}
				trace("switch "+currentPlayer+" "+distance);
				player.x = playerPosX;
				player.y = playerPosY;
				Display.add(player, LayerID.GamePlayer);
				physicsWorld.playerBody.userData.graphic = player;
				
				animTransform.play("lotusflower");
				animTransform.visible = true;
				transformCircle.visible = true;
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