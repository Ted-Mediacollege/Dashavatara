package myth.world 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import myth.entity.enemy.EntityEnemyBase;
	import myth.entity.player.EntityPlayer02;
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
		
		[Embed(source = "../../../lib/JSONData/levels.json", mimeType = "application/octet-stream")]
		private var levelData2:Class;
		
		private var jsonLevel:Object;
		private var lvlName:String;
		private var enemyData:Vector.<Vector.<int>>;
		
		private var players:Vector.<EntityPlayerBase> = new Vector.<EntityPlayerBase>;
		private var player:EntityPlayerBase;
		private var distance:Number = 0;
		private var speed:Number = 0.2;
		private var enemyManager:WorldEntityManager;
		
		private var debugShape:Shape = new Shape();
		public var debugShape2:Shape = new Shape();
		public var touchZone:Shape = new Shape();
		
		public function World(g:GuiScreen ,levelName:String = "level_1") 
		{
			gui = g;
			
			lvlName = levelName;
			loadJSON();
			speed = speed * 60;
			//player
			players[0] = new EntityPlayer01();
			players[1] = new EntityPlayer02();
			player = players[0];
			player.x = 100;
			player.y = 600;
			addChild(player);
			//enemies
			enemyManager = new WorldEntityManager(enemyData);
			addChild(enemyManager);
			//debug
			addChild(debugShape);
			
			//touch
			addEventListener(TouchEvent.TOUCH,touch);
			touchZone.graphics.clear();
			touchZone.graphics.lineStyle(5, 0x00ff00, 0.7);
			touchZone.graphics.drawRect(0,0,ScaleHelper.screenX,ScaleHelper.screenY);
			touchZone.graphics.endFill();
			addChild(touchZone);
			
			touchZone.graphics.lineStyle(5, 0x00ff00, 0.7);
			touchZone.graphics.drawRect(0, 0, 600, 600);
			touchZone.graphics.endFill();
			//addChild(debugShape2);
		}
		
		public function onRemove():void {
			removeEventListener(TouchEvent.TOUCH,touch);
		}
		
		private function loadJSON():void {
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
			//set enemy data in array
			trace(levelData.enemies.length);
			enemyData = new Vector.<Vector.<int>>(levelData.enemies.length);
			for (var i:int = 0; i < levelData.enemies.length; i++) 
			{
				enemyData[i] = new <int>[ levelData.enemies[i].type, levelData.enemies[i].spawnX, levelData.enemies[i].spawnY ]
			}
		}
		
		//LOOP
		public function tick():void
		{
			distance += speed;
			enemyManager.move(speed,distance);
			var damage:int = enemyManager.checkHit(player.x, player.y);
			///trace("damage "+damage);
			//player1.x += speed;
			//trace("distance: "+ distance+" DetaTime: " +  TimeHelper.deltatime);
		}
		
		public function touch(e:TouchEvent):void {
			var touchCount:int =  e.touches.length;
			//draw point
			Debug.test(function():void { 
				debugShape.graphics.clear();
				debugShape.graphics.beginFill(0x000000, 0.2);
				debugShape.graphics.lineStyle(2, 0x00ff00, 0.7);
				debugShape.graphics.drawCircle(e.touches[0].getLocation(Main.world).x,e.touches[0].getLocation(Main.world).y,20);
				debugShape.graphics.endFill();
			}, Debug.DrawArracks);
			for (var i:int = 0; i < touchCount; i++) 
			{
				if (e.touches[i].phase == TouchPhase.BEGAN) {
					//trace("b");
				}
			}
		}
		
		private var currentPlayer:int = 0;
		private function switchAvatar():void {
			removeChild(player);
			if (currentPlayer==1) {
				player = players[0];
				currentPlayer = 0;
			}else {
				player = players[1];
				currentPlayer = 1;
			}
			trace("switch "+currentPlayer+" "+distance);
			player.x = 100;
			player.y = 600;
			addChild(player);
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void
		{	
			//trace("touch");
			player.input(type, data, e);
			if (type == TouchType.CLICK)
			{
				//switchAvatar();
				//data vector = startX, startY, endX, endY
			}
			else if (type == TouchType.SWIPE)
			{
				//data vector = posX, posY, movedX, movedY
				//trace("swipe  posX" + data[0] + " posY" + data[1] + " - moveX" + data[2] + " moveY" + data[3]);
			}
			else if (type == TouchType.ZOOM)
			{
				//data vector = zoom
			}
		}
	}
}