package myth.world 
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	import myth.entity.enemy.EntityEnemyBase;
	import myth.entity.player.EntityPlayerTest;
	import myth.entity.player.EntityPlayerTest2;
	import myth.gui.game.GuiLose;
	import myth.gui.GuiScreen;
	import myth.world.WorldEntityManager;
	import myth.entity.player.EntityPlayer01;
	import myth.entity.player.EntityPlayerBase;
	import myth.gui.components.GuiButton;
	import myth.Main;
	import starling.display.Shape;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import myth.util.TimeHelper;
	import myth.util.ScaleHelper;
	import myth.input.TouchType;
	import myth.util.Debug;
	import starling.events.TouchPhase;
	
	public class World extends Sprite
	{
		public var gui:GuiScreen;
		
		public var tiles:WorldTiles2;
		public var background:WorldBackground;
		
		[Embed(source = "../../../lib/JSONData/levels.json", mimeType = "application/octet-stream")]
		private var levelData2:Class;
		
		private var jsonLevel:Object;
		private var lvlName:String;
		private var enemyData:Vector.<Vector.<int>>;
		private var tileData:Vector.<int>;
		private var backgroundAssetData:Vector.<Vector.<int>>;
		private var ObjectData:Vector.<Vector.<int>>;
		
		private var players:Vector.<EntityPlayerBase> = new Vector.<EntityPlayerBase>;
		public var player:EntityPlayerBase;
		public var distance:Number = 0;
		private var speed:Number;
		public var deltaSpeed:Number;
		public var entityManager:WorldEntityManager;
		public var objectManager:WorldObjectManager;
		
		private var debugShape:Shape = new Shape();
		public var debugShape2:Shape = new Shape();
		
		public function World(g:GuiScreen ,levelName:String = "level_1") 
		{
			gui = g;
			
			lvlName = levelName;
			loadJSON();
			//player
			players[0] = new EntityPlayerTest(); //new EntityPlayer01();
			players[1] = new EntityPlayerTest2(); //new EntityPlayer02();
			player = players[0];
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
		}
		
		public function onRemove():void {
			
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
			//set level speed
			speed = levelData.speed;
			//set enemy data in vector
			//trace(levelData.enemies.length);
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
			//tiles.build(0, tileData);
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
		public function tick():void
		{
			player.tick();
			deltaSpeed = speed*TimeHelper.deltaTimeScale;
			distance += deltaSpeed;
			tiles.tick(distance);
			background.tick(distance);
			entityManager.tick(deltaSpeed,distance);
			objectManager.tick(deltaSpeed,distance);
			///trace("damage "+damage);
			//player1.x += speed;
			//trace("distance: "+ distance+" DetaTime: " +  TimeHelper.deltatime);
			
			if (player.art.x < -200)
			{
				gui.main.switchGui(new GuiLose());
			}
		}
		
		private var currentPlayer:int = 0;
		public function switchAvatar():void {
			var playerPosX:int = player.x;
			var playerPosY:int = player.y;
			removeChild(player);
			if (currentPlayer==1) {
				player = players[0];
				currentPlayer = 0;
			}else {
				player = players[1];
				currentPlayer = 1;
			}
			trace("switch "+currentPlayer+" "+distance);
			player.x = playerPosX;
			player.y = playerPosY;
			addChild(player);
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void
		{	
			player.input(type, data, e);
			
			var touchCount:int =  e.touches.length;
			//draw point
			Debug.test(function():void { 
				debugShape.graphics.clear();
				debugShape.graphics.beginFill(0x000000, 0.2);
				debugShape.graphics.lineStyle(2, 0x00ff00, 0.7);
				debugShape.graphics.drawCircle(e.touches[0].getLocation(Main.world).x,e.touches[0].getLocation(Main.world).y,20);
				debugShape.graphics.endFill();
			}, Debug.DrawArracks);
		}
	}
}