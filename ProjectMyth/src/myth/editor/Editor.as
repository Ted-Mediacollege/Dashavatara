package myth.editor 
{
	import myth.background.Background;
	import myth.data.Theme;
	import myth.editor.component.Constructor;
	import myth.editor.component.Scroll;
	import myth.editor.component.Selector;
	import myth.editor.field.FieldBackground;
	import myth.editor.field.FieldEnemies;
	import myth.editor.field.FieldObjects;
	import myth.editor.field.FieldTiles;
	import myth.gui.components.GuiText;
	import myth.gui.game.GuiEditor;
	import myth.gui.game.GuiGame;
	import myth.gui.game.GuiMainMenu;
	import starling.display.Image;
	import starling.display.Sprite;
	import myth.graphics.TextureList;
	import starling.events.TouchEvent;
	import myth.input.TouchType;
	import myth.util.ScaleHelper;
	import com.adobe.serialization.json.JSON;
	import myth.util.MathHelper;
	
	public class Editor extends Sprite
	{		
		public static var theme:int;
		
		public static var camX:Number;
		public static var maxX:Number;
		
		public var guiEditor:GuiEditor;
		
		public var SCROLL:Scroll;
		public var SELECTOR:Selector;
		public var CONSTRUCTOR:Constructor;
		
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
			theme = Theme.SKY;
			var levelSize:int = 50;
			
			SELECTOR = new Selector();
			addChild(SELECTOR);
			SELECTOR.build(theme);
			
			camX = 0;
			maxX = levelSize * 127 - 1000;
			
			FIELD_BACKGROUND = new FieldBackground();
			FIELD_TILES = new FieldTiles();
			FIELD_OBJECTS = new FieldObjects();
			FIELD_ENEMIES = new FieldEnemies();
			
			addChildAt(FIELD_BACKGROUND, 0);
			addChildAt(FIELD_OBJECTS, 1);
			addChildAt(FIELD_TILES, 2);
			addChildAt(FIELD_ENEMIES, 3);
			
			FIELD_BACKGROUND.buildNew(levelSize * 127, theme);
			FIELD_TILES.buildNew(levelSize, theme);
			FIELD_OBJECTS.buildNew();
			FIELD_ENEMIES.buildNew();
			
			CONSTRUCTOR = new Constructor();
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{ 
			if (type == TouchType.SWIPE || type == TouchType.CLICK || type == TouchType.SWIPE_START)
			{
				if (data[0] < 930 && data[1] < 728) //FIELDS
				{
					if (type == TouchType.CLICK)
					{
						if (MathHelper.dis2(data[0], data[1], data[2], data[3]) < 20)
						{
							if (CONSTRUCTOR.active && CONSTRUCTOR.moving)
							{
								CONSTRUCTOR.moving = false;
							}
							else if (CONSTRUCTOR.active) 
							{ 
								if (data[0] > CONSTRUCTOR.item.x + CONSTRUCTOR.item.width + 20 && data[0] < CONSTRUCTOR.item.x + CONSTRUCTOR.item.width + 76 && data[1] > CONSTRUCTOR.item.y && data[1] < CONSTRUCTOR.item.y + 56) //MOVE
								{
									if (CONSTRUCTOR.type == Selector.CAT_BACKGROUND)
									{
										FIELD_BACKGROUND.addBackground(CONSTRUCTOR.item_name, (CONSTRUCTOR.item.x + (camX / 2)) * 2, CONSTRUCTOR.item.y, 2, 1, 1);
									}
									else if (CONSTRUCTOR.type == Selector.CAT_OBJECTS)
									{
										FIELD_OBJECTS.addObject(CONSTRUCTOR.item_name, CONSTRUCTOR.item.x + camX, CONSTRUCTOR.item.y);
									}
									CONSTRUCTOR.destory(false);
									removeChild(CONSTRUCTOR);
								}
								else if (data[0] > CONSTRUCTOR.item.x + CONSTRUCTOR.item.width + 20 && data[0] < CONSTRUCTOR.item.x + CONSTRUCTOR.item.width + 76 && data[1] > CONSTRUCTOR.item.y + 70 && data[1] < CONSTRUCTOR.item.y + 126) //MOVE
								{
									CONSTRUCTOR.destory(true);
									removeChild(CONSTRUCTOR);
								}
							}
							else
							{
								var item:EditorItem = FIELD_OBJECTS.getObjectAt(data[0], data[1]);
								if (item != null)
								{
									CONSTRUCTOR.construct(item.item_name, item.type, item.x, item.y);
									addChildAt(CONSTRUCTOR, getChildIndex(FIELD_OBJECTS) + 1);
									return;
								}
								
								item = FIELD_BACKGROUND.getBackgroundAt(data[0], data[1]);
								if (item != null)
								{
									CONSTRUCTOR.construct(item.item_name, item.type, item.x, item.y);
									addChildAt(CONSTRUCTOR, getChildIndex(FIELD_BACKGROUND) + 1);
									return;
								}
							}
						}
						else
						{
							if (CONSTRUCTOR.active && CONSTRUCTOR.moving)
							{
								CONSTRUCTOR.moving = false;
							}
						}
					}
					else if (type == TouchType.SWIPE_START && CONSTRUCTOR.active)
					{
						CONSTRUCTOR.tryMove(data[0], data[1]);
					}
					else if (type == TouchType.SWIPE)
					{
						if (CONSTRUCTOR.moving)
						{
							CONSTRUCTOR.move(data[0], data[1]);
						}
						else
						{
							SCROLL.scroll(data[2]);
						}
					}
				}
				else if(data[0] > 1002 && data[0] < 1206 && data[1] > 467 && data[1] < 689) //SELECTOR BUILD
				{
					if (type == TouchType.CLICK)
					{
						if (!CONSTRUCTOR.active)
						{
							CONSTRUCTOR.construct(SELECTOR.current_items[SELECTOR.ITEM], SELECTOR.CAT);
							switch(SELECTOR.CAT)
							{
								case Selector.CAT_BACKGROUND: addChildAt(CONSTRUCTOR, getChildIndex(FIELD_BACKGROUND) + 1); break;
								case Selector.CAT_OBJECTS: addChildAt(CONSTRUCTOR, getChildIndex(FIELD_OBJECTS) + 1); break;
								case Selector.CAT_ENEMY: addChildAt(CONSTRUCTOR, getChildIndex(FIELD_ENEMIES) + 1); break;
								default: addChild(CONSTRUCTOR); break;
							}
						}
					}
				}
			}
		}
		
		public function tick():void
		{
			SCROLL.tick();
			
			FIELD_TILES.tick(camX);
			FIELD_BACKGROUND.tick(camX);
			FIELD_OBJECTS.tick(camX);
		}
		
		public function action(id:int):void
		{
			if (id == 10) //NEW
			{
				removeChild(FIELD_BACKGROUND);
				removeChild(FIELD_TILES);
				removeChild(FIELD_OBJECTS);
				removeChild(FIELD_ENEMIES);
				removeChild(SELECTOR);
				
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
				removeChild(SELECTOR);
				
				build();
			}
			else if (id == 13) //SAVE
			{
				trace(createJSONstring());
			}
			else if (id == 14) //SETTINGS
			{
				
			}
			else if (id == 15) //TEST
			{
				guiEditor.main.switchGui(new GuiGame("test", createJSONstring()));
			}
			else if (id == 20) //CAT LEFT
			{
				SELECTOR.switch_cat(-1);
			}
			else if (id == 21) //CAT RIGHT
			{
				SELECTOR.switch_cat(1);
			}
			else if (id == 22) //ITEM LEFT
			{
				SELECTOR.switch_item(-1);
			}
			else if (id == 23) //ITEM RIGHT
			{
				SELECTOR.switch_item(1);
			}
		}
		
		public function createJSONstring(name:String = "test", speed:int = 4):String
		{
			//SAVE FILE
			var saveFile:Object = new Object();
			
			//MAIN SETTINGS
			saveFile.name = name;
			saveFile.next_level_name = "editor";
			saveFile.id = 0;
			saveFile.speed = speed;
			
			//ZONES
			saveFile.zones = new Array();
			
			//ENEMIES
			saveFile.enemies = new Array();
			/*for (var i:int = 0; i < 1; i++ )
			{
				var en:Object = new Object();
				en.type = 0;
				en.spawnX = i * 100;
				en.spawnY = i * 200;
				saveFile.enemies.push(en);
			}*/
			
			//BACKGROUND
			saveFile.background_props = new Array();
			var backgroundLength:int = FIELD_BACKGROUND.BACKGROUND_CREATED.length;
			for (var j:int = 0; j < backgroundLength; j++ )
			{
				var bg:Object = new Object();
				bg.type = FIELD_BACKGROUND.BACKGROUND_CREATED[j].type;
				bg.depth = FIELD_BACKGROUND.BACKGROUND_CREATED[j].z;
				bg.x = FIELD_BACKGROUND.BACKGROUND_CREATED[j].posX;
				bg.y = FIELD_BACKGROUND.BACKGROUND_CREATED[j].y;
				saveFile.background_props.push(bg);
			}
			
			//OBJECTS
			saveFile.objects = new Array();
			
			var objectsLength:int = FIELD_OBJECTS.OBJECTS.length;
			for (var k:int = 0; k < objectsLength; k++ )
			{
				var obj:Object = new Object();
				obj.type = 0;
				obj.x = FIELD_OBJECTS.OBJECTS[k].posX;
				obj.y = FIELD_OBJECTS.OBJECTS[k].y + FIELD_OBJECTS.OBJECTS[k].height;
				saveFile.objects.push(obj);
			}
						
			var gate:Object = new Object();
			gate.type = 2;
			gate.x = FIELD_BACKGROUND.BACKGROUND_END.posX;
			gate.y = 800;
			saveFile.objects.push(gate);
			
			//TILES
			saveFile.tiles = new Array();
			var tileLength:int = FIELD_TILES.TILES_IDS.length;
			for (var l:int = 0; l < tileLength; l++ )
			{
				var ti:Object = new Object();
				ti.type = FIELD_TILES.TILES_IDS[l];
				saveFile.tiles.push(ti);
			}
			return com.adobe.serialization.json.JSON.encode(saveFile);
		}
		
		public function load(levelString:String):void
		{
			var saveFile:Object = com.adobe.serialization.json.JSON.decode(levelString);
			
			theme = Theme.SKY;
			var levelSize:int = saveFile.tiles.length;
			
			SELECTOR = new Selector();
			addChild(SELECTOR);
			SELECTOR.build(theme);
			
			camX = 0;
			maxX = levelSize * 127 - 1000;
			
			FIELD_BACKGROUND = new FieldBackground();
			FIELD_TILES = new FieldTiles();
			FIELD_OBJECTS = new FieldObjects();
			FIELD_ENEMIES = new FieldEnemies();
			
			addChildAt(FIELD_BACKGROUND, 0);
			addChildAt(FIELD_OBJECTS, 1);
			addChildAt(FIELD_TILES, 2);
			addChildAt(FIELD_ENEMIES, 3);
			
			CONSTRUCTOR = new Constructor();
			
			FIELD_BACKGROUND.buildFile(saveFile.background_props, levelSize * 127, theme);
			FIELD_TILES.buildFile(saveFile.tiles, theme);
			FIELD_OBJECTS.buildFile(saveFile.objects, theme);
			FIELD_ENEMIES.buildFile(saveFile.enemies);
		}
	}
}