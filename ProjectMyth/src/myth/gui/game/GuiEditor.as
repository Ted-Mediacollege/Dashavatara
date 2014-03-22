package myth.gui.game 
{
	import myth.editor.Editor;
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.TextureList;
	import myth.gui.background.GuiBackground;
	import myth.gui.game.GuiMainMenu;
	import myth.editor.EditorFiles;
	import starling.display.Shape;
	import starling.events.TouchEvent;

	public class GuiEditor extends GuiScreen
	{
		private var button_menu:GuiButton;
		private var button_create:GuiButton;
		private var button_load:GuiButton;
		
		private var button_cat_left:GuiButton;
		private var button_cat_right:GuiButton;
		private var button_item_left:GuiButton;
		private var button_item_right:GuiButton;
		
		private var button_editor_new:GuiButton;
		private var button_editor_menu:GuiButton;
		private var button_editor_load:GuiButton;
		private var button_editor_save:GuiButton;
		private var button_editor_settings:GuiButton;
		private var button_editor_test:GuiButton;
		
		private var grey_screen:Shape;
		
		private var editor:Editor;
		public var inEditor:Boolean = false;
		
		private var levelString:String;
		
		public function GuiEditor(_levelString:String = null) 
		{
			levelString = _levelString;
		}
		
		override public function init():void 
		{ 
			background = null;
			
			editor = new Editor(this);
			addChild(editor);
			editor.init();
				
			button_editor_new = addButton(new GuiButton(10, TextureList.assets.getTexture("editor_button_small"), screenWidth - 255, 55, 147, 85, "New", 28)); button_editor_new.enabled = false;
			button_editor_menu = addButton(new GuiButton(11, TextureList.assets.getTexture("editor_button_small"), screenWidth - 93, 55, 147, 85, "Menu", 28)); button_editor_menu.enabled = false;
			button_editor_load = addButton(new GuiButton(12, TextureList.assets.getTexture("editor_button_small"), screenWidth - 255, 155, 147, 85, "Load", 28)); button_editor_load.enabled = false;
			button_editor_save = addButton(new GuiButton(13, TextureList.assets.getTexture("editor_button_small"), screenWidth - 93, 155, 147, 85, "Save", 28)); button_editor_save.enabled = false;
			button_editor_settings = addButton(new GuiButton(14, TextureList.assets.getTexture("editor_button_small"), screenWidth - 255, 255, 147, 85, "Settings", 28)); button_editor_settings.enabled = false;
			button_editor_test = addButton(new GuiButton(15, TextureList.assets.getTexture("editor_button_small"), screenWidth - 93, 255, 147, 85, "Test", 28)); button_editor_test.enabled = false;
				
			button_cat_left = addButton(new GuiButton(20, TextureList.assets.getTexture("editor_arrow_left"), screenWidth - 310, screenHeight - 340, 60, 60, "")); button_cat_left.enabled = false;
			button_cat_right = addButton(new GuiButton(21, TextureList.assets.getTexture("editor_arrow_right"), screenWidth - 40, screenHeight - 340, 60, 60, "")); button_cat_right.enabled = false;
			button_item_left = addButton(new GuiButton(22, TextureList.assets.getTexture("editor_arrow_left"), screenWidth - 310, screenHeight - 140, 60, 60, "")); button_item_left.enabled = false;
			button_item_right = addButton(new GuiButton(23, TextureList.assets.getTexture("editor_arrow_right"), screenWidth - 40, screenHeight - 140, 60, 60, "")); button_item_right.enabled = false;
			
			grey_screen = new Shape();
			grey_screen.graphics.lineStyle(0, 0x555555, 0.8);
			grey_screen.graphics.beginFill(0x555555, 0.8);
			grey_screen.graphics.drawRect(0, 0, 1280, 768);
			addChild(grey_screen);
			
			button_menu = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, "Main Menu", 25, 0x000000));
			button_create = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 60, 450, 100, "Create Level", 25, 0x000000));
			button_load = addButton(new GuiButton(2, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, "Load Level", 25, 0x000000));
				
			if (levelString != null)
			{
				menu_main(false);
				editor_menu(true);
				editor.load(levelString);
				inEditor = true;
				grey_screen.visible = false;
			}
		}
		
		override public function tick():void 
		{ 
			if (inEditor)
			{
				editor.tick();
			}
		}
		
		override public function input(type:int, data:Vector.<Number>, e:TouchEvent):void 
		{ 
			if (inEditor)
			{
				editor.input(type, data, e);
			}
		}
		
		override public function action(b:GuiButton):void 
		{ 
			if (b.buttonID == 0) //BACK TO MAIN GAME MENU
			{
				main.switchGui(new GuiMainMenu());
			}
			else if (b.buttonID == 1) //CREATE NEW (MAIN EDITOR MENU)
			{
				menu_main(false);
				editor_menu(true);
				editor.build();
				inEditor = true;
				grey_screen.visible = false;
			}
			else if (b.buttonID == 2) //LOAD (MAIN EDITOR MENU)
			{
				menu_main(false);
				editor_menu(true);
				editor.build();
				inEditor = true;
				grey_screen.visible = false;
			}
			else if (b.buttonID > 9 && b.buttonID < 30)
			{
				editor.action(b.buttonID);
			}
		}
		
		override public function destroy():void 
		{ 
		}
		
		public function menu_main(e:Boolean):void
		{
			button_menu.enabled = e;
			button_create.enabled = e;
			button_load.enabled = e;
			button_menu.visible = e;
			button_create.visible = e;
			button_load.visible = e;
		}
		
		public function editor_menu(e:Boolean):void
		{
			button_cat_left.enabled = e;
			button_cat_right.enabled = e;
			button_item_left.enabled = e;
			button_item_right.enabled = e;
			
			button_editor_new.enabled = e;
			button_editor_menu.enabled = e;
			button_editor_load.enabled = e;
			button_editor_save.enabled = e;
			button_editor_settings.enabled = e;
			button_editor_test.enabled = e;
		}
	}
}