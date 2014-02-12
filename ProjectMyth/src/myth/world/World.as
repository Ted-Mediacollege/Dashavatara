package myth.world 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
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
		public var main:Main;
		
		//[Embed(source = "../../../lib/XMLData/levels.xml" , mimeType="application/octet-stream")]
		[Embed(source="../../../lib/XMLData/levels.xml" , mimeType="application/octet-stream")]
		private var levelData:Class;
		
		[Embed(source = "../../../lib/JSONData/levels.json", mimeType = "application/octet-stream")]
		private var levelData2:Class;
		
		private var jsonLevel:Object;
		private var json:URLLoader;
		private var lvlName:String;
		private var enemyData:Vector.<Vector.<int>>;
		
		private var player1:EntityPlayerBase;
		private var distance:Number = 0;
		private var speed:Number = 0.2;
		private var enemyManager:WorldEntityManager;
		
		private var debugShape:Shape = new Shape();
		private var touchZone:Shape = new Shape();
		
		public function World(m:Main ,levelName:String = "level_1") 
		{
			main = m;
			
			lvlName = levelName;
			loadJSON();
			loadXML();
			speed = speed * 60;
			//player
			player1 = new EntityPlayer01();
			player1.x = 100;
			player1.y = 600;
			addChild(player1);
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
			//enemyData = 
			
		}
		
		private function loadXML():void {
			var xml:ByteArray = new levelData();
			var xmlString:String = xml.readUTFBytes(xml.length);
			var levelsXML:XML = new XML(xmlString);
			if (levelsXML){
				var levelData:XML;
				for each (var level:XML in levelsXML.Level){
					if (level.attribute("name") == lvlName) {
						levelData=level;
					}
				}
				var levelNameDisplay:TextField = new TextField(200, 200, "xml: "+levelData.attribute("name"),"Verdana", 20, 0xffffff);
				addChild(levelNameDisplay);
			}
		}
		
		//INIT
		public function build(levelsXML:XML):void
		{
			
		}
		
		//LOOP
		public function tick():void
		{
			distance += speed;
			enemyManager.move(speed,distance);
			var damage:int = enemyManager.checkHit(player1.x, player1.y);
			///trace("damage "+damage);
			//player1.x += speed;
			//trace("distance: "+ distance+" DetaTime: " +  TimeHelper.deltatime);
		}
		
		public function touch(t:TouchEvent):void {
			var touchCount:int =  t.touches.length;
			//draw point
			Debug.test(function():void { 
				debugShape.graphics.clear();
				debugShape.graphics.beginFill(0x000000, 0.2);
				debugShape.graphics.lineStyle(2, 0x00ff00, 0.7);
				debugShape.graphics.drawCircle(t.touches[0].getLocation(Main.world).x,t.touches[0].getLocation(Main.world).y,5);
				debugShape.graphics.endFill();
			}, Debug.DrawArracks);
			for (var i:int = 0; i < touchCount; i++) 
			{
				if (t.touches[i].phase == TouchPhase.BEGAN) {
					//trace("b");
				}
			}
		}
		
		public function input(type:int, data:Vector.<Number>):void
		{	
			trace("touch");
			if (type == TouchType.CLICK)
			{
				//data vector = startX, startY, endX, endY
			}
			else if (type == TouchType.SWIPE)
			{
				//data vector = posX, posY, movedX, movedY
				trace("swipe  posX" + data[0] + " posY" + data[1] + " - moveX" + data[2] + " moveY" + data[3]);
			}
			else if (type == TouchType.ZOOM)
			{
				//data vector = zoom
			}
		}
	}
}