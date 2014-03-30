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
	import myth.lang.Lang;
	import myth.data.GameData;

	public class GuiEditor extends GuiScreen
	{
		private var button_menu:GuiButton;
		public var button_create:GuiButton;
		private var button_load:GuiButton;
		
		private var button_creator_build:GuiButton;
		private var button_creator_theme:GuiButton;
		private var button_creator_size:GuiButton;
		
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
		private var button_editor_export:GuiButton;
		
		private var themes:Vector.<String> = new < String > ["Sky", "Earth", "Hell"];
		private var sizes:Vector.<String> = new < String > ["Small", "Normal", "Large"];
		private var theme_selected:int = 0;
		private var size_selected:int = 0;
		
		public var grey_screen:Shape;
		
		private var editor:Editor;
		public var inEditor:Boolean = false;
		
		private var levelString:String;
		
		public function GuiEditor(_levelString:String = null) 
		{
			levelString = _levelString;
		}
		
		override public function init():void 
		{ 
			editor = new Editor(this);
			addChild(editor);
			editor.init();
				
			button_editor_new = addButton(new GuiButton(10, TextureList.assets.getTexture("editor_button_small"), screenWidth - 255, 55, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.new"), 28)); button_editor_new.enabled = false;
			button_editor_menu = addButton(new GuiButton(11, TextureList.assets.getTexture("editor_button_small"), screenWidth - 93, 55, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.menu"), 28)); button_editor_menu.enabled = false;
			button_editor_load = addButton(new GuiButton(12, TextureList.assets.getTexture("editor_button_small"), screenWidth - 255, 155, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.load"), 28)); button_editor_load.enabled = false;
			button_editor_save = addButton(new GuiButton(13, TextureList.assets.getTexture("editor_button_small"), screenWidth - 93, 155, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.save"), 28)); button_editor_save.enabled = false;
			button_editor_settings = addButton(new GuiButton(14, TextureList.assets.getTexture("editor_button_small"), screenWidth - 255, 255, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.settings"), 28)); button_editor_settings.enabled = false;
			button_editor_test = addButton(new GuiButton(15, TextureList.assets.getTexture("editor_button_small"), screenWidth - 93, 255, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.test"), 28)); button_editor_test.enabled = false;
			button_editor_export = addButton(new GuiButton(16, TextureList.assets.getTexture("editor_button_small"), screenWidth - 255, 355, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.export"), 28)); button_editor_export.enabled = false;
			if (!GameData.DEVELOPMENT) { button_editor_export.visible = false; }
			
			button_cat_left = addButton(new GuiButton(20, TextureList.assets.getTexture("editor_arrow_left"), screenWidth - 310, screenHeight - 280, 60, 60, "")); button_cat_left.enabled = false;
			button_cat_right = addButton(new GuiButton(21, TextureList.assets.getTexture("editor_arrow_right"), screenWidth - 40, screenHeight - 280, 60, 60, "")); button_cat_right.enabled = false;
			button_item_left = addButton(new GuiButton(22, TextureList.assets.getTexture("editor_arrow_left"), screenWidth - 310, screenHeight - 80, 60, 60, "")); button_item_left.enabled = false;
			button_item_right = addButton(new GuiButton(23, TextureList.assets.getTexture("editor_arrow_right"), screenWidth - 40, screenHeight - 80, 60, 60, "")); button_item_right.enabled = false;
			
			grey_screen = new Shape();
			grey_screen.graphics.lineStyle(0, 0x555555, 0.8);
			grey_screen.graphics.beginFill(0x555555, 0.8);
			grey_screen.graphics.drawRect(0, 0, 1280, 768);
			addChild(grey_screen);
			
			button_menu = addButton(new GuiButton(0, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0x000000, "GameFont"));
			button_create = addButton(new GuiButton(1, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 60, 450, 100, Lang.trans(Lang.EDITOR, "menu.create"), 45, 0x000000, "GameFont"));
			button_load = addButton(new GuiButton(2, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, Lang.trans(Lang.EDITOR, "menu.load"), 45, 0x000000, "GameFont"));
				
			button_creator_build = addButton(new GuiButton(3, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 250, 450, 100, "Create level", 45, 0x000000, "GameFont"));
			button_creator_theme = addButton(new GuiButton(4, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 50, 450, 100, "Theme: Sky", 45, 0x000000, "GameFont"));
			button_creator_size = addButton(new GuiButton(5, TextureList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 70, 450, 100, "Size: Small", 45, 0x000000, "GameFont"));
			
			create_menu(false);
			
			if (levelString != null)
			{
				menu_main(false);
				editor_menu(true);
				editor.load(levelString, true);
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
				main.switchGui(new GuiMainMenu(), true);
			}
			else if (b.buttonID == 1) //CREATE 
			{
				menu_main(false);
				create_menu(true);
				grey_screen.visible = true;
			}
			else if (b.buttonID == 2) //LOAD 
			{
			}
			else if (b.buttonID == 3) //BUILD EDITOR
			{
				var s:int = 0;
				switch(size_selected)
				{
					case 0: s = 70; break;
					case 1: s = 100; break;
					case 2: s = 130; break;
				}
				
				create_menu(false);
				editor_menu(true);
				editor.build(theme_selected, s);
				inEditor = true;
				grey_screen.visible = false;
			}
			else if (b.buttonID == 4) //THEME
			{
				theme_selected++;
				if (theme_selected > 2) { theme_selected = 0; }
				button_creator_theme.buttonText.text = "Theme: " + themes[theme_selected];
			}
			else if (b.buttonID == 5) //SIZE
			{
				size_selected++;
				if (size_selected > 2) { size_selected = 0; }
				button_creator_size.buttonText.text = "Size: " + sizes[size_selected];
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
		
		public function create_menu(e:Boolean):void
		{
			button_creator_build.visible = e;
			button_creator_build.enabled = e;
			button_creator_theme.visible = e;
			button_creator_theme.enabled = e;
			button_creator_size.visible = e;
			button_creator_size.enabled = e;
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
			
			if (GameData.DEVELOPMENT)
			{
				button_editor_export.enabled = e;
			}
		}
	}
}