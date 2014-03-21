package myth.editor 
{
	import myth.background.Background;
	import myth.editor.component.Scroll;
	import myth.editor.field.FieldBackground;
	import myth.editor.field.FieldEnemies;
	import myth.editor.field.FieldObjects;
	import myth.editor.field.FieldTiles;
	import myth.gui.components.GuiText;
	import myth.gui.game.GuiEditor;
	import myth.gui.game.GuiMainMenu;
	import starling.display.Image;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import myth.util.ScaleHelper;
	import com.adobe.serialization.json.JSON;
	
	public class Editor extends Sprite
	{		
		public static var camX:Number;
		public static var maxX:Number;
		
		public var guiEditor:GuiEditor;
		
		public var SCROLL:Scroll;
		
		public var FIELD_BACKGROUND:FieldBackground;
		public var FIELD_TILES:FieldTiles;
		public var FIELD_OBJECTS:FieldObjects;
		public var FIELD_ENEMIES:FieldEnemies;

		public function Editor(gui:GuiEditor) 
		{
			guiEditor = gui;
		}	
		
		public function init():void
		{
			SCROLL = new Scroll();
			addChild(SCROLL);
			
			var a1:Image = new Image(TextureList.assets.getTexture("editor_panel_main"));
			a1.x = 1280 - 350;
			addChild(a1);
		}
		
		public function build():void
		{
			var levelSize:int = 30;
			
			camX = 0;
			maxX = levelSize * 127 - 1000;
			
			FIELD_BACKGROUND = new FieldBackground();
			FIELD_TILES = new FieldTiles();
			FIELD_OBJECTS = new FieldObjects();
			FIELD_ENEMIES = new FieldEnemies();
			
			addChildAt(FIELD_BACKGROUND, 0);
			addChildAt(FIELD_TILES, 1);
			addChildAt(FIELD_OBJECTS, 2);
			addChildAt(FIELD_ENEMIES, 3);
			
			FIELD_BACKGROUND.buildNew(levelSize * 127, 0);
			FIELD_TILES.buildNew(levelSize, 0);
			FIELD_OBJECTS.buildNew();
			FIELD_ENEMIES.buildNew();
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{ 
			if (type == TouchType.SWIPE || type == TouchType.CLICK)
			{
				if (data[0] < 930 && data[1] < 728) //FIELDS
				{
					if (type == TouchType.SWIPE)
					{
						SCROLL.scroll(data[2]);
					}
				}
				else if(data[0] > 930) //MENU
				{
					
				}
			}
		}
		
		public function tick():void
		{
			SCROLL.tick();
			
			FIELD_TILES.tick(camX);
			FIELD_BACKGROUND.tick(camX);
		}
		
		public function action(id:int):void
		{
			if (id == 10) //NEW
			{
				removeChild(FIELD_BACKGROUND);
				removeChild(FIELD_TILES);
				removeChild(FIELD_OBJECTS);
				removeChild(FIELD_ENEMIES);
				
				build();
			}
			else if (id == 11) //MENU
			{
				guiEditor.main.switchGui(new GuiMainMenu());
			}
			else if (id == 12) //LOAD
			{
				removeChild(FIELD_BACKGROUND);
				removeChild(FIELD_TILES);
				removeChild(FIELD_OBJECTS);
				removeChild(FIELD_ENEMIES);
				
				build();
			}
			else if (id == 13) //SAVE
			{
				save();
			}
			else if (id == 14) //SETTINGS
			{
				
			}
			else if (id == 15) //TEST
			{
				
			}
			else if (id == 20) //CAT LEFT
			{
				
			}
			else if (id == 21) //CAT RIGHT
			{
				
			}
			else if (id == 22) //ITEM LEFT
			{
				
			}
			else if (id == 23) //ITEM RIGHT
			{
				
			}
		}
		
		public function save(name:String = "test", speed:int = 4):void
		{
			//SAVE FILE
			var saveFile:Object = new Object();
			
			//MAIN SETTINGS
			saveFile.name = name;
			saveFile.next_level_name = "editor";
			saveFile.id = 0;
			saveFile.speed = speed;
			
			//ENEMIES
			saveFile.enemies = new Array();
			for (var i:int = 0; i < 5; i++ )
			{
				var en:Object = new Object();
				en.type = 0;
				en.spawnX = i * 100;
				en.spawnY = i * 200;
				saveFile.enemies.push(en);
			}
			
			//BACKGROUND
			saveFile.background_props = new Array();
			for (var j:int = 0; j < 5; j++ )
			{
				var bg:Object = new Object();
				bg.type = 0;
				bg.depth = 1;
				bg.x = 0;
				bg.y = 0;
				saveFile.background_props.push(bg);
			}
			
			//OBJECTS
			saveFile.objects = new Array();
			for (var k:int = 0; k < 5; k++ )
			{
				var obj:Object = new Object();
				obj.type = 0;
				obj.x = 100;
				obj.y = 200;
				saveFile.objects.push(obj);
			}
			
			//TILES
			saveFile.tiles = new Array();
			for (var l:int = 0; l < 5; l++ )
			{
				var ti:Object = new Object();
				ti.type = 0;
				saveFile.tiles.push(ti);
			}

			trace(com.adobe.serialization.json.JSON.encode(saveFile));
		}
		
		public function load():void
		{
			
		}
	}
}