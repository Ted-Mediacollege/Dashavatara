package myth.gui.game 
{
	import myth.editor.Editor;
	import myth.gui.GuiScreen;
	import myth.gui.components.GuiButton;
	import myth.input.TouchType;
	import myth.gui.components.GuiText;
	import myth.graphics.AssetList;
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
		private var button_import:GuiButton;
		
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
		private var button_editor_import:GuiButton;
		
		private var themes:Vector.<String>;
		private var sizes:Vector.<String>;
		private var theme_selected:int = 0;
		private var size_selected:int = 0;
		
		public var grey_screen:Shape;
		
		private var editor:Editor;
		public var inEditor:Boolean = false;
		
		private var levelString:String;
		public var saveFileID:int;
		
		public function GuiEditor(_levelString:String = null, saveID:int = -1) 
		{
			levelString = _levelString;
			saveFileID = saveID;
		}
		
		override public function init():void 
		{ 
			editor = new Editor(this);
			addChild(editor);
			editor.init();
			
			themes = new < String > [Lang.trans(Lang.EDITOR, "settings.sky"), Lang.trans(Lang.EDITOR, "settings.earth"), Lang.trans(Lang.EDITOR, "settings.hell")];
			sizes = new < String > [Lang.trans(Lang.EDITOR, "settings.small"), Lang.trans(Lang.EDITOR, "settings.normal"), Lang.trans(Lang.EDITOR, "settings.large")];

			button_editor_new = addButton(new GuiButton(10, AssetList.assets.getTexture("editor_button_small"), screenWidth - 255, 65, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.new"), 35, 0xf1d195, "GameFont")); button_editor_new.enabled = false;
			button_editor_menu = addButton(new GuiButton(11, AssetList.assets.getTexture("editor_button_small"), screenWidth - 93, 65, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.menu"), 35, 0xf1d195, "GameFont")); button_editor_menu.enabled = false;
			button_editor_load = addButton(new GuiButton(12, AssetList.assets.getTexture("editor_button_small"), screenWidth - 255, 255, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.load"), 35, 0xf1d195, "GameFont")); button_editor_load.enabled = false;
			button_editor_save = addButton(new GuiButton(13, AssetList.assets.getTexture("editor_button_small"), screenWidth - 93, 255, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.save"), 35, 0xf1d195, "GameFont")); button_editor_save.enabled = false;
			button_editor_settings = addButton(new GuiButton(14, AssetList.assets.getTexture("editor_button_small"), screenWidth - 255, 155, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.settings"), 35, 0xf1d195, "GameFont")); button_editor_settings.enabled = false;
			button_editor_test = addButton(new GuiButton(15, AssetList.assets.getTexture("editor_button_small"), screenWidth - 93, 155, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.test"), 35, 0xf1d195, "GameFont")); button_editor_test.enabled = false;
			button_editor_export = addButton(new GuiButton(16, AssetList.assets.getTexture("editor_button_small"), screenWidth - 255, 355, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.export"), 35, 0xf1d195, "GameFont")); button_editor_export.enabled = false;
			button_editor_import = addButton(new GuiButton(17, AssetList.assets.getTexture("editor_button_small"), screenWidth - 93, 355, 147, 85, Lang.trans(Lang.EDITOR, "side_menu.import"), 35, 0xf1d195, "GameFont")); button_editor_import.enabled = false;

			if (!GameData.ISCOMPUTER)
			{
				button_editor_export.visible = false;
				button_editor_import.visible = false;
			}
			
			button_cat_left = addButton(new GuiButton(20, AssetList.assets.getTexture("editor_arrow_left"), screenWidth - 300, screenHeight - 280, 60, 60, "")); button_cat_left.enabled = false;
			button_cat_right = addButton(new GuiButton(21, AssetList.assets.getTexture("editor_arrow_right"), screenWidth - 50, screenHeight - 280, 60, 60, "")); button_cat_right.enabled = false;
			button_item_left = addButton(new GuiButton(22, AssetList.assets.getTexture("editor_arrow_left"), screenWidth - 300, screenHeight - 80, 60, 60, "")); button_item_left.enabled = false;
			button_item_right = addButton(new GuiButton(23, AssetList.assets.getTexture("editor_arrow_right"), screenWidth - 50, screenHeight - 80, 60, 60, "")); button_item_right.enabled = false;
			
			grey_screen = new Shape();
			grey_screen.graphics.lineStyle(0, 0x555555, 0.8);
			grey_screen.graphics.beginFill(0x555555, 0.8);
			grey_screen.graphics.drawRect(0, 0, 1280, 768);
			addChild(grey_screen);
			
			button_menu = addButton(new GuiButton(0, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 330, 450, 100, Lang.trans(Lang.MENU, "main.back"), 45, 0xf1d195, "GameFont"));
			button_create = addButton(new GuiButton(1, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 180, 450, 100, Lang.trans(Lang.EDITOR, "menu.create"), 45, 0xf1d195, "GameFont"));
			button_load = addButton(new GuiButton(2, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 60, 450, 100, Lang.trans(Lang.EDITOR, "menu.load"), 45, 0xf1d195, "GameFont"));
			button_import = addButton(new GuiButton(9, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 60, 450, 100, Lang.trans(Lang.EDITOR, "menu.import"), 45, 0xf1d195, "GameFont"));

			if (!GameData.ISCOMPUTER)
			{
				button_import.visible = false;
				button_import.enabled = false;
			}
			
			button_creator_build = addButton(new GuiButton(3, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 250, 450, 100, Lang.trans(Lang.EDITOR, "menu.create"), 45, 0xf1d195, "GameFont"));
			button_creator_theme = addButton(new GuiButton(4, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 - 50, 450, 100, Lang.trans(Lang.EDITOR, "menu.theme") + ": " + themes[0], 45, 0xf1d195, "GameFont"));
			button_creator_size = addButton(new GuiButton(5, AssetList.assets.getTexture("gui_button_default"), screenWidth / 2, screenHeight / 2 + 70, 450, 100, Lang.trans(Lang.EDITOR, "menu.size") + ": " + sizes[0], 45, 0xf1d195, "GameFont"));
			
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
			super.tick();
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
				main.switchGui(new GuiEditorLoad());
			}
			else if (b.buttonID == 3) //BUILD EDITOR
			{
				var s:int = 0;
				switch(size_selected)
				{
					case 0: s = 90; break;
					case 1: s = 145; break;
					case 2: s = 200; break;
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
				button_creator_theme.buttonText.text = Lang.trans(Lang.EDITOR, "menu.theme") + ": " + themes[theme_selected];
			}
			else if (b.buttonID == 5) //SIZE
			{
				size_selected++;
				if (size_selected > 2) { size_selected = 0; }
				button_creator_size.buttonText.text = Lang.trans(Lang.EDITOR, "menu.size") + ": " + sizes[size_selected];
			}
			else if (b.buttonID == 9)
			{
				menu_main(false);
				editor.importer(false);
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
			button_import.enabled = e;
			button_menu.visible = e;
			button_create.visible = e;
			button_load.visible = e;
			button_import.visible = e;
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
			
			if (GameData.ISCOMPUTER)
			{
				button_editor_export.enabled = e;
				button_editor_import.enabled = e;
			}
		}
	}
}