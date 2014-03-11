package myth.world 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import myth.entity.enemy.EntityEnemyBase;
	import myth.entity.player.EntityPlayer03;
	import myth.entity.player.EntityPlayer01v2;
	import myth.entity.player.EntityPlayer01v3;
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
	
	public class World extends Sprite
	{
		private var worldBuild:Boolean;
		public var gui:GuiScreen;
		
		public var tiles:WorldTiles2;
		public var background:WorldBackground;
		
		[Embed(source = "../../../lib/JSONData/levels.json", mimeType = "application/octet-stream")]
		private var levelData2:Class;
		
		private var jsonLevel:Object;
		private var lvlName:String;
		private var nextLvlName:String;
		private var enemyData:Vector.<Vector.<int>>;
		private var tileData:Vector.<int>;
		private var backgroundAssetData:Vector.<Vector.<int>>;
		private var ObjectData:Vector.<Vector.<int>>;
		
		public var playerBody:Body;
		private var players:Vector.<EntityPlayerBase> = new Vector.<EntityPlayerBase>;
		public var player:EntityPlayerBase;
		
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
		
		public var physicsSpace:Space;
		public var debug:Debug;
		private var shape:flash.display.Sprite;
		
		public function World(g:GuiScreen ,levelName:String = "level_1") 
		{
			EntityPlayerBase.levelStart();
			gui = g;
			lvlName = levelName;
			loadJSON();
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
			players[1] = new EntityPlayer01v2(); 
			//players[2] = new EntityPlayer02v2(); 
			players[2] = new EntityPlayer01v3(); 
			player = players[1];
			playerBody.userData.graphic = player;
			//player.x = 200;
			//player.y = 640;
			//entityManager
			entityManager = new WorldEntityManager(enemyData);
			//tiles
			tiles = new WorldTiles2();
			tiles.build(0, tileData);
			//background asser manager
			//backgroundAssetData
			background = new WorldBackground(tileData.length); //MOET ACHTER TILES GELADEN WORDEN
			
			//object manager
			objectManager = new WorldObjectManager(ObjectData);
			
			//add childs
			addChild(background);
			addChild(player);
			addChild(entityManager);
			addChild(objectManager);
			addChild(tiles);
			//debug
			addChild(debugShape);
			addChild(debugShape2);
			
			worldBuild = true;
		}
		
		public function onRemove():void {
			myth.util.Debug.test(function():void { 
				Starling.current.nativeOverlay.removeChild(shape);
			}, myth.util.Debug.DrawArracks);
		}
		
		private function loadJSON():void {
			var i:int;
			var json:ByteArray = new levelData2();
			var jsonString:String = json.readUTFBytes(json.length);
			jsonLevel = JSON.parse(jsonString);
			var levelData:Object;
			for each (var level:Object in jsonLevel.levels) {
				if (level.name == lvlName) {
					levelData = level;
				}
			}
			var levelNameDisplay:TextField = new TextField(200, 400, "json: " + levelData.name, "Verdana", 20, 0xffffff);
			addChild(levelNameDisplay);
			//set end point position
			for (i = 0; i < levelData.objects.length; i++) 
			{
				if(levelData.objects[i].type == ObjectType.endPort1){
					endPointPosition = levelData.objects[i].x;
				}
			}
			//set level speed
			speed = levelData.speed;
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
					gui.main.switchGui(new GuiWin(lvlName,nextLvlName));
				}
				//physicsSpace.bodies.foreach( move );
				moveGraphics();
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
		
		private var currentPlayer:int = 1;
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
				addChild(player);
				playerBody.userData.graphic = player;
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