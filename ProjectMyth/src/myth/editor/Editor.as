package myth.editor 
{
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import myth.background.Background;
	import myth.data.Theme;
	import myth.editor.component.EditorAlert;
	import myth.editor.component.EditorConstructor;
	import myth.editor.component.EditorScroll;
	import myth.editor.component.EditorSelector;
	import myth.editor.field.FieldBackground;
	import myth.editor.field.FieldEnemies;
	import myth.editor.field.FieldObjects;
	import myth.editor.field.FieldTiles;
	import myth.gui.components.GuiButton;
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
	import myth.lang.Lang;
	import flash.utils.ByteArray;
	import flash.net.FileReference;
	import flash.events.Event;
	import flash.display.LoaderInfo;
	
	public class Editor extends Sprite
	{		
		public static var theme:int;
		
		public static var camX:Number;
		public static var maxX:Number;
		
		public var guiEditor:GuiEditor;
		
		public var SCROLL:EditorScroll;
		public var SELECTOR:EditorSelector;
		public var CONSTRUCTOR:EditorConstructor;
		
		public var FIELD_BACKGROUND:FieldBackground;
		public var FIELD_TILES:FieldTiles;
		public var FIELD_OBJECTS:FieldObjects;
		public var FIELD_ENEMIES:FieldEnemies;
		
		public var alertBox:EditorAlert;
		public var alerting:Boolean;
		
		public var saved:Boolean;
		
		public var fileref:FileReference;
		public var fileLoader:Loader;

		public function Editor(gui:GuiEditor) 
		{
			guiEditor = gui;
		}	
		
		public function init():void
		{
			SCROLL = new EditorScroll();
			addChild(SCROLL);
			
			var a1:Image = new Image(TextureList.assets.getTexture("editor_panel_main"));
			a1.x = 1280 - 350;
			addChild(a1);
			
			alerting = false;
		}
		
		public function build(t:int, s:int):void
		{
			theme = t;
			var levelSize:int = 25; //s
			Theme.MENU_THEME = theme;
			
			SELECTOR = new EditorSelector();
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
			
			CONSTRUCTOR = new EditorConstructor(this);
			saved = true;
		}
		
		public function alert(actionID:int, title_string:String, text_string:String, yes_string:String, no_string:String):void
		{
			alertBox = new EditorAlert(actionID, title_string, text_string, yes_string, no_string);
			guiEditor.addChild(alertBox);
			guiEditor.grey_screen.visible = true;
			alerting = true;
		}
		
		public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{ 
			if (type == TouchType.SWIPE || type == TouchType.CLICK || type == TouchType.SWIPE_START)
			{
				if (alerting)
				{
					if (type == TouchType.CLICK)
					{			
						var alertX:Number = data[0] - alertBox.x;
						var alertY:Number = data[1] - alertBox.y;
						
						if (alertX < 0 && alertX > -220 && alertY > 70 && alertY < 150)
						{
							var id:int = alertBox.actionID;
							guiEditor.removeChild(alertBox);
							guiEditor.grey_screen.visible = false;
							alertBox = null;
							alerting = false;
							action(id, true);
							return;
						}
						else if (alertX > 0 && alertX < 220 && alertY > 70 && alertY < 150)
						{
							guiEditor.removeChild(alertBox);
							guiEditor.grey_screen.visible = false;
							alertBox = null;
							alerting = false;
							return;
						}
					}
				}
				else if (data[0] < 930 && data[1] < 728) //FIELDS
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
								CONSTRUCTOR.action(data[0], data[1]);
							}
							else
							{
								var item:EditorItem = FIELD_OBJECTS.getObjectAt(data[0], data[1]);
								if (item != null)
								{
									CONSTRUCTOR.construct(item.item_name, 0, item.type, item.x, item.y);
									addChildAt(CONSTRUCTOR, getChildIndex(FIELD_OBJECTS) + 1);
									return;
								}
								
								item = FIELD_BACKGROUND.getBackgroundAt(data[0], data[1]);
								if (item != null)
								{
									CONSTRUCTOR.construct(item.item_name, 1, item.type, item.x, item.y, item.rotation);
									addChildAt(CONSTRUCTOR, getChildIndex(FIELD_BACKGROUND) + 1);
									return;
								}
								
								item = FIELD_ENEMIES.getEnemiesAt(data[0], data[1]);
								if (item != null)
								{
									CONSTRUCTOR.construct(item.item_name, 2, item.type, item.x, item.y);
									addChildAt(CONSTRUCTOR, getChildIndex(FIELD_ENEMIES) + 1);
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
						if (CONSTRUCTOR.toolActive)
						{
							if (!CONSTRUCTOR.swipeAction(data[0], data[1]))
							{
								CONSTRUCTOR.tool.destroy();
								CONSTRUCTOR.toolActive = false;
								CONSTRUCTOR.tool = null;
								CONSTRUCTOR.tryMove(data[0], data[1]);
							}
						}
						else
						{
							CONSTRUCTOR.tryMove(data[0], data[1]);
						}
					}
					else if (type == TouchType.SWIPE)
					{
						if (CONSTRUCTOR.toolActive)
						{
							if (!CONSTRUCTOR.swipeAction(data[0], data[1]))
							{
								CONSTRUCTOR.tool.destroy();
								CONSTRUCTOR.toolActive = false;
								CONSTRUCTOR.tool = null;
								
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
						else
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
				}
				else if(data[0] > 1002 && data[0] < 1206 && data[1] > 537 && data[1] < 759) //SELECTOR BUILD
				{
					if (type == TouchType.CLICK)
					{
						if (!CONSTRUCTOR.active)
						{
							saved = false;
							CONSTRUCTOR.construct(SELECTOR.current_items[SELECTOR.ITEM], SELECTOR.CAT, SELECTOR.ITEM);
							switch(SELECTOR.CAT)
							{
								case EditorSelector.CAT_BACKGROUND: addChildAt(CONSTRUCTOR, getChildIndex(FIELD_BACKGROUND) + 1); break;
								case EditorSelector.CAT_OBJECTS: addChildAt(CONSTRUCTOR, getChildIndex(FIELD_OBJECTS) + 1); break;
								case EditorSelector.CAT_ENEMY: addChildAt(CONSTRUCTOR, getChildIndex(FIELD_ENEMIES) + 1); break;
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
			FIELD_ENEMIES.tick(camX);
		}
		
		public function action(id:int, fromAlert:Boolean = false):void
		{
			if (alerting)
			{
				return;
			}
			else if (!fromAlert && !saved && (id == 10 || id == 11 || id == 12 || id == 17)) //ALERT
			{
				switch(id)
				{
					case 10: alert(10, Lang.trans(Lang.EDITOR, "alert.warning"), Lang.trans(Lang.EDITOR, "alert.save_new"), Lang.trans(Lang.EDITOR, "alert.yes"), Lang.trans(Lang.EDITOR, "alert.no")); break;
					case 11: alert(11, Lang.trans(Lang.EDITOR, "alert.warning"), Lang.trans(Lang.EDITOR, "alert.save_menu"), Lang.trans(Lang.EDITOR, "alert.yes"), Lang.trans(Lang.EDITOR, "alert.no")); break;
					case 12: alert(12, Lang.trans(Lang.EDITOR, "alert.warning"), Lang.trans(Lang.EDITOR, "alert.save_load"), Lang.trans(Lang.EDITOR, "alert.yes"), Lang.trans(Lang.EDITOR, "alert.no")); break;
					case 17: alert(17, Lang.trans(Lang.EDITOR, "alert.warning"), Lang.trans(Lang.EDITOR, "alert.save_import"), Lang.trans(Lang.EDITOR, "alert.yes"), Lang.trans(Lang.EDITOR, "alert.no")); break;
				}
			}
			else if (id == 10) //NEW
			{
				removeChild(FIELD_BACKGROUND);
				removeChild(FIELD_TILES);
				removeChild(FIELD_OBJECTS);
				removeChild(FIELD_ENEMIES);
				removeChild(SELECTOR);
				CONSTRUCTOR.destory(false);
				removeChild(CONSTRUCTOR);
				
				guiEditor.action(guiEditor.button_create);
			}
			else if (id == 11) //MENU
			{
				guiEditor.main.switchGui(new GuiMainMenu(), true);
			}
			else if (id == 12) //LOAD
			{
				
			}
			else if (id == 13) //SAVE
			{
				trace(createJSONstring());
				saved = true;
			}
			else if (id == 14) //SETTINGS
			{
				
			}
			else if (id == 15) //TEST
			{
				if (CONSTRUCTOR.active) 
				{ 
					if (CONSTRUCTOR.type == EditorSelector.CAT_BACKGROUND)
					{
						FIELD_BACKGROUND.addBackground(CONSTRUCTOR.item_name, CONSTRUCTOR.type, (CONSTRUCTOR.item.x + (camX / 2)) * 2, CONSTRUCTOR.item.y, 2, CONSTRUCTOR.item.rotation, 1, 1);
					}
					else if (CONSTRUCTOR.type == EditorSelector.CAT_OBJECTS)
					{
						FIELD_OBJECTS.addObject(CONSTRUCTOR.item_name, CONSTRUCTOR.type, CONSTRUCTOR.item.x + camX, CONSTRUCTOR.item.y);
					}
					else if (CONSTRUCTOR.type == EditorSelector.CAT_ENEMY)
					{
						FIELD_ENEMIES.addEnemies(CONSTRUCTOR.item_name, CONSTRUCTOR.type, CONSTRUCTOR.item.x + camX, CONSTRUCTOR.item.y);
					}
					CONSTRUCTOR.destory(false);
					removeChild(CONSTRUCTOR);
				}
								
				guiEditor.main.switchGui(new GuiGame("test", createJSONstring()));
			}
			else if (id == 16) //EXPORT
			{
				export(createJSONstring());
			}
			else if (id == 17) //IMPORT
			{
				importer();
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
		
		public function createJSONstring(name:String = "test", speed:int = 6):String
		{
			//SAVE FILE
			var saveFile:Object = new Object();
			
			//MAIN SETTINGS
			saveFile.name = name;
			saveFile.next_level_name = "editor";
			saveFile.id = 0;
			saveFile.speed = speed;
			saveFile.theme = theme;
			
			//ZONES
			saveFile.zones = new Array();
			
			//ENEMIES
			FIELD_ENEMIES.saveData(saveFile);
			FIELD_ENEMIES.sortData(saveFile);
			
			//BACKGROUND
			FIELD_BACKGROUND.saveData(saveFile);
			
			//OBJECTS
			FIELD_OBJECTS.saveData(saveFile);
			FIELD_OBJECTS.sortData(saveFile);
			
			var gate:Object = new Object();
			gate.type = 2;
			gate.x = FIELD_BACKGROUND.BACKGROUND_END.posX;
			gate.y = 670;
			saveFile.objects.push(gate);
			
			//TILES
			FIELD_TILES.saveData(saveFile);
			
			return com.adobe.serialization.json.JSON.encode(saveFile);
		}
		
		public function load(levelString:String, fromTesting:Boolean = false):void
		{
			var saveFile:Object = com.adobe.serialization.json.JSON.decode(levelString);
			
			theme = saveFile.theme;
			var levelSize:int = saveFile.tiles.length;
			Theme.MENU_THEME = theme;
			
			SELECTOR = new EditorSelector();
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
			
			CONSTRUCTOR = new EditorConstructor(this);
			
			FIELD_BACKGROUND.buildFile(saveFile.background_props, levelSize * 127, theme);
			FIELD_TILES.buildFile(saveFile.tiles, theme);
			FIELD_OBJECTS.buildFile(saveFile.objects, theme);
			FIELD_ENEMIES.buildFile(saveFile.enemies);
			
			saved = !fromTesting;
		}
		
		public function export(s:String):void
		{
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeUTFBytes(s);
			var fileref:FileReference = new FileReference();
			fileref.save(byteArray, "test_level.json");
		}
		
		public function importer(r:Boolean = true):void
		{
			fileref = new FileReference();         
			fileref.addEventListener(Event.SELECT, startImporting);
			fileref.addEventListener(Event.CANCEL, cancelImport);
			fileref.addEventListener(IOErrorEvent.IO_ERROR, importErrorIO);
			fileref.addEventListener(SecurityErrorEvent.SECURITY_ERROR, importErrorSecurity);
			fileref.browse();
			
			if (r)
			{
				removeChild(FIELD_BACKGROUND);
				removeChild(FIELD_TILES);
				removeChild(FIELD_OBJECTS);
				removeChild(FIELD_ENEMIES);
				removeChild(SELECTOR);
				CONSTRUCTOR.destory(false);
				removeChild(CONSTRUCTOR);
			}
			
			guiEditor.editor_menu(false);
			guiEditor.grey_screen.visible = true;
		}
		
		public function cancelImport(e:Event):void
		{
			guiEditor.menu_main(true);
			guiEditor.grey_screen.visible = true;
		}
		
		public function startImporting(e:Event):void
		{
			fileref.removeEventListener(IOErrorEvent.IO_ERROR, importErrorIO);
			fileref.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, importErrorSecurity);
            fileref.removeEventListener(Event.SELECT, startImporting);
            fileref.addEventListener(Event.COMPLETE, dataImported);
			fileref.addEventListener(IOErrorEvent.IO_ERROR, importErrorIO);
			fileref.addEventListener(SecurityErrorEvent.SECURITY_ERROR, importErrorSecurity);
            fileref.load();   
		}
		
		public function importErrorIO(e:Event):void
		{
			guiEditor.menu_main(true);
			guiEditor.grey_screen.visible = true;
		}
		
		public function importErrorSecurity(e:Event):void
		{
			guiEditor.menu_main(true);
			guiEditor.grey_screen.visible = true;
		}
		
        private function dataImported(e:Event):void
        {            
			fileref.removeEventListener(IOErrorEvent.IO_ERROR, importErrorIO);
			fileref.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, importErrorSecurity);
            fileref.removeEventListener(Event.COMPLETE, dataImported);
			load(fileref.data.toString(), false);
			guiEditor.menu_main(false);
			guiEditor.create_menu(false);
			guiEditor.editor_menu(true);
			guiEditor.inEditor = true;
			guiEditor.grey_screen.visible = false;
			saved = true;
        }
	}
}