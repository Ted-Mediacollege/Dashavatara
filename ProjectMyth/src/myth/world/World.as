package myth.world 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import myth.gui.components.GuiButton;
	import myth.Main;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	import starling.text.TextField;
	import myth.util.TimeHelper;
	
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
		
		public function World(m:Main ,levelName:String = "level_1") 
		{
			lvlName = levelName;
			loadJSON();
			loadXML();
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
			trace(TimeHelper.deltatime);
		}
	}
}