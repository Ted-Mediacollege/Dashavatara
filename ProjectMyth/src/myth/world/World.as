package myth.world 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myth.entity.enemy.EntityEnemyBase;
	import myth.entity.player.EntityPlayer03;
	import myth.entity.player.EntityPlayer01v2;
	import myth.entity.player.EntityPlayer01v4;
	import myth.entity.player.EntityPlayer02v2;
	import myth.gui.game.GuiLose;
	import myth.gui.game.GuiWin;
	import myth.gui.GuiScreen;
	import myth.world.WorldEntityManager;
	import myth.entity.player.EntityPlayer01;
	import myth.entity.player.EntityPlayerBase;
	import myth.gui.components.GuiButton;
	import myth.Main;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import nape.util.ShapeDebug;
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
	import nape.phys.BodyType;
	import myth.entity.player.PlayerType;
	import nape.geom.Mat23;
	import myth.entity.objects.ObjectType;
	import treefortress.spriter.SpriterClip;
	import starling.core.Starling;
	import flash.display.Loader;
	import myth.data.LevelData;
	
	public class World extends Sprite
	{
		private var lvlName:String;
		
		private var worldBuild:Boolean;
		public var gui:GuiScreen;
		
		public var tiles:WorldTiles2;
		public var background:WorldBackground;
		
		public var playerBody:Body;
		private var players:Vector.<EntityPlayerBase> = new Vector.<EntityPlayerBase>;
		public var player:EntityPlayerBase;
		private var currentPlayer:int = 1;
		
		private var groundMaterial:Material;
		
		public var distance:Number = 0;
		public var speed:Number;
		public var deltaSpeed:Number;
		public var endPointPosition:Number;
		private var levelComplete:Boolean = false;
		
		public var entityManager:WorldEntityManager;
		public var objectManager:WorldObjectManager;
		
		private var debugShape:Shape = new Shape();
		public var debugShape2:Shape = new Shape();
		public var attackShape:Shape = new Shape();
		
		public var physicsSpace:Space;
		public var debug:Debug;
		private var shape:flash.display.Sprite;
		
		private var animTransform:SpriterClip;
		private var transformCircle:Image;
		
		public var levelData:LevelData;
		
		public function World(g:GuiScreen ,levelName:String = "level_1") 
		{
			EntityPlayerBase.levelStart();
			gui = g;
			lvlName = levelName;
			levelData = new LevelData(levelName);
			speed = levelData.startSpeed;
			endPointPosition = levelData.endPointPosition;
		}
		
		public function init():void {
			TextureList.loadLevelAssets(0,PlayerType.Fish,PlayerType.Fluit,PlayerType.Lion);
		}
		
		public function build():void {
			groundMaterial = new Material(0, 0, 0, 1, 0);
			//create space
			physicsSpace = new Space(new Vec2(0, 2200));
			//physicsSpace.worldLinearDrag = 0.5;
			//debug
			myth.util.Debug.test(function():void { 
				debug = new ShapeDebug(1280, 768, 0x666666);
				//debug = new BitmapDebug(1280, 768, 3355443, false);
				debug.drawShapeDetail = true;
				shape = new flash.display.Sprite();
				shape.alpha = 0.5;
				shape.scaleX = ScaleHelper.scaleX;
				shape.scaleY = ScaleHelper.scaleY;
				shape.addChild(debug.display);
				Starling.current.nativeOverlay.addChild(shape);
			}, myth.util.Debug.DrawArracks);
			
			//ground physics body
			var floor:Body = new Body(BodyType.STATIC);
			floor.shapes.add(new Polygon(Polygon.rect(0-200, 640, 1280+400 +100000, 100)));
			floor.space = physicsSpace; 
			floor.userData.Pivot = new Vec2(0, 0);
			floor.userData.name = "ground";
			floor.setShapeMaterials(groundMaterial);
			
			//player physics body
			playerBody = new Body(BodyType.DYNAMIC,new Vec2(200,200) );
			playerBody.shapes.add(new Polygon(Polygon.box(100,180)));
			playerBody.position.setxy(200,639);
			playerBody.space = physicsSpace;
			playerBody.userData.Pivot = new Vec2(0, -90);
			playerBody.userData.name = "player";
			playerBody.allowRotation = false;
			
			for (var i:int = 0; i < 0; i++) 
			{
				var cube:Body = new Body(BodyType.DYNAMIC,new Vec2(200,200) );
				cube.shapes.add(new Polygon(Polygon.box(28,28)));
				cube.position.setxy(200+Math.random(),200+Math.random());
				cube.space = physicsSpace;
			}
			
			//player
			players[0] = new EntityPlayer03(); 
			//players[1] = new EntityPlayer01v2(); 
			players[1] = new EntityPlayer01v4();
			players[2] = new EntityPlayer02v2(); 
			 
			player = players[1];
			currentPlayer = 1;
			playerBody.userData.graphic = player;
			//player.x = 200;
			//player.y = 640;
			//entityManager
			entityManager = new WorldEntityManager(levelData.enemyData);
			//tiles
			tiles = new WorldTiles2();
			tiles.build(0, levelData.tileData);
			//background asser manager
			//backgroundAssetData
			background = new WorldBackground(levelData.tileData.length); //MOET ACHTER TILES GELADEN WORDEN
			
			//object manager
			objectManager = new WorldObjectManager(levelData.ObjectData);
			
			//add childs
			addChild(background);
			
			transformCircle = new Image(TextureList.assets.getTexture("common_tadaa"));
			transformCircle.pivotX = 102;
			transformCircle.pivotY = 100;
			addChild(transformCircle);
			
			addChild(player);
			addChild(entityManager);
			addChild(objectManager);
			addChild(tiles);
			//debug
			addChild(debugShape);
			addChild(debugShape2);
			addChild(attackShape);
						
			animTransform = TextureList.spriterLoader.getSpriterClip("transAnim");
			animTransform.playbackSpeed = 1.5;
			addChild(animTransform);
			Starling.juggler.add(animTransform);
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
				Starling.current.nativeOverlay.removeChild(shape);
			}, myth.util.Debug.DrawArracks);
		}
		
		
		
		//LOOP
		private var sps:Boolean = true;
		public function tick():void
		{
			
			/*
			if(sps){
				speed -= 0.05;
				if (speed < -1) {
					sps = false;
				}
			}else {
				speed += 0.1;
				if (speed > 6) {
					sps = true;
				}
			}
			trace(speed);*/
			if (worldBuild) {
				if(!levelComplete){
					if (distance > endPointPosition-500) {
						player.levelDone();
					}else {
						deltaSpeed = speed*TimeHelper.deltaTimeScale;
						distance += deltaSpeed;
					}
				}
				
				physicsSpace.step(TimeHelper.deltaTime);
				
				myth.util.Debug.test(function():void {
					var debugMatrix:Mat23 = new Mat23();
					debugMatrix.tx = -distance;
					debug.transform = debugMatrix;
					debug.clear();
					debug.draw(physicsSpace);
					debug.flush();
				}, myth.util.Debug.DrawArracks);
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
					gui.main.switchGui(new GuiLose(lvlName));
				}else if(player.x > 1480 || levelComplete) {
					gui.main.switchGui(new GuiWin(lvlName,levelData.nextLvlName));
				}
				//physicsSpace.bodies.foreach( move );
				moveGraphics();
				
				animTransform.x = player.x;
				animTransform.y = player.y;
				transformCircle.x = player.x;
				transformCircle.y = player.y - 90;
				transformCircle.rotation += 2;
			}
		}
		private var graphic:Sprite;
		private function moveGraphics():void 
		{
			for (var i:int = 0; i < physicsSpace.bodies.length; i++) 
			{
				var body:Body = physicsSpace.bodies.at(i);
				graphic = body.userData.graphic;
				if(body.userData.Pivot!=null && graphic!=null){
					graphic.x = body.position.x - body.userData.Pivot.x - distance;
					graphic.y = body.position.y - body.userData.Pivot.y ;
					graphic.rotation = body.rotation;
				}
			}
		}
		
		
		public function switchAvatar(id:int):void {
			if(id !=currentPlayer){
				var playerPosX:int = player.x;
				var playerPosY:int = player.y;
				removeChild(player);
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
				addChildAt(player, getChildIndex(animTransform));
				playerBody.userData.graphic = player;
				
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
				debugShape.graphics.drawCircle(e.touches[0].getLocation(Main.world).x,e.touches[0].getLocation(Main.world).y,20);
				debugShape.graphics.endFill();
			}, myth.util.Debug.DrawArracks);
		}
	}
}